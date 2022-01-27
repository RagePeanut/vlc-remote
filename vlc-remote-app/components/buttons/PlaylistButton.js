import React from 'react';
import { DeviceEventEmitter } from 'react-native';

import { useTranslation } from 'react-i18next';

import PositionedButton from './generic/PositionedButton';

const PlaylistButton = (props) => {
    const { t } = useTranslation();

    return (
        <PositionedButton
            icon="playlist-play"
            onPress={() => DeviceEventEmitter.emit('playlist-open')}
            {...props}
        >
            { t('button.playlist', 'Playlist') }
        </PositionedButton>
    );
};

export default PlaylistButton;