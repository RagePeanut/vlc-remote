import React, { useRef, useCallback, useEffect, useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { FAB, Divider, withTheme } from 'react-native-paper';
import { useSelector } from 'react-redux';

import SettingComputer from '../../components/settings/SettingComputer';
import ComputerSheet from '../../components/sheets/ComputerSheet';

const SettingsComputers = ({ theme }) => {
    const computers = useSelector(state => state.computers);
    const [ sheetComputer, setSheetComputer ] = useState(null);
    const computerSheetRef = useRef(null);

    const onOpenComputer = useCallback(computer => {
        setSheetComputer(computer);
        computerSheetRef.current?.open();
    }, []);

    useEffect(() => {
        const listener = DeviceEventEmitter.addListener('computer-open', onOpenComputer);
        return () => {
            listener.remove();
        }
    }, []);

    return (
        <View style={styles.root}>
            { computers.map((computer, index) =>
                <View key={index}>
                    <SettingComputer computer={computer}/>
                    { index < computers.length - 1 && (
                        <Divider/>
                    ) }
                </View>
            ) }
            <FAB
                style={[ styles.fab, { backgroundColor: theme.colors.primary }]}
                color={theme.colors.textOnDark}
                icon="plus"
                onPress={() => onOpenComputer(null)}
            />
            <ComputerSheet
                sheetRef={computerSheetRef}
                computer={sheetComputer}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    root: {
        height: '100%',
    },
    fab: {
        position: 'absolute',
        right: 24,
        bottom: 24,
        zIndex: 0,
        elevation: 0,
    },
    background: {
        ...StyleSheet.absoluteFillObject,
        borderRadius: 20,
    },
})

export default withTheme(SettingsComputers);