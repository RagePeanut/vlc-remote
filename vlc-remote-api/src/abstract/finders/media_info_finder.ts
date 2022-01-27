import { MediaQuery } from '../../models';
import TMDb from '../../services/tmdb';
import { MediaResponse, MediaResult } from '../../types/media';

export default abstract class MediaInfoFinder {
    private next: MediaInfoFinder;
    protected tmdb: TMDb;

    constructor(next: MediaInfoFinder, tmdb: TMDb) {
        this.next = next;
        this.tmdb = tmdb;
    }

    async find(media: MediaResult, mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        return this.next?.find(media, mediaQuery, dataShaper);
    }
}