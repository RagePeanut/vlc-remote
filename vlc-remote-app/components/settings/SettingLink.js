import React from 'react';
import { StyleSheet } from 'react-native';

import { withTheme } from 'react-native-paper';
import { useNavigation } from '@react-navigation/native';
import { MaterialCommunityIcons } from '@expo/vector-icons';

import Setting from './Setting';

const SettingLink = ({ title, description, routeName, theme }) => {
    const navigation = useNavigation();

    return (
        <Setting
            title={title}
            description={description}
            right={
                <MaterialCommunityIcons
                    style={styles.icon}
                    size={28}
                    name="chevron-right"
                    color={theme.colors.text}
                />
            }
            onPress={() => navigation.navigate(routeName)}
        />
    );
}

const styles = StyleSheet.create({
    icon: {
        alignSelf: 'center',
    }
});

export default withTheme(SettingLink);