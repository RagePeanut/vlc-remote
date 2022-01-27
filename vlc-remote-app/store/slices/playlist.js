import { createSlice } from '@reduxjs/toolkit';

import { fetchPlaylistData } from '../thunks/playlist';

const playlistSlice = createSlice({
    name: 'playlist',
    initialState: [],
    extraReducers: {
        [fetchPlaylistData.fulfilled]: (state, action) => {
            if(state.length === action.payload.length
                && action.payload.every((file, index) => file.fileName === state[index].fileName && file.current === state[index].current)) {
                return state;
            }
            return action.payload;
        },
    },
});

export default playlistSlice;