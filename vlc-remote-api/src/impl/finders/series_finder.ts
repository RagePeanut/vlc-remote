import { MediaFinder } from '../../abstract/finders';
import { MediaQuery } from '../../models';
import { ScoredMediaResult } from '../../types/media';

export default class SeriesFinder extends MediaFinder {
    async find(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<Array<ScoredMediaResult>> {
        // Searching for a TV series with the title and the year found
        let results = await this.tmdb.searchSeries(mediaQuery, dataShaper);

        if(results.length === 0) {
            // Searching for a TV series with only the title
            results = await this.tmdb.searchSeries(mediaQuery, dataShaper, false);
        }

        if(results.length > 0) {
            return this.score(results, mediaQuery);
        }

        return super.find(mediaQuery, dataShaper);
    }
}