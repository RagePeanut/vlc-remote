import React from 'react';
import { StyleSheet, DeviceEventEmitter } from 'react-native';

import { withTheme } from 'react-native-paper';
import { MaterialIcons } from '@expo/vector-icons';

import Setting from './Setting';

const SettingComputer = ({ computer, theme }) => {
    return (
        <Setting
            title={computer.name}
            description={computer.ipAddress}
            left={
                <MaterialIcons
                    style={styles.icon}
                    size={28}
                    name={computer.current ? 'connected-tv' : 'tv'}
                    color={theme.colors.text}
                />
            }
            onPress={() => DeviceEventEmitter.emit('computer-open', computer)}
        />
    );
}

const styles = StyleSheet.create({
    icon: {
        alignSelf: 'center',
        marginLeft: 20,
    },
});

export default withTheme(SettingComputer);