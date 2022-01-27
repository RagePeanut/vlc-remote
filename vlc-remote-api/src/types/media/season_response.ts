import { TvSeasonResponse } from 'moviedb-promise/dist/request-types';

type SeasonResponse = TvSeasonResponse & {
    original_series_name: string,
    series_name: string,
    poster_path: string,
};

export default SeasonResponse;