const app = require("express")();                                   // Server
const cors = require("cors");                                       // Cross-origin resource sharing
const axios = require("axios").default.create();                    // HTTP requests
const fs = require("fs");                                           // Files
const ebml = require("ebml");                                       // MKV parsing
const { exec } = require("child_process");                          // Commands
const { windowManager, addon } = require("node-window-manager");    // Windows
const portFinder = require("portfinder");                           // Port finding
const { ip } = require("address");                                  // IP address information
const delay = require("delay");                                     // Awaitable timeout
const print = console.log;                                          // Log shortcut

require("app-module-path").addPath(`${__dirname}`);

let { vlcPath } = fs.existsSync("server/data.json") && require("./data");

app.use(cors());

// EXTRA FILE INFO
// Supports: MKV
app.get("/extra_info", async (req, res) => {
    print(`Extra Info GET request: ${JSON.stringify(req.query)}`);

    const uri = decodeURIComponent(req.query["uri"].replace("file:///", ""));
    const extension = uri.split(".").pop().toLowerCase();

    switch(extension) {
        case "mkv":
            mkvExtraInfo(res, uri);
            break;
        default:
            res.sendStatus(415); // Unsupported Media Type
    }
});

/**
 * Gets the extra info (duration and chapters) of a MKV file
 * @param {Response} res The HTTP response to use
 * @param {String} uri
 */
function mkvExtraInfo(res, uri) {
    const decoder = new ebml.Decoder();
    const chapters = [];
    let duration, timeStampScale = 1000000;

    res.setHeader("Content-Type", "application/json");

    let containsChaptersElement, containsInfoElement, chaptersRead, infoRead, chaptersSent, infoSent;
    const mkvReadStream = fs.createReadStream(uri);
    res.status(200);
    const mkvWriteStream = mkvReadStream.pipe(decoder)
        .on("data", chunk => {
            if(chunk[0] == "tag") {
                switch(chunk[1].name) {
                    case "ChapterTimeStart":
                        chapters.push(chunk[1].value);
                        break;
                    case "SeekID":
                        const seekId = chunk[1].data.toString("hex");
                        containsChaptersElement = containsChaptersElement || seekId == "1043a770";
                        containsInfoElement = containsInfoElement || seekId == "1549a966";
                        break;
                    case "Duration":
                        duration = chunk[1].value;
                        break;
                    case "TimestampScale":
                    case "TimecodeScale":
                        timeStampScale = chunk[1].value;
                        break;
                    default:
                        break;
                }
            } else if(chunk[0] == "end") {
                switch(chunk[1].name) {
                    case "Chapters" :
                        chaptersRead = true;
                        if(!chaptersSent) {
                            res.write(JSON.stringify({
                                chapters: chapters.map(chapter => Math.ceil(chapter / 1000000000)),
                            }));
                            chaptersSent = true;
                        }
                        break;
                    case "Info":
                        infoRead = true;
                        if(!infoSent) {
                            res.write(JSON.stringify({
                                duration: ~~(duration * timeStampScale / 60000000000),
                            }));
                            infoSent = true;
                        }
                        break;
                    case "SeekHead":
                        chaptersRead = chaptersRead || !containsChaptersElement;
                        infoRead = infoRead || !containsInfoElement;
                        break;
                    default:
                        break;
                }

                if(chaptersRead && infoRead) {
                    res.end();
                    mkvWriteStream.end();
                    mkvReadStream.close();
                }
            }
        });
}

// CHECK PASSWORD
app.get("/check_password", async (req, res) => {
    print(`Check Password GET request: ${JSON.stringify(req.query)}`);

    const password = req.query["password"];
    const port = req.query["port"];
    try {
        await axios.get(`http://localhost:${port}/requests/status.json`, { auth: { password } })
        res.send(true);
    } catch {
        res.send(false);
    }
});

// CHECK PORT NUMBER
app.get("/check_port_number", async (req, res) => {
    print(`Check Port Number GET request: ${JSON.stringify(req.query)}`);

    const port = req.query["port"];
    try {
        await axios.get(`http://localhost:${port}/requests/status.json`);
        // A 401 error would have been thrown if VLC was running on this port since we didn't pass any auth information
        res.send(false);
    } catch(error) {
        // TODO: check if the www-authenticate header is the same for all versions of VLC, adapt if necessary
        res.send(error.response !== undefined && error.response.headers["www-authenticate"] === "Basic realm=\"VLC stream\"");
    }
});

// CLOSE VLC
app.get("/close_vlc", (_, res) => {
    print(`Close VLC GET request`);

    const vlc = getVlcWindow();
    if(vlc) process.kill(vlc.processId);
    res.sendStatus(200);
});

// LOCATE VLC
app.get("/locate_vlc", (_, res) => {
    print(`Locate VLC GET request`);

    if(vlcPath) return res.sendStatus(200);
    let timeout = setVlcTimeout();

    function setVlcTimeout() {
        return setTimeout(() => {
            if(timeout) clearTimeout(timeout);
            const vlc = getVlcWindow();
            vlcPath = vlc && vlc.path;
            if(vlcPath) {
                fs.writeFile("server/data.json", JSON.stringify({ vlcPath }), err => {
                    if(err) print(err);
                    else res.sendStatus(200);
                });
            } else timeout = setVlcTimeout();
        }, 500);
    }
});

// OPEN VLC
app.get("/open_vlc", async (_, res) => {
    print(`Open VLC GET request`);

    let vlc = getVlcWindow();
    if(!vlc) {
        if(!vlcPath) {
            return res.status(404).json({
                error: "vlc_path_not_located"
            });
        }
        exec(`"${vlcPath}"`);
        do {
            await delay(100);
            vlc = getVlcWindow();
        } while(!vlc);
    }
    vlc.bringToTop();
    res.sendStatus(200);
});

// SWITCH SCREEN
app.get("/switch_screen", (_, res) => {
    print(`Switch Screen GET request`);

    const vlc = getVlcWindow();
    if(vlc) {
        const monitors = windowManager.getMonitors();
        const currentMonitor = vlc.getMonitor();
        const nextMonitorIndex = (monitors.findIndex(monitor => monitor.id == currentMonitor.id) + 1) % monitors.length;
        sendWindowToMonitor(vlc, monitors[nextMonitorIndex]);
        vlc.bringToTop();
        res.json({
            current_screen: nextMonitorIndex + 1
        });
    } else {
        res.status(404).json({
            error: "vlc_window_not_found"
        });
    }
});

function sendWindowToMonitor(window, monitor) {
    const sf = monitor.getScaleFactor();
    const windowBounds = window.getBounds();
    const monitorBounds = monitor.getBounds();
    const newBounds = Object.assign(Object.assign({}, windowBounds), {
        x: monitorBounds.x + (monitorBounds.width - windowBounds.width * sf) / 2,
        y: monitorBounds.y + (monitorBounds.height - windowBounds.height * sf) / 2
    });
    if(process.platform === "win32") {
        newBounds.x = Math.floor(newBounds.x);
        newBounds.y = Math.floor(newBounds.y);
        newBounds.width = Math.floor(newBounds.width * sf);
        newBounds.height = Math.floor(newBounds.height * sf);
        addon.setWindowBounds(window.id, newBounds);
    } else if (process.platform === "darwin") {
        addon.setWindowBounds(window.id, newBounds);
    }
}

function getVlcWindow() {
    return windowManager.getWindows().find(window => /VideoLAN[/\\]VLC[/\\]vlc.exe$/.test(window.path) && window.isVisible());
}

let server;
exports.startServer = (callback) => {
    portFinder.getPort({ port: 27797 }, (err, port) => {
        if(err) print(err);
        server = app.listen(port, () => {
            print(`Server is running on ${port}`);
            callback({
                port: port.toString(),
                ip: ip(),
            });
        });
    });
}

exports.closeServer = () => {
    server.close(() => {
        print("Server closed");
        process.exit(0);
    });
}

