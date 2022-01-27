import React, { Suspense, useEffect } from 'react';
import { View, Text, SafeAreaView, StatusBar, StyleSheet } from 'react-native';

import 'react-native-gesture-handler';
import { Provider as StoreProvider, useDispatch, useSelector } from 'react-redux';
import { Provider as ThemeProvider } from 'react-native-paper';
import { PersistGate } from 'redux-persist/integration/react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import './services/i18n';
import getTheme from './services/theme';
import store, { persistor } from './store';
import { fetchPlaylistData } from './store/thunks/playlist';
import { fetchStatusData } from './store/thunks/status';
import Remote from './screens/Remote';
import Settings from './screens/Settings';

const { Navigator, Screen } = createStackNavigator();

// TODO: find a way to add env variables to expo
// console.log(process.env.API_URL);

const App = () => {
    const dispatch = useDispatch();
    const settings = useSelector(state => state.settings);

    // TODO: implement volume
    useEffect(() => {
        setInterval(() => dispatch(fetchStatusData()), 200);
        setInterval(() => dispatch(fetchPlaylistData()), 500);
    }, []);

    const theme = getTheme(settings.theme);

    return (
        <ThemeProvider theme={theme}>
            <NavigationContainer>
                <SafeAreaView style={styles.safeArea}>
                    <Navigator
                        initialRouteName="Remote"
                        screenOptions={{
                            headerMode: false,
                            cardStyle: {
                                backgroundColor: theme.colors.background,
                            }
                        }}
                    >
                        <Screen name="Remote" component={Remote}/>
                        <Screen name="Settings" component={Settings}/>
                    </Navigator>
                </SafeAreaView>
            </NavigationContainer>
        </ThemeProvider>
    );
}

const WrappedApp = () => {
    return (
        <StoreProvider store={store}>
            <PersistGate persistor={persistor}>
                <Suspense fallback={<View><Text>Serveur non lancé</Text></View>}>
                    <App/>
                </Suspense>
            </PersistGate>
        </StoreProvider>
    );
}

const styles = StyleSheet.create({
    safeArea: {
        flex: 1,
        paddingTop: StatusBar.currentHeight,
    },
});

export default WrappedApp;