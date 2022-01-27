import { exec } from "child_process";                                   // Commands
import { windowManager, addon, Window } from "node-window-manager";     // Windows
import { Monitor } from "node-window-manager/dist/classes/monitor";     
import delay from "delay";                                              // Awaitable timeout

import IWindow from "../interfaces/window";
import PathNotLocatedError from "../errors/path_not_located_error";

export default class WindowImpl implements IWindow {
    private _path: string;
    private pathRegex: RegExp;
    private window: Window;

    get path() {
        return this._path;
    }

    constructor(pathRegex: RegExp, path: string) {
        this.pathRegex = pathRegex;
        this._path = path;
    }

    close() {
        if(this.window) process.kill(this.window.processId);
    }

    locate(): boolean {
        this.window = windowManager.getWindows().find(window => this.pathRegex.test(window.path) && window.isVisible());
        this._path = this.window?.path ?? this._path;
        return this.window !== undefined;
    }

    async open(): Promise<void> {
        if(!this.locate()) {
            if(!this._path) {
                throw new PathNotLocatedError();
            }
            exec(`"${this._path}"`);
            do {
                await delay(100);
            } while(!this.locate());
        }
        this.window.bringToTop();
    }

    switchScreen(): number {
        const monitors = windowManager.getMonitors();
        const currentMonitor = this.window.getMonitor() as Monitor;
        const nextMonitorIndex = (monitors.findIndex(monitor => monitor.id == currentMonitor.id) + 1) % monitors.length;
        this.sendToMonitor(monitors[nextMonitorIndex]);
        return nextMonitorIndex;
    }

    private sendToMonitor(monitor: Monitor): void {
        const sf = monitor.getScaleFactor();
        const windowBounds = this.window.getBounds();
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
            addon.setWindowBounds(this.window.id, newBounds);
        } else if (process.platform === "darwin") {
            addon.setWindowBounds(this.window.id, newBounds);
        }

        this.window.bringToTop();
    }
}