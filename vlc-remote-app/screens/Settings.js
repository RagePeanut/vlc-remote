import React from 'react';
import { StyleSheet } from 'react-native';

import { Button, withTheme } from 'react-native-paper';
import { createStackNavigator } from '@react-navigation/stack';
import { useTranslation } from 'react-i18next';

import SettingsRoot from './views/SettingsRoot';
import SettingsComputers from './views/SettingsComputers';
import SettingsMedias from './views/SettingsMedias';
import SettingsRemote from './views/SettingsRemote';

const { Navigator, Screen } = createStackNavigator();

const SettingsNavigator = ({ theme }) => {
    const { t } = useTranslation();

    return (
        <Navigator
            initialRouteName="Settings"
            screenOptions={{
                headerTitleAlign: 'center',
                headerStyle: {
                    ...styles.header,
                    backgroundColor: theme.colors.background,
                },
                cardStyle: {
                    backgroundColor: theme.colors.background,
                },
            }}
        >
            <Screen name="Settings" component={SettingsRoot} options={{ title: t('settings.root.title', 'Settings') }}/>
            <Screen name="SettingsComputers" component={SettingsComputers} options={{ title: t('settings.computers.title', 'Computers') }}/>
            <Screen name="SettingsMedias" component={SettingsMedias} options={{ title: t('settings.medias.title', 'Medias') }}/>
            <Screen name="SettingsRemote" component={SettingsRemote} options={{ title: t('settings.remote.title', 'Remote') }}/>
        </Navigator>
    );
};

const styles = StyleSheet.create({
    header: {
        elevation: 0,
        shadowOpacity: 0,
        borderBottomWidth: 0,
    },
});

export default withTheme(SettingsNavigator);