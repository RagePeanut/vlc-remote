import { nonWordRegex, yearRegex, seasonEpisodeRegex } from '../regexes';

export default class MediaQuery {
    private _baseTitle: string;
    private _currentTitle: string;
    private _year: string;
    private _season: number;
    private _episode: number;

    get isEpisode() {
        return this._episode != undefined;
    }

    get title() {
        return this._currentTitle ?? this._baseTitle;
    }

    set title(newTitle: string) {
        this._currentTitle = newTitle;
    }

    get year() {
        return parseInt(this._year);
    }

    get season() {
        return this._season;
    }

    get episode() {
        return this._episode;
    }

    constructor(query: string) {
        const treatedQuery = query.replace(nonWordRegex, ' ').trim();

        this.findYear(treatedQuery);
        const seasonAndEpisode = this.findSeasonAndEpisode(treatedQuery);
        this.findTitle(treatedQuery, seasonAndEpisode ?? this._year ?? '');
    }

    private findYear(query: string): void {
        const currentYear = new Date().getFullYear();
        let match: RegExpExecArray;
        while(match = yearRegex.exec(query)) {
            if(parseInt(match[1]) <= currentYear) {
                this._year = match[1];
            }
        }
    }

    private findSeasonAndEpisode(query: string): string {
        const match = query.match(seasonEpisodeRegex);
        let seasonAndEpisode;
        if(match) {
            seasonAndEpisode = match[0];
            this._season = parseInt(match[1]);
            this._episode = parseInt(match[2]);
        }
        return seasonAndEpisode;
    }

    private findTitle(query: string, limit: string): void {
        const match = query.match(new RegExp(`^([a-zA-Z\\u00C0-\\u00D6\\u00D8-\\u00F6\\u00F8-\\u024F\\d' ]+)${limit}`));
        if(match) {
            this._baseTitle = match[1].trim();
        } else {
            // The title may have been misidentified as the release year (e.g. 1917)
            this._baseTitle = this._year;
            this._year = undefined;
        }
    }
}