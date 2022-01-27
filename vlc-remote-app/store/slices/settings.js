import { createSlice } from '@reduxjs/toolkit';

import { REGULAR } from '../../enums/Volume';
import { LIGHT } from '../../enums/Theme';
import { TIME_REMAINING } from '../../enums/TimeIndicator';

const settingsSlice = createSlice({
    name: 'settings',
    initialState: {
        theme: LIGHT,
        useOriginalTitle: false,
        showAdultPosters: false,
        maxVolume: REGULAR,
        rightTimeIndicator: TIME_REMAINING,
    },
    reducers: {
        setMaxVolume: (state, action) => ({ ...state, maxVolume: action.payload }),
        setUseOriginalTitle: (state, action) => ({ ...state, useOriginalTitle: action.payload }),
        setTheme: (state, action) => ({ ...state, theme: action.payload}),
        setRightTimeIndicator: (state, action) => ({ ...state, rightTimeIndicator: action.payload}),
    },
});

export const { setMaxVolume, setUseOriginalTitle, setTheme, setRightTimeIndicator } = settingsSlice.actions;

export default settingsSlice;