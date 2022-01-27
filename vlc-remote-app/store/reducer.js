import { combineReducers } from '@reduxjs/toolkit';
import { persistReducer } from 'redux-persist';
import AsyncStorage from '@react-native-async-storage/async-storage';

import computersSlice from './slices/computers';
import mediasSlice from './slices/medias';
import playlistSlice from './slices/playlist';
import settingsSlice from './slices/settings';
import statusSlice from './slices/status';

const persistConfig = {
    key: 'root',
    storage: AsyncStorage,
    whitelist: [
        'computers',
        // 'medias',
        // 'settings',
    ],
};

const rootReducer = combineReducers({
    computers: computersSlice.reducer,
    medias: mediasSlice.reducer,
    playlist: playlistSlice.reducer,
    settings: settingsSlice.reducer,
    status: statusSlice.reducer,
});

export default persistReducer(persistConfig, rootReducer);