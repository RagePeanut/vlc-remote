import React from 'react';

import { IconButton, withTheme } from 'react-native-paper';
import { useNavigation } from '@react-navigation/native';

const SettingsButton = ({ style, theme }) => {
    const navigation = useNavigation();
    
    return (
        <IconButton
            style={style}
            icon="cog"
            color={theme.colors.primary}
            size={26}
            onPress={() => navigation.navigate('Settings')}
        />
    );
};

export default withTheme(SettingsButton);