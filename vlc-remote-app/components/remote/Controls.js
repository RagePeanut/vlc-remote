import React from 'react';

import { View, StyleSheet } from 'react-native';

import FastForwardButton from '../buttons/FastForwardButton';
import NextChapterButton from '../buttons/NextChapterButton';
import PlayButton from '../buttons/PlayButton';
import PreviousChapterButton from '../buttons/PreviousChapterButton';
import RewindButton from '../buttons/RewindButton';

const Controls = () => {
    return (
        <View style={styles.root}>
            <PreviousChapterButton/>
            <RewindButton/>
            <PlayButton/>
            <FastForwardButton/>
            <NextChapterButton/>
        </View>
    );
};

const styles = StyleSheet.create({
    root: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
    },
});

export default Controls;