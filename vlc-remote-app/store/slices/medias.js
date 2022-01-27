import { createSlice } from '@reduxjs/toolkit';

import { findMedia } from '../thunks/medias';

const mediasSlice = createSlice({
    name: 'medias',
    initialState: {},
    extraReducers: {
        [findMedia.fulfilled]: (state, action) => {
            if(state[action.meta.arg.fileName].known) {
                return {
                    ...state,
                    [action.meta.arg.fileName]: {
                        ...action.payload,
                        localized: {
                            ...state[action.meta.arg.fileName].localized,
                            [action.meta.arg.locale]: action.payload.localized[action.meta.arg.locale],
                        }
                    },
                };
            }
            return {
                ...state,
                [action.meta.arg.fileName]: action.payload,
            };
        },
        [findMedia.pending]: (state, action) => ({
            ...state,
            [action.meta.arg.fileName]: {
                known: false,
                ...state[action.meta.arg.fileName],
            }
        }),
        [findMedia.rejected]: (state, action) => ({ ...state, [action.meta.arg.fileName]: { known: false } }),
    },
});

export default mediasSlice;
