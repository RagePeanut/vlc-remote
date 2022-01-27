import React, { useCallback } from 'react';
import { View } from 'react-native';

import { Divider } from 'react-native-paper';
import { useTranslation } from 'react-i18next';
import { useDispatch, useSelector } from 'react-redux';

import { supportedLanguages } from '../../services/i18n/settings';
import SettingLink from '../../components/settings/SettingLink';
import SettingSelect from '../../components/settings/SettingSelect';
import Theme from '../../enums/Theme';
import { capitalize } from '../../utils/string';
import { setTheme } from '../../store/slices/settings';

const SettingsRoot = () => {
    const { t, i18n } = useTranslation();
    const theme = useSelector(state => state.settings.theme);
    const dispatch = useDispatch();

    const handleThemeChange = useCallback(theme => {
        dispatch(setTheme(theme));
    }, [ dispatch, setTheme ]);
    
    return (
        <View>
            <SettingLink
                title={t('settings.computers.title', 'Computers')}
                description={t('settings.computers.description', 'The computers linked to the app.')}
                routeName="SettingsComputers"
            />
            <Divider/>
            <SettingLink
                title={t('settings.medias.title', 'Medias')}
                description={t('settings.medias.description', 'Settings related to medias.')}
                routeName="SettingsMedias"
            />
            <Divider/>
            <SettingLink
                title={t('settings.remote.title', 'Remote')}
                description={t('settings.remote.description', 'Settings related to the remote.')}
                routeName="SettingsRemote"
            />
            <Divider/>
            <SettingSelect
                title={t('settings.theme.title', 'Theme')}
                description={t('settings.theme.description', 'The theme used by the app.')}
                value={theme}
                options={Object.values(Theme)}
                mapOptionToText={option => t('settings.theme.options.' + option, capitalize(option, true))}
                onChange={handleThemeChange}
            />
            <Divider/>
            <SettingSelect
                title={t('settings.language.title', 'Language')}
                description={t('settings.language.description', 'The language used by the app.')}
                value={i18n.language}
                options={supportedLanguages}
                onChange={lng => i18n.changeLanguage(lng)}
            />
        </View>
    );
};

export default SettingsRoot;