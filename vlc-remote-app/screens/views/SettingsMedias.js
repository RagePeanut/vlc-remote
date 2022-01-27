import React from 'react';
import { View } from 'react-native';

import { useTranslation } from 'react-i18next';
import { useSelector, useDispatch } from 'react-redux';

import SettingSwitch from '../../components/settings/SettingSwitch';
import { setUseOriginalTitle } from '../../store/slices/settings';

const SettingsMedias = () => {
    const { t } = useTranslation();
    const settings = useSelector(state => state.settings);
    const dispatch = useDispatch();
    
    return (
        <View>
            <SettingSwitch
                title={t('settings.medias.use_original_title.title', 'Use original titles')}
                description={t('settings.medias.use_original_title.description', 'Show medias original titles instead of localized titles.')}
                value={settings.useOriginalTitle}
                onChange={value => dispatch(setUseOriginalTitle(value))}
            />
        </View>
    );
};

export default SettingsMedias;