import TMDb from '../../services/tmdb';
import { MediaResponse } from '../../types/media';

export default abstract class MediaFinderById {
    private next: MediaFinderById;
    protected tmdb: TMDb;

    constructor(next: MediaFinderById, tmdb: TMDb) {
        this.next = next;
        this.tmdb = tmdb;
    }

    async find(id: string, complete: boolean, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        return this.next?.find(id, complete, dataShaper);
    }
}