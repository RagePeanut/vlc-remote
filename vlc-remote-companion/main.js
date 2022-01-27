// Modules to control application life and create native browser window
const { app, BrowserWindow, ipcMain, Menu, shell, Tray } = require('electron');
const isDev = require('electron-is-dev');
const path = require('path');
const url = require('url');

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let mainWindow, portNumber, ipAddress, stopServer;

function createWindow() {
    // Express server is started here (only once !!!)
    if(!stopServer) {
        const { startServer, closeServer } = require(path.join(__dirname, 'build-server', 'server'));
        startServer(({ port, ip }) => {
            portNumber = port;
            ipAddress = ip;
        });
        stopServer = closeServer;
    }

    // Create the browser window.
    mainWindow = new BrowserWindow({
        width: 920,
        height: 650,
        minWidth: 585,
        minHeight: 650,
        useContentSize: true,
        webPreferences: {
            nodeIntegration: true
        }
    });

    mainWindow.setMenuBarVisibility(false);

    // and load the index.html of the app.
    mainWindow.loadURL(isDev ? 'http://localhost:3000' : url.format({
        pathname: path.join(__dirname, 'build/index.html'),
        protocol: 'file:',
        slashes: true
    }));

    // Open the DevTools.
    // mainWindow.webContents.openDevTools()

    // Emitted when the window is closed.
    mainWindow.on('closed', function () {
        // Dereference the window object, usually you would store windows
        // in an array if your app supports multi windows, this is the time
        // when you should delete the corresponding element.
        mainWindow = null;
    });

    // Opens a new window in the browser when _target links are clicked.
    mainWindow.webContents.on('new-window', function (event, url) {
        event.preventDefault();
        shell.openExternal(url);
    });
}

// Fetches the companion port number.
ipcMain.on('fetch-companion-port-and-ip', event => {
    event.reply('fetch-companion-port-and-ip-reply', { portNumber, ipAddress });
});

// Fetches the computer name.
ipcMain.on('fetch-computer-name', event => {
    switch(process.platform) {
        case 'win32':
            event.reply('fetch-computer-name-reply', process.env.COMPUTERNAME);
            break;
        case 'darwin':
            event.reply('fetch-computer-name-reply', require('child_process').execSync('scutil --get ComputerName').toString().trim());
            break;
        default:
            event.reply('fetch-computer-name-reply', require('os').hostname());
    }
});

// Setting the app to launch on login.
// If the app isn't set to open as hidden, it must be its first launch
if(!app.getLoginItemSettings().openAsHidden) {
    app.setLoginItemSettings({
        openAtLogin: true,
        openAsHidden: true,
        path: app.getAppPath(),
    });
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
let tray; // Setting tray in global context so it doesn't get destroyed by the garbage collector
app.on('ready', function () {
    tray = new Tray(path.join(__dirname, 'public', 'favicon.ico'));
    const contextMenu = Menu.buildFromTemplate([
        {
            label: 'Show VLC Remote',
            type: 'normal',
            click: () => {
                if(mainWindow === null) createWindow();
            },
        },
        { type: 'separator' },
        {
            label: 'Launch on startup',
            type: 'checkbox',
            checked: app.getLoginItemSettings().openAtLogin,
            click: (event) => {
                app.setLoginItemSettings({
                    openAtLogin: event.checked,
                });
            },
        },
        { type: 'separator' },
        {
            label: 'Quit VLC Remote',
            type: 'normal',
            click: () => stopAll(),
        }
    ]);
    tray.setTitle('VLC Remote');
    tray.setToolTip('VLC Remote');
    tray.setContextMenu(contextMenu);

    createWindow();
});

// Stay in tray when all windows are closed.
app.on('window-all-closed', function () {});

app.on('activate', function() {
    // On macOS it's common to re-create a window in the app when the
    // dock icon is clicked and there are no other windows open.
    if(mainWindow === null) createWindow();
});

function stopAll() {
    app.quit();
    stopServer();
}

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.
