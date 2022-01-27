import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';

import { Text, withTheme } from 'react-native-paper';
import { FontAwesome5 } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { LEFT } from '../../enums/Position';

const PlaylistItemAction = ({ position, theme }) => {
    const { t } = useTranslation()
    const [ contentStyle ] = useState([ styles.root, { color: theme.colors.textOnDark } ]);
    const [ style ] = useState([ styles.content, { backgroundColor: theme.colors.danger } ]);

    return (
        <View style={[ ...style, { flexDirection: position === LEFT ? 'row' : 'row-reverse' } ]}>
            <FontAwesome5 name="trash" size={20} style={contentStyle}/>
            <Text style={contentStyle}>
                { t('button.remove', 'Remove') }
            </Text>
        </View>
    );
};

const styles = StyleSheet.create({
    root: {
        flex: 1,
        justifyContent: 'flex-start',
        alignItems: 'center',
        flexDirection: 'row',
        backgroundColor: 'red',
        paddingHorizontal: 15,
    },
    content: {
        marginHorizontal: 5,
    },
});

export default withTheme(PlaylistItemAction);