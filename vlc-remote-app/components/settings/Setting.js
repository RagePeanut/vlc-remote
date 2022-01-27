import React from 'react';
import { View, StyleSheet } from 'react-native';

import { withTheme } from 'react-native-paper';

import ListItem from '../../libs/react-native-paper/ListItem';

const Setting = ({ title, description, left, right, onPress, theme }) => {
    return (
        <ListItem
            title={title}
            description={description}
            titleStyle={theme.fonts.medium}
            contentStyle={styles.root}
            left={left && (() => 
                <View style={styles.side}>
                    {left}
                </View>
            )}
            right={right && (() =>
                <View style={[ styles.side, styles.right ]}>
                    <View>
                        { right }
                    </View>
                </View>
            )}
            onPress={onPress}
        />
    );
};

const styles = StyleSheet.create({
    root: {
        paddingLeft: 20,
    },
    side: {
        alignSelf: 'center',
    },
    right: {
        display: 'flex',
        alignItems: 'flex-end',
        width: 80,
        marginLeft: 30,
        marginRight: 15,
    }
});

export default withTheme(Setting);