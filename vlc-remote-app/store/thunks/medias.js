import { createAsyncThunk } from '@reduxjs/toolkit';

import { tmdb } from '../../services/axios';

const formatMediaData = (data, locale) => ({
    id: data.id,
    originalTitle: data.original_title ?? data.original_name,
    originalSeriesName: data.original_series_name,
    releaseDate: data.release_date ?? data.air_date ?? data.first_air_date,
    runtime: data.runtime,
    seasonNumber: data.season_number,
    episodeNumber: data.episode_number,
    type: data.media_type,
    adult: data.adult ?? false,
    known: true,
    localized: {
        [locale]: {
            title: data.title ?? data.name,
            seriesName: data.series_name,
            plot: data.overview,
            posterPath: data.poster_path,
        },
    },
});

export const findMedia = createAsyncThunk(
    'medias/findMedia',
    async ({ fileName, locale }) => {
        const media = await tmdb.get('/find', {
            params: {
                query: fileName,
                language: locale,
            },
        });
        return formatMediaData(media.data, locale);
    },
)