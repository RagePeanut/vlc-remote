import React from 'react';

import { useTranslation } from 'react-i18next';

import RemoteButton from './generic/RemoteButton';
import { switchSubtitleTrack } from '../../services/vlc';

const SubtitleTrackButton = ({ style }) => {
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="subtitles"
            onPress={switchSubtitleTrack}
        >
            { t('button.subtitle_track', 'Subtitle Track') }
        </RemoteButton>
    );
};

export default SubtitleTrackButton;