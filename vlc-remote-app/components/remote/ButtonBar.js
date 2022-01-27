import React from 'react';
import { StyleSheet, View } from 'react-native';

import ExplorerButton from '../buttons/ExplorerButton';
import PlaylistButton from '../buttons/PlaylistButton';
import { RIGHT, LEFT } from '../../enums/Position';

const ButtonBar = () => {
    return (
        <View style={styles.root}>
            <ExplorerButton position={LEFT}/>
            <PlaylistButton position={RIGHT}/>
        </View>
    );
};

const styles = StyleSheet.create({
    root: {
        display: 'flex',
        flexDirection: 'row',
    },
});

export default ButtonBar;