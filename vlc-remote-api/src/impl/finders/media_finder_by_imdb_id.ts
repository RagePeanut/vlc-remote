import { ExternalId } from 'moviedb-promise/dist/request-types';

import { MediaFinderById } from '../../abstract/finders';
import { imdbIdRegex } from '../../regexes';
import { MediaResponse } from '../../types/media';

export default class MediaFinderByImdbId extends MediaFinderById {
    async find(id: string, complete: boolean, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        const match = id.match(imdbIdRegex);
        if(match) {
            const results = await this.tmdb.find(match[0], ExternalId.ImdbId, dataShaper);
            if(results.length > 0) {
                const result = results.reduce((mostPopular, current) => mostPopular.popularity < current.popularity ? current : mostPopular);
                if(!complete) return result;
                if(result.media_type == 'movie') {
                    return {
                        ...await this.tmdb.getMovieInfo(result.id, dataShaper),
                        media_type: 'movie',
                    };
                } else {
                    const seriesId = result.media_type == 'episode' ? result.show_id : result.id;
                    let media = await this.tmdb.getSeriesInfo(seriesId, dataShaper);
                    
                    if(result.media_type == 'episode') {
                        media = await this.tmdb.getEpisodeInfo(media, result.season_number, result.episode_number, dataShaper);
                    }

                    return {
                        ...media,
                        media_type: result.media_type,
                    }
                }
            }
            return null;
        }
        return super.find(id, complete, dataShaper);
    };
}