import i18n from 'i18next';
import Backend from 'i18next-http-backend';
import { initReactI18next } from "react-i18next";
// import { API_URL } from '@env';

import Persistor from './persistor';
import { supportedLanguages, defaultLanguage } from './settings';

i18n.use(Backend)
    .use(Persistor)
    .use(initReactI18next)
    .init({
        compatibilityJSON: 'v3',
        supportedLngs: supportedLanguages,
        fallbackLng: defaultLanguage,
        backend: {
            loadPath: lang => new URL(`/translations/${lang}`, 'https://vlc-remote-api.herokuapp.com/').href,
        },
        cache: {
            enabled: true,
        }
    });

export default i18n;