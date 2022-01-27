import TMDb from '../services/tmdb';

export default class Configuration {
    private tmdb: TMDb;
    private baseUrl: string;
    private posterSizes: Map<string, number>;
    private _hasBeenUpdated: boolean;

    get hasBeenUpdated(): boolean {
        return this._hasBeenUpdated;
    }

    constructor() {
        this.tmdb = TMDb.Instance;
        this._hasBeenUpdated = false;
        setInterval(this.update, 3 * 24 * 60 * 60 * 1000);
    }

    async update(): Promise<void> {
        const { images } = await this.tmdb.configuration();
        this.baseUrl = images.secure_base_url;
        this.posterSizes = images.poster_sizes.reduce((sizeMap, key) => {
            const value = parseInt(key.slice(1)) || 999999;
            sizeMap.set(key, value);
            return sizeMap;
        }, new Map<string, number>());
        this._hasBeenUpdated = true;
    }

    toJson(): any {
        return {
            base_url: this.baseUrl,
            poster_sizes: Object.fromEntries(this.posterSizes),
        };
    }
}