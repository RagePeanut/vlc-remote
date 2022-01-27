import { MediaInfoFinder } from '../../abstract/finders';
import { MediaQuery } from '../../models';
import { MediaResponse, MediaResult } from '../../types/media';

export default class EpisodeInfoFinder extends MediaInfoFinder {
    async find(media: MediaResult, mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        if(media.media_type == 'tv' && mediaQuery.isEpisode) {
            const seriesInfo = await this.tmdb.getSeriesInfo(media.id, dataShaper);

            if(seriesInfo.status !== 'In Production') {
                if(seriesInfo.number_of_seasons >= mediaQuery.season) {
                    const season = seriesInfo.seasons.find(s => s.season_number == mediaQuery.season);
                    if(season.episode_count >= mediaQuery.episode) {
                        const info = await this.tmdb.getEpisodeInfo(seriesInfo, mediaQuery.season, mediaQuery.episode, dataShaper);
                        
                        return {
                            ...info,
                            media_type: 'episode',
                        }
                    }
                }
            }

            return null;
        }
        return super.find(media, mediaQuery, dataShaper);
    }
}