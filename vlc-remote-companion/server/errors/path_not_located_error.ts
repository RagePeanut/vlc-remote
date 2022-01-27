export default class PathNotLocatedError implements Error {
    name: string = "PathNotLocatedError";
    message: string = "Path not located";
    stack?: string;
}