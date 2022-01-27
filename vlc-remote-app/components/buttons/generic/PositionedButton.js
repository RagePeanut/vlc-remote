import React from 'react';
import { StyleSheet, View } from 'react-native';

import { Text, TouchableRipple, withTheme } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';

import { LEFT } from '../../../enums/Position';

const PositionedButton = ({ children, icon, Icon = MaterialCommunityIcons, position, onPress, theme }) => {
    const contentStyle = {
        ...styles.content,
        ...(position === LEFT ? styles.leftContent : styles.rightContent),
    };

    return (
        <TouchableRipple
            onPress={onPress}
            style={styles.root}
            labelStyle={styles.label}
            theme={{ colors: { text: theme.colors.primary } }}
        >
            <View style={contentStyle}>
                <Icon style={styles.icon} name={icon} size={18} color={theme.colors.primary}/>
                <View style={styles.innerSpace}/>
                <Text style={{ ...styles.label, color: theme.colors.primary }}>
                    { children }
                </Text>
            </View>
        </TouchableRipple>
    );
};

const styles = StyleSheet.create({
    root: {
        flex: 1,
        borderRadius: 0,
        paddingHorizontal: 10,
    },
    content: {
        height: 50,
        marginLeft: 5,
        marginRight: 5,
        justifyContent: 'flex-start',
        alignItems: 'center',
    },
    leftContent: {
        flexDirection: 'row',
    },
    rightContent: {
        flexDirection: 'row-reverse',
    },
    label: {
        fontWeight: '600',
    },
    innerSpace: {
        height: 1,
        width: 8,
    },
});

export default withTheme(PositionedButton);