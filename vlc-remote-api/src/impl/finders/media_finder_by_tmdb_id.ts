import { MediaFinderById } from '../../abstract/finders';
import { tmdbIdRegex, seasonEpisodeUrlRegex } from '../../regexes';
import { MediaResponse } from '../../types/media';

export default class MediaFinderByTmdbId extends MediaFinderById {
    async find(id: string, complete: boolean, dataShaper: qs.ParsedQs): Promise<MediaResponse> {
        let media: MediaResponse;
        let media_type;
        let match = id.match(tmdbIdRegex);
        if(match) {
            const mediaId = match[0];
            match = id.match(seasonEpisodeUrlRegex);
            if(match) {
                media = await this.tmdb.getSeriesInfo(mediaId, dataShaper);
                if(match[2]) {
                    media = await this.tmdb.getEpisodeInfo(media, parseInt(match[1]), parseInt(match[2]), dataShaper);
                    media_type = 'episode';
                } else {
                    media = await this.tmdb.getSeasonInfo(media, parseInt(match[1]), dataShaper);
                    media_type = 'season';
                }
            } else {
                try {
                    media = await this.tmdb.getMovieInfo(mediaId, dataShaper);
                    media_type = 'movie';
                } catch(e) {
                    try {
                        media = await this.tmdb.getSeriesInfo(mediaId, dataShaper);
                        media_type = 'tv';
                    } catch(e) {
                        return super.find(id, complete, dataShaper);
                    }
                }
            }
            
            if(media) {
                return {
                    ...media,
                    media_type,
                }
            }
        }
        return super.find(id, complete, dataShaper);
    }
}