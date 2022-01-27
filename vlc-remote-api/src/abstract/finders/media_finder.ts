import { MovieResult, TvResult } from 'moviedb-promise/dist/request-types';

import { MediaQuery } from '../../models';
import { nonWordRegex } from '../../regexes';
import { MediaResult, ScoredMediaResult } from '../../types/media';
import TMDb from '../../services/tmdb';

export default abstract class MediaFinder {
    next: MediaFinder;
    protected tmdb: TMDb;

    constructor(nextMediaFinder: MediaFinder, tmdb: TMDb) {
        this.next = nextMediaFinder;
        this.tmdb = tmdb;
    }

    async find(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<Array<ScoredMediaResult>> {
        return this.next?.find(mediaQuery, dataShaper);
    }

    protected score(medias: MediaResult[], mediaQuery: MediaQuery): Array<ScoredMediaResult> {
        if(medias.length == 1) {
            return new Array<ScoredMediaResult>({
                ...medias[0],
                score: 4,
            });
        }

        const searchTitleWordCount = mediaQuery.title.split(' ').length;
        const bestPopularity = medias.reduce((best, curr) => best.popularity < curr.popularity ? curr : best).popularity;
        const scores = new Array<ScoredMediaResult>();

        console.log(`\n================================= ${mediaQuery.title} =================================`);
        for(let i = 0; i < medias.length; i++) {
            // 1 point  - First results are preferred
            const positionScore = likeliness(i / medias.length);

            // 2 points - Results with a word count close to the search title word count are preferred
            let media, title, originalTitle;
            if(medias[i].media_type == 'movie') {
                media = medias[i] as MovieResult;
                title = media.title;
                originalTitle = media.original_title;
            } else {
                media = medias[i] as TvResult;
                title = media.name;
                originalTitle = media.original_name;
            }
            const wordCountScore =  [
                title.replace(nonWordRegex, ' ').trim(),
                originalTitle.replace(nonWordRegex, ' ').trim()
            ].map(title => {
                const titleWordCount = title.split(' ').length;
                return likeliness(clamp((titleWordCount - searchTitleWordCount) / (titleWordCount * 2), 0, 1), 3);
            }).reduce((prev, curr) => prev + curr);
            
            // 1 point  - Popular results are preferred
            const popularityScore = likeliness(1 - media.popularity / bestPopularity);
            
            const score = positionScore + wordCountScore + popularityScore;

            let printColor;
            if(score < 2) printColor = '\x1b[31m'; // Red
            else if(score < 2.75) printColor = '\x1b[33m'; // Yellow
            else printColor = '\x1b[32m'; // Green

            console.log(`\n${printColor}===== ${title} (${score}) ======`);
            console.log(`Position: ${positionScore}\nWord Count: ${wordCountScore}\nPopularity: ${popularityScore}\x1b[0m`);

            scores.push({
                ...media,
                score,
            });
        }

        console.log(`\n==================================${'='.repeat(mediaQuery.title.length)}==================================\n`)
    
        return scores.sort((a, b) => b.score - a.score);
    
        function likeliness(x: number, firstPow: number = 4): number {
            return Math.pow(1 - Math.pow(x, firstPow), 20);
        }
    
        function clamp(value: number, min: number, max: number): number {
            return Math.max(min, Math.min(max, value));
        }
    }
}