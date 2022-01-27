import express from "express";
import { Server } from "http";
import axiosStatic from "axios";
import cors from "cors";                        // Cross-origin res sharing
import portFinder from "portfinder";            // Port finding
import { ip } from "address";                   // IP address information
import { addPath } from "app-module-path";

import PathNotLocatedError from "./errors/path_not_located_error";
import UnsupportedMediaTypeError from "./errors/unsupported_media_type_error";
import MkvInfoExtractor from "./impl/mkv_info_extractor";
import VlcWindowImpl from "./impl/vlc_window_impl";
import MediaInfoExtractor from "./interfaces/media_info_extractor";
import IWindow from "./interfaces/window";
import MissingFileError from "./errors/missing_file_error";

const app = express();                          // Server
const axios = axiosStatic.create();             // HTTP requests
addPath(`${__dirname}`);

const vlc: IWindow = new VlcWindowImpl();

app.use(cors());

// CHECK PASSWORD
app.get("/check_password", async (req, res) => {
    console.log(`Check Password GET request: ${JSON.stringify(req.query)}`);

    const password = req.query["password"] as string;
    const port = req.query["port"] as string;
    if(!password || !port) return res.sendStatus(400);

    try {
        await axios.get(`http://localhost:${port}/requests/status.json`, {
            auth: {
                username: "",
                password,
            },
        });
        res.send(true);
    } catch {
        res.send(false);
    }
});

// CHECK PORT NUMBER
app.get("/check_port_number", async (req, res) => {
    console.log(`Check Port Number GET request: ${JSON.stringify(req.query)}`);

    const port = req.query["port"];
    if(!port) return res.sendStatus(400);

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
    console.log(`Close VLC GET request`);

    vlc.close();
    res.sendStatus(200);
});

// EXTRA FILE INFO
// Supports: MKV
app.get("/extra_info", async (req, res) => {
    console.log(`Extra Info GET request: ${JSON.stringify(req.query)}`);
    const uri = req.query["uri"] as string;
    if(!uri) return res.sendStatus(400);
    const decodedUri = decodeURIComponent(uri).replace("file:///", "");
    const extension = decodedUri.split(".").pop();

    res.setHeader("Content-Type", "application/json");
    const extractorChain: MediaInfoExtractor = new MkvInfoExtractor(null);
    try {
        extractorChain.extract(decodedUri, extension)
            .on("data", (chunk: string) => {
                res.write(chunk);
            })
            .on("close", () => {
                res.end();
            });
    } catch(err) {
        if(err instanceof UnsupportedMediaTypeError) {
            res.sendStatus(415); // Unsupported Media Type
        } else if(err instanceof MissingFileError) {
            res.sendStatus(404); // Missing File
        } else {
            console.log(err);
        }
    }
});

// LOCATE VLC
app.get("/locate_vlc", (_, res) => {
    console.log(`Locate VLC GET request`);

    if(vlc.path) return res.sendStatus(200);
    let timeout = setVlcTimeout();

    function setVlcTimeout() {
        return setTimeout(() => {
            if(timeout) clearTimeout(timeout);
            if(vlc.locate()) res.sendStatus(200);
            else timeout = setVlcTimeout();
        }, 500);
    }
});

// OPEN VLC
app.get("/open_vlc", async (_, res) => {
    try {
        await vlc.open();
        res.sendStatus(200);
    } catch(err) {
        if(err instanceof PathNotLocatedError) {
            res.status(404).json({
                error: err.message,
            });
        }
    }
});

// SWITCH SCREEN
app.get("/switch_screen", (_, res) => {
    console.log(`Switch Screen GET request`);

    if(vlc.locate()) {
        const currentScreenNumber = vlc.switchScreen() + 1;
        res.json({
            current_screen: currentScreenNumber,
        });
    } else {
        res.status(404).json({
            error: "vlc_window_not_found",
        });
    }
});

let server: Server;

exports.startServer = (callback: Function) => {
    portFinder.getPort({ port: 27797 }, (err, port) => {
        if(err) console.log(err);
        server = app.listen(port, () => {
            console.log(`Server is running on ${port}`);
            callback({
                port: port.toString(),
                ip: ip(),
            });
        });
    });
}

exports.closeServer = () => {
    server.close(() => {
        console.log("Server closed");
        process.exit(0);
    });
}

