import { configureStore } from '@reduxjs/toolkit';
import { persistStore } from 'redux-persist';

import reducer from './reducer';

const store = configureStore({
    reducer,
    // They are disabled in prod anyway, disabling them in dev too to
    // avoid the console being poluted by unnecessary warning messages
    middleware: getDefaultMiddleware => getDefaultMiddleware({
        immutableCheck: false,
        serializableCheck: false,
    }),
});

export const persistor = persistStore(store);

export default store;