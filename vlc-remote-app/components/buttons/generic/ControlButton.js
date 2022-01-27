import React from 'react';
import { StyleSheet } from 'react-native';

import { IconButton, withTheme } from 'react-native-paper';
// import color from 'color';

const ControlButton = ({ icon, size = 40, onPress, theme }) => {
    return (
        <IconButton
            icon={icon}
            size={size}
            color={theme.colors.primary}
            onPress={onPress}
            style={styles.root}
            // rippleColor={color(theme.colors.primary).alpha(theme.dark ? 0.32 : 0.2).rgb().string()}
            rippleColor={theme.colors.primary}
        />
    );
};

const styles = StyleSheet.create({
    root: {
        margin: 0,
    }
});

export default withTheme(ControlButton);