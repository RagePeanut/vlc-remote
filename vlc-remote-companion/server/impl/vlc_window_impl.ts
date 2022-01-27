import fs from "fs";    // Files

import WindowImpl from "./window_impl";

export default class VlcWindowImpl extends WindowImpl {
    constructor() {
        const { vlcPath } = fs.existsSync("build-server/data.json") && require("../data.json");
        super(/VideoLAN[/\\]VLC[/\\]vlc.exe$/, vlcPath);
    }

    /** @overrides */
    locate(): boolean {
        const oldPath = this.path;
        if(super.locate()) {
            if(oldPath !== this.path) {
                try {
                    fs.writeFileSync("build-server/data.json", JSON.stringify({ vlcPath: this.path }));
                } catch(err) {
                    console.log(err);
                }
            }
            return true;
        };
        return false;
    }
}