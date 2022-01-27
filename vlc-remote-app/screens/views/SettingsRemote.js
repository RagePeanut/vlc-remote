import React, { useCallback } from 'react';
import { View } from 'react-native';

import { Divider } from 'react-native-paper';
import { useTranslation } from 'react-i18next';
import { useSelector, useDispatch } from 'react-redux';

import SettingSelect from '../../components/settings/SettingSelect';
import Volume from '../../enums/Volume';
import TimeIndicator from '../../enums/TimeIndicator';
import { capitalize } from '../../utils/string';
import { setMaxVolume, setRightTimeIndicator } from '../../store/slices/settings';

const SettingsRemote = () => {
    const { t } = useTranslation();
    const settings = useSelector(state => state.settings);
    const dispatch = useDispatch();
    
    const handleMaxVolumeChange = useCallback(volume => {
        return dispatch(setMaxVolume(volume));
    }, [ dispatch, setMaxVolume ]);

    const handleRightTimeIndicatorChange = useCallback(indicator => {
        return dispatch(setRightTimeIndicator(indicator));
    }, [ dispatch, setRightTimeIndicator ]);

    return (
        <View>
            <SettingSelect
                title={t('settings.remote.max_volume.title', 'Maximum Volume')}
                description={t('settings.remote.max_volume.description', 'The maximum volume you can set for VLC.')}
                value={settings.maxVolume}
                options={Object.values(Volume)}
                mapOptionToText={option => `${option}%`}
                onChange={handleMaxVolumeChange}
            />
            <Divider/>
            <SettingSelect
                title={t('settings.remote.right_time_indicator.title', 'Right Time Indicator')}
                description={t('settings.remote.right_time_indicator.description', 'What the right time indicator above the progress bar should represent.')}
                value={settings.rightTimeIndicator}
                options={Object.values(TimeIndicator)}
                mapOptionToText={option => t('settings.remote.right_time_indicator.options.' + option, capitalize(option, true))}
                onChange={handleRightTimeIndicatorChange}
            />
        </View>
    );
};

export default SettingsRemote;