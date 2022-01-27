import React from 'react';
import { View, StyleSheet } from 'react-native';

import { Text, TouchableRipple, withTheme } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';

const RemoteButton = ({ children, icon, Icon = MaterialCommunityIcons, style, onPress, theme }) => {
    return (
        <TouchableRipple
            onPress={onPress}
            style={style}
            theme={{ colors: { text: theme.colors.primary } }}
        >
            <View style={styles.root}>
                <View style={styles.icon}>
                    <Icon name={icon} size={24} color={theme.colors.primary}/>
                </View>
                <Text 
                    style={{
                        ...styles.label,
                        color: theme.colors.primary,
                    }}
                >
                    { children }
                </Text>
            </View>
        </TouchableRipple>
    );
};

const styles = StyleSheet.create({
    root: {
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        height: 80,
    },
    icon: {
        flex: 1,
        display: 'flex',
        justifyContent: 'flex-end',
    },
    label: {
        textAlign: 'center',
        flex: 1,
    }
});

export default withTheme(RemoteButton);