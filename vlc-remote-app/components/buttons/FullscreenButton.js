import React from 'react';

import { useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

import RemoteButton from './generic/RemoteButton';
import { toggleFullscreen } from '../../services/vlc';

const FullscreenButton = ({ style }) => {
    const fullscreen = useSelector(state => state.status.player.fullscreen);
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon={ fullscreen ? 'fullscreen-exit' : 'fullscreen' }
            onPress={toggleFullscreen}
        >
            { t('button.fullscreen', fullscreen ? 'Fullscreen' : 'Windowed', { context: fullscreen.toString() }) }
        </RemoteButton>
    );
};

export default FullscreenButton;