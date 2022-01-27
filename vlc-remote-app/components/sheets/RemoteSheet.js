import React from 'react';
import { View, StyleSheet } from 'react-native';

import { Modalize } from 'react-native-modalize';

import AudioTrackButton from '../buttons/AudioTrackButton';
import DonateButton from '../buttons/DonateButton';
import PowerButton from '../buttons/PowerButton';
import ScreenButton from '../buttons/ScreenButton';
import SubtitleTrackButton from '../buttons/SubtitleTrackButton';
import VideoTrackButton from '../buttons/VideoTrackButton';
import FullscreenButton from "../buttons/FullscreenButton";

const RemoteSheet = ({ sheetRef }) => {
    return (
        <Modalize
            ref={sheetRef}
            adjustToContentHeight
        >
            <View style={styles.content}>
                <View style={styles.row}>
                    <DonateButton style={styles.button}/>
                    <View style={styles.button}/>
                    <PowerButton style={styles.button}/>
                </View>
                <View style={styles.row}>
                    <FullscreenButton style={styles.button}/>
                    <ScreenButton style={styles.button}/>
                    <View style={styles.button}/>
                </View>
                <View style={styles.row}>
                    <VideoTrackButton style={styles.button}/>
                    <AudioTrackButton style={styles.button}/>
                    <SubtitleTrackButton style={styles.button}/>
                </View>
            </View>
        </Modalize>
    )
}

const styles = StyleSheet.create({
    content: {
        paddingHorizontal: 15,
        paddingVertical: 30,
    },
    row: {
        display: 'flex',
        flexDirection: 'row',
    },
    button: {
        flex: 1,
    }
});

export default RemoteSheet;