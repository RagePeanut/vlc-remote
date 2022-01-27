import { createAsyncThunk } from '@reduxjs/toolkit';

import { STOPPED } from '../../enums/PlayerState';
import { vlc } from '../../services/axios';

const formatPlayerData = data => {
    const player = {
        state: data.state,
        open: true,
        loop: data.loop,
        repeat: data.repeat,
        currentTime: Math.max(data.time, 0),
    };
    if(data.state === STOPPED) {
        return {
            ...player,
            fullscreen: false,
            currentChapter: 0,
            currentId: NaN,
        }
    }
    return {
        ...player,
        // This conversion is required because the fullscreen param is not instantly initialized when the state goes from 'stopped' to another state (it can be 0 instead of a boolean)
        fullscreen: !!data.fullscreen,
        currentChapter: data.information.chapter,
        currentId: data.currentplid,
    };
}

const formatMediaData = data => {
    if(data.state === STOPPED) {
        return {
            id: NaN,
            fileName: '',
            year: NaN,
            length: 0,
            chapters: [],
            chapterCount: 1,
        };
    }
    // TODO: adapt this code from the dart version to js (lib/stores/status/status.dart:50)
    // Media currentlyPlaying = playlist.firstWhere((Media media) => media.file.name == data["information"]["category"]["meta"]["fileName"], orElse: () => null);
    // title = settings.useOriginalTitle ? currentlyPlaying?.originalTitle : currentlyPlaying?.title
    //             ?? (data["information"]["title"].runtimeType == String
    //                     ? data["information"]["title"]
    //                     : importantNamePartRegex.firstMatch(data["information"]["category"]["meta"]["fileName"])
    //                                             .group(1)
    //                                             .replaceAll(nonWordRegex, " "));
    //                                             // TODO: find a way to not use importantNamePartRegex so that this regex can be removed from the project
    // year = currentlyPlaying?.year;
    const meta = data.information.category.meta;
    return {
        id: data.currentplid,
        fileName: meta.filename,
        year: NaN,
        length: Math.max(data.length, 0),
        chapters: [],
        chapterCount: data.information.chapters.length,
    };
};

export const fetchStatusData = createAsyncThunk(
    'status/fetchStatusData',
    async (params) => {
        const response = await vlc.get('/status.json', { params });
        return {
            media: formatMediaData(response.data),
            player: formatPlayerData(response.data),
        };
    },
);