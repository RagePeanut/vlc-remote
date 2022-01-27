export default class UnsupportedMediaTypeError implements Error {
    constructor(mediaType: string) {
        this.message = "Unsupported media type: " + mediaType;
    }

    name: string = "UnsupportedMediaTypeError";
    message: string;
    stack?: string;
}