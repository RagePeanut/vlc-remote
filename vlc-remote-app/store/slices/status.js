import { createSlice } from '@reduxjs/toolkit';

import { STOPPED } from '../../enums/PlayerState';
import { fetchStatusData } from '../thunks/status';

const statusSlice = createSlice({
    name: 'status',
    initialState: {
        media: {
            id: NaN,
            fileName: '',
            year: NaN,
            length: 0,
            chapters: [],
            chapterCount: 1,
        },
        player: {
            fullscreen: false,
            open: false,
            state: STOPPED,
            loop: false, // Included in case its used one day
            repeat: false, // Included in case its used one day
            currentTime: 0,
            currentChapter: 0,
            currentId: NaN,
        }
    },
    extraReducers: {
        [fetchStatusData.fulfilled]: (_state, action) => action.payload,
    },
});

export default statusSlice;