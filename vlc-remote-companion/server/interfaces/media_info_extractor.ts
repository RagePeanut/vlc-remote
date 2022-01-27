import fs from "fs";
import { Readable } from "stream";

import UnsupportedMediaTypeError from "../errors/unsupported_media_type_error";

export default abstract class MediaInfoExtractor {
    private next: MediaInfoExtractor;

    constructor(nextExtractor: MediaInfoExtractor) {
        this.next = nextExtractor;
    }

    extract(uri: string, extension: string): Readable {
        if(this.next == null) throw new UnsupportedMediaTypeError(extension);
        return this.next.extract(uri, extension);
    }

    protected compare(a: string, b: string): boolean {
        return a.localeCompare(b, undefined, { sensitivity: "base" }) === 0;
    }

    protected exists(uri: string): boolean {
        return fs.existsSync(uri);
    }
}