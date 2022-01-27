import { MediaInfoFinder } from '../../abstract/finders';
import { MediaQuery } from '../../models';
import { MediaResponse, MediaResult } from '../../types/media';

export default class SeriesInfoFinder extends MediaInfoFinder {
    async find(media: MediaResult, mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        if(media.media_type == 'tv' && !mediaQuery.isEpisode) {
            const info = await this.tmdb.getSeriesInfo(media.id, dataShaper);

            if(info.status !== 'In Production') {
                return {
                    ...info,
                    media_type: 'tv',
                }
            }
            return null;
        }
        return super.find(media, mediaQuery, dataShaper);
    }
}