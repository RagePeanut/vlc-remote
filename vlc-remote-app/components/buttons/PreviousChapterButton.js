import React from 'react';

import { useSelector } from 'react-redux';

import ControlButton from './generic/ControlButton';
import { seekChapter } from '../../services/vlc';

const PreviousChapterButton = () => {
    const currentChapter = useSelector(state => state.status.player.currentChapter);

    const handlePress = () => {
        if(currentChapter > 0) {
            seekChapter(currentChapter - 1);
        } else {
            seekChapter(0);
        }
    }

    return (
        <ControlButton
            icon="skip-backward"
            onPress={handlePress}
        />
    );
};

export default PreviousChapterButton;