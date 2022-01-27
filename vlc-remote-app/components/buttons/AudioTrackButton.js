import React from 'react';

import { useTranslation } from 'react-i18next';
import { MaterialIcons } from '@expo/vector-icons';

import RemoteButton from './generic/RemoteButton';
import { switchAudioTrack } from '../../services/vlc';

const AudioTrackButton = ({ style }) => {
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="multitrack-audio"
            Icon={MaterialIcons}
            onPress={switchAudioTrack}
        >
            { t('button.audio_track', 'Audio Track') }
        </RemoteButton>
    );
};

export default AudioTrackButton;