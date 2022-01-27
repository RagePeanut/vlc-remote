import { MediaInfoFinder } from '../../abstract/finders';
import { MediaQuery } from '../../models';
import { MediaResponse, MediaResult } from '../../types/media';

export default class MovieInfoFinder extends MediaInfoFinder {
    async find(media: MediaResult, mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        if(media.media_type == 'movie') {
            const info = await this.tmdb.getMovieInfo(media.id, dataShaper);

            if(info.status === 'Released') {
                return {
                    ...info,
                    media_type: 'movie',
                }
            }
            return null;
        }
        return super.find(media, mediaQuery, dataShaper);
    }
}