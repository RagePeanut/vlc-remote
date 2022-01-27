import { MovieResult, TvResult } from 'moviedb-promise/dist/request-types';

import EpisodeResult from './episode_result';

type MediaResult = (MovieResult | TvResult | EpisodeResult) & { media_type?: string } ;

export default MediaResult;