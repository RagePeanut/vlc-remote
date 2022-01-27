export default class MissingFileError implements Error {
    constructor(uri: string) {
        this.message = "Missing file: " + uri;
    }

    name: string = "MissingFileError";
    message: string;
    stack?: string;
}