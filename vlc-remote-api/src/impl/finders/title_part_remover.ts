import MediaQuery from '../../models/media_query';
import { MediaFinder } from '../../abstract/finders';
import { junkRegex, lastWordRegex } from '../../regexes';
import { ScoredMediaResult } from '../../types/media';

export default class TitlePartRemover extends MediaFinder {
    private hasRemovedJunk = false;

    async find(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<Array<ScoredMediaResult>> {
        const title = mediaQuery.title;
        if(!this.hasRemovedJunk) {
            mediaQuery.title = title.replace(junkRegex, '');
            this.hasRemovedJunk = true;
            if(title !== mediaQuery.title) {
                return super.find(mediaQuery, dataShaper);
            }
        }
        mediaQuery.title = title.replace(lastWordRegex, '');
        if(title === mediaQuery.title) {
            return null;
        }
        return super.find(mediaQuery, dataShaper);
    }
}