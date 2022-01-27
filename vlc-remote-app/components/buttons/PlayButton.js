import React from 'react';

import { useSelector } from 'react-redux';

import ControlButton from './generic/ControlButton';
import { PLAYING } from '../../enums/PlayerState';
import { togglePause } from '../../services/vlc';

const PlayButton = () => {
    const playerState = useSelector(state => state.status.player.state);

    return (
        <ControlButton
            icon={ playerState === PLAYING ? 'pause' : 'play' }
            size={60}
            onPress={togglePause}
        />
    );
};

export default PlayButton;