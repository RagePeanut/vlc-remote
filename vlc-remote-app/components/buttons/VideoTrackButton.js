import React from 'react';

import { useTranslation } from 'react-i18next';

import RemoteButton from './generic/RemoteButton';
import { switchVideoTrack } from '../../services/vlc';

const VideoTrackButton = ({ style }) => {
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="filmstrip"
            onPress={switchVideoTrack}
        >
            { t('button.video_track', 'Video Track') }
        </RemoteButton>
    );
};

export default VideoTrackButton;