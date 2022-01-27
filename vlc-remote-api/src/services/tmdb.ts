import { MovieDb } from 'moviedb-promise';
import { ConfigurationResponse, ExternalId, MovieResponse, MovieResult, ShowResponse, TvResult } from 'moviedb-promise/dist/request-types';

import { MediaQuery } from '../models';
import { numberish } from '../types/common';
import { EpisodeResponse, EpisodeResult, EpisodeWithTranslations, MediaResult, SeasonResponse } from '../types/media'; 

export default class TMDb {
    private static _instance: TMDb;
    private tmdb: MovieDb;

    private constructor() {
        this.tmdb = new MovieDb(process.env.TMDB_API_KEY); 
    }

    static get Instance() {
        return this._instance || (this._instance = new this())
    }

    async configuration(): Promise<ConfigurationResponse> {
        return this.tmdb.configuration();
    }

    async find(id: numberish, source: ExternalId, dataShaper: qs.ParsedQs): Promise<Array<MediaResult>> {
        const findResponse = await this.tmdb.find({
            ...dataShaper,
            id,
            external_source: source,
        });

        return [
            ...findResponse.movie_results.map(movie => {
                return {
                    ...movie,
                    media_type: 'movie',
                } as MediaResult;
            }),
            ...findResponse.tv_results.map(show => {
                return {
                    ...show,
                    media_type: 'tv',
                } as MediaResult;
            }),
            ...findResponse.tv_episode_results.map(episodeObj => {
                const episode = episodeObj as EpisodeResult;
                return {
                    ...episode,
                    popularity: episode.vote_count,
                    media_type: 'episode',
                };
            }),
        ];
    }

    async getEpisodeInfo(series: ShowResponse, season: number, episode: number, dataShaper: qs.ParsedQs): Promise<EpisodeResponse> {
        const info = await this.tmdb.episodeInfo({
            ...dataShaper,
            id: series.id,
            season_number: season,
            episode_number: episode,
            append_to_response: 'translations',
        }) as EpisodeWithTranslations;

        const originData = info.translations.translations.find(tr => tr.iso_639_1 == series.original_language
                                                                     && (series.origin_country.length == 0 || tr.iso_3166_1 == series.origin_country[0]));

        return {
            original_series_name: series.original_name,
            series_name: series.name,
            poster_path: series.poster_path,
            runtime: ~~(series.episode_run_time.reduce((sum, time) => sum + time) / series.episode_run_time.length),
            original_name: originData?.data?.name,
            ...info,
        }
    }

    async getMovieInfo(id: numberish, dataShaper: qs.ParsedQs): Promise<MovieResponse> {
        return this.tmdb.movieInfo({
            ...dataShaper,
            id,
        });
    }

    async getSeasonInfo(series: ShowResponse, season: number, dataShaper: qs.ParsedQs): Promise<SeasonResponse> {
        return {
            original_series_name: series.original_name,
            series_name: series.name,
            poster_path: series.poster_path,
            ...await this.tmdb.seasonInfo({
                ...dataShaper,
                id: series.id,
                season_number: season,
            }),
        };
    }

    async getSeriesInfo(id: numberish, dataShaper: qs.ParsedQs): Promise<ShowResponse> {
        return this.tmdb.tvInfo({
            ...dataShaper,
            id,
        });
    }

    async searchMovie(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs): Promise<Array<MovieResult>> {
        return (await this.tmdb.searchMovie({
            ...dataShaper,
            query: mediaQuery.title,
            year: mediaQuery.year,
            include_adult: true,
        })).results.map(result => ({ ...result, media_type: 'movie' }));
    }

    async searchSeries(mediaQuery: MediaQuery, dataShaper: qs.ParsedQs, useYear: boolean = true): Promise<Array<TvResult>> {
        return (await this.tmdb.searchTv({
            ...dataShaper,
            query: mediaQuery.title,
            first_air_date_year: useYear ? mediaQuery.year : null,
            include_adult: true,
        })).results.map(result => ({ ...result, media_type: 'tv' }));
    }

}