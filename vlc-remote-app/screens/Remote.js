import React, { useRef, useCallback, useEffect } from 'react';
import { StyleSheet, View, DeviceEventEmitter } from 'react-native';

import { Button } from 'react-native-paper';

import { PosterProvider } from '../context/poster';
import ButtonBar from '../components/remote/ButtonBar';
import Controls from '../components/remote/Controls';
import MediaTitle from '../components/remote/MediaTitle';
import PlaylistCarousel from '../components/remote/PlaylistCarousel';
import ProgressBar from '../components/remote/ProgressBar';
import SettingsButton from '../components/buttons/SettingsButton';
import RemoteSheet from '../components/sheets/RemoteSheet';
import PlaylistSheet from '../components/sheets/PlaylistSheet';

const Remote = () => {
    const remoteSheetRef = useRef(null);
    const playlistSheetRef = useRef(null);

    const onOpenRemote = useCallback(() => {
        remoteSheetRef.current?.open();
    }, []);

    const onOpenPlaylist = useCallback(() => {
        playlistSheetRef.current?.open();
    }, []);

    useEffect(() => {
        const listener = DeviceEventEmitter.addListener('playlist-open', onOpenPlaylist);
        return () => {
            listener.remove();
        }
    }, []);

    return (
        <PosterProvider>
            <View style={styles.root}>
                <SettingsButton style={styles.settings}/>
                <PlaylistCarousel/>
                <ProgressBar/>
                <MediaTitle/>
                <Controls/>
                <Button onPress={onOpenRemote}>
                    Open remote
                </Button>
                <ButtonBar/>
            </View>
            <RemoteSheet sheetRef={remoteSheetRef}/>
            <PlaylistSheet sheetRef={playlistSheetRef}/>
        </PosterProvider>
    );
}

const styles = StyleSheet.create({
    root: {
        display: 'flex',
        justifyContent: 'flex-end',
        flex: 1,
    },
    settings: {
        position: 'absolute',
        top: 0,
        right: 0,
        zIndex: 10,
    },
    background: {
        ...StyleSheet.absoluteFillObject,
        borderRadius: 20,
    },
    sheet: {
        paddingTop: 20,
    },
});

export default Remote;