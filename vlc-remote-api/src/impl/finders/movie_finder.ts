import { MediaFinder } from '../../abstract/finders';
import { MediaQuery } from '../../models';
import { ScoredMediaResult } from '../../types/media';

export default class MovieFinder extends MediaFinder {
    async find(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<Array<ScoredMediaResult>> {
        if(!mediaQuery.isEpisode) {
            const results = await this.tmdb.searchMovie(mediaQuery, dataShaper);

            if(results.length > 0) {
                return this.score(results, mediaQuery);
            }
        }
        return super.find(mediaQuery, dataShaper);
    }
}