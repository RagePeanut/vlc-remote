import AsyncStorage from '@react-native-async-storage/async-storage';
import { locale } from 'expo-localization';

import { supportedLanguages, defaultLanguage } from './settings';

export default {
    type: 'languageDetector',
    async: true,
    init: () => {},
    detect: async (callback) => {
        try {
            const language = await AsyncStorage.getItem('language');
            if(language) {
                return callback(language);
            }
        } catch(error) {
            console.log('Retrieving from cache error', error);
        }
        const systemLanguage = locale.split('-')[0];
        if(supportedLanguages.includes(systemLanguage)) {
            return callback(systemLanguage);
        }
        callback(defaultLanguage);
    },
    cacheUserLanguage: async (language) => {
        try {
            await AsyncStorage.setItem('language', language);
        } catch(error) {
            console.log('Caching error', error);
        }
    }
};