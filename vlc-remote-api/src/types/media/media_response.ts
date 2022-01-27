import { MovieResponse, ShowResponse } from 'moviedb-promise/dist/request-types';

import EpisodeResponse from './episode_response';

type MediaResponse = (MovieResponse | ShowResponse | EpisodeResponse) & { media_type?: string };

export default MediaResponse;