import { Episode } from 'moviedb-promise/dist/request-types';

type EpisodeResponse = Episode & {
    original_series_name: string,
    series_name: string,
    poster_path: string,
    runtime: number,
    original_name: string,
};

export default EpisodeResponse;