import React from 'react';

import { useSelector } from 'react-redux';

import ControlButton from './generic/ControlButton';
import { seekChapter } from '../../services/vlc';

const NextChapterButton = () => {
    const { currentChapter, chapterCount } = useSelector(state => ({ ...state.status.media, ...state.status.player }));

    const handlePress = () => {
        if(currentChapter + 1 < chapterCount) {
            seekChapter(currentChapter + 1);
        }
    };

    return (
        <ControlButton
            icon="skip-forward"
            onPress={handlePress}
        />
    );
};

export default NextChapterButton;