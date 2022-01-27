import { Decoder, StateAndTagData } from "ebml";    // MKV parsing
import { Readable } from "stream";
import fs from "fs";

import MediaInfoExtractor from "../interfaces/media_info_extractor";
import MissingFileError from "../errors/missing_file_error";

export default class MkvInfoExtractor extends MediaInfoExtractor {
    private static readonly EXTENSION: string = "mkv";

    /** @override */
    public extract(uri: string, extension: string): Readable {
        if(!this.compare(extension, MkvInfoExtractor.EXTENSION)) {
            return super.extract(uri, extension);
        }

        // TODO: find a way to do this in the abstract class rather than every implementation
        if(!this.exists(uri)) {
            throw new MissingFileError(uri);
        }

        return new Readable({
            read(_size) {
                const decoder: any = new Decoder();
                const chapters: number[] = [];
                let duration: number;
                let timeStampScale = 1000000;
    
                let containsChaptersElement: boolean, containsInfoElement: boolean;
                let chaptersRead: boolean, infoRead: boolean;
                let chaptersSent: boolean, infoSent: boolean;
                const mkvReadStream = fs.createReadStream(uri);
                const mkvWriteStream = (mkvReadStream.pipe(decoder) as NodeJS.WritableStream) 
                    .on("data", (chunk: StateAndTagData) => {
                        if(chunk[0] == "tag") {
                            switch(chunk[1].name) {
                                case "ChapterTimeStart":
                                    chapters.push(chunk[1].value);
                                    break;
                                case "SeekID":
                                    const seekId: string = chunk[1].data.toString("hex");
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
                                        this.push(JSON.stringify({
                                            chapters: chapters.map((chapter: number) => Math.ceil(chapter / 1000000000)),
                                        }));
                                        chaptersSent = true;
                                    }
                                    break;
                                case "Info":
                                    infoRead = true;
                                    if(!infoSent) {
                                        this.push(JSON.stringify({
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
                                mkvWriteStream.end();
                            }
                        }
                    })
                    .on("end", () => {
                        mkvReadStream.destroy();
                        this.destroy();
                    });
            }
        });
    }
}