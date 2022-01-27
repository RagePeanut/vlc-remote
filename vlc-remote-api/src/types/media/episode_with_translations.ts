import { Episode, EpisodeTranslationsResponse } from 'moviedb-promise/dist/request-types';

type EpisodeWithTranslations = Episode & { translations: EpisodeTranslationsResponse };

export default EpisodeWithTranslations;