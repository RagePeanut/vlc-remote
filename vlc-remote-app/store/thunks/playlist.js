import { createAsyncThunk } from '@reduxjs/toolkit';

import { extensionRegex, fileNameRegex } from '../../utils/regex';
import { vlc } from '../../services/axios';
import i18n from '../../services/i18n';
import { findMedia } from '../thunks/medias';

export const fetchPlaylistData = createAsyncThunk(
    'playlist/fetchPlaylistData',
    async (_, { dispatch, getState }) => {
        const response = await vlc.get('/playlist.json');
        const { medias } = getState();
        const locale = i18n.language;
        return response.data.children.find(list => list.id === '1').children.map(file => {
            const fileNameMatches = decodeURI(file.uri).match(fileNameRegex);
            // VLC uses the name in file details when it is not empty, we need the actual file name so we have to derive it from the uri
            const fileName = extensionRegex.test(file.name) ? file.name : (fileNameMatches && fileNameMatches[1]) ?? file.name;
            if(!medias[fileName]?.localized[locale]) {
                // console.log(fileName, medias[fileName]);
                dispatch(findMedia({ fileName, locale }));
            }
            return {
                id: file.id,
                fileName,
                duration: file.duration,
                // Removing the leading "file:///"
                path: file.uri.substring(8),
                // The path is what's shown to the user while the uri is what's used to navigate (different encodings)
                uri: file.uri.replace(/%2F/g, '/'),
                // The field received is either undefined or 'current'
                current: !!file.current, 
            }
        });
    },
);