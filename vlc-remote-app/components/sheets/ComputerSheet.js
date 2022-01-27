import React, { useCallback } from 'react';
import { View, StyleSheet } from 'react-native';

import { Button, TextInput, HelperText, Text, Switch } from 'react-native-paper';
import { Modalize } from 'react-native-modalize';
import { TouchableWithoutFeedback } from 'react-native-gesture-handler';
// import TextInputMask from 'react-native-text-input-mask';
import { useForm, Controller } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { useDispatch, useSelector } from 'react-redux';

import useYupResolver from '../../hooks/useYupResolver';
import { computerSchema } from '../../services/yup';
import { addComputer, editComputer } from '../../store/slices/computers';

const ComputerSheet = ({ sheetRef, computer }) => {
    const { t } = useTranslation();
    const dispatch = useDispatch();
    const computers = useSelector(state => state.computers);

    const computerResolver = useYupResolver(computerSchema);
    const { control, errors, handleSubmit } = useForm({
        resolver: computerResolver,
        defaultValues: {
            name: computer?.name ?? '',
            ipAddress: computer?.ipAddress ?? '',
            vlcPortNumber: computer?.vlcPortNumber ?? '',
            password: computer?.password ?? '',
            companionPortNumber: computer?.companionPortNumber ?? '',
            useByDefault: computer?.useByDefault ?? true,
        },
        reValidateMode: 'onChange',
    });

    const onSubmit = useCallback(data => {
        data.companionPortNumber = data.companionPortNumber || null;
        if(!computer) {
            data.id = computers.length;
            dispatch(addComputer(data));
        } else {
            dispatch(editComputer(data));
        }
    }, [ computers, dispatch ]);

    return (
        <Modalize
            ref={sheetRef}
            adjustToContentHeight
        >
            <View style={[ styles.root ]}>
                <Controller
                    name="name"
                    control={control}
                    render={({ onChange, value }) => (
                        <>
                            <TextInput
                                style={styles.input}
                                label={t('form.computer.name.label', 'Name')}
                                placeholder={t('form.computer.name.hint', 'My Computer')}
                                value={value}
                                onChangeText={onChange}
                            />
                            { errors.name && (
                                <HelperText
                                    style={styles.error}
                                    type="error"
                                >
                                    { errors.name.message }
                                </HelperText>
                            ) }
                        </>
                    )}
                />
                <Controller
                    name="ipAddress"
                    control={control}
                    render={({ onChange, value }) => (
                        <>
                            <TextInput
                                style={styles.input}
                                label={t('form.computer.ip-address.label', 'IP Address')}
                                placeholder="Your computer's IP address"
                                value={value}
                                onChangeText={onChange}
                                keyboardType="numeric"
                                // render={props =>
                                //     <TextInputMask
                                //         {...props}
                                //         mask={'[009]{.}[009]{.}[099]{.}[099]'}
                                //     />
                                // }
                            />
                            { errors.ipAddress && (
                                <HelperText
                                    style={styles.error}
                                    type="error"
                                >
                                    { errors.ipAddress.message }
                                </HelperText>
                            ) }
                        </>
                    )}
                />
                <Controller
                    name="vlcPortNumber"
                    control={control}
                    render={({ onChange, value }) => (
                        <>
                            <TextInput
                                style={styles.input}
                                label={t('form.computer.vlc-port-number.label', 'VLC Port Number (default: 8080)')}
                                placeholder="VLC's port number"
                                value={value}
                                onChangeText={onChange}
                                keyboardType="numeric"
                                // render={props => 
                                //     <TextInputMask
                                //         {...props}
                                //         mask={'[00999]'}
                                //     />
                                // }
                            />
                            { errors.vlcPortNumber && (
                                <HelperText
                                    style={styles.error}
                                    type="error"
                                >
                                    { errors.vlcPortNumber.message }
                                </HelperText>
                            ) }
                        </>
                    )}
                />
                <Controller
                    name="password"
                    control={control}
                    render={({ onChange, value }) => (
                        <>
                            <TextInput
                                style={styles.input}
                                label={t('form.computer.password.label', 'Password')}
                                placeholder={t('form.computer.password.hint', 'The password you\'ve configured on VLC')}
                                value={value}
                                onChangeText={onChange}
                            />
                            { errors.password && (
                                <HelperText
                                    style={styles.error}
                                    type="error"
                                >
                                    { errors.password.message }
                                </HelperText>
                            ) }
                        </>
                    )}
                />
                <Controller
                    name="companionPortNumber"
                    control={control}
                    render={({ onChange, value }) => (
                        <>
                            <TextInput
                                style={styles.input}
                                label={t('form.computer.companion-port-number.label', 'Companion Port Number (default: 27797)')}
                                placeholder="The companion app's port number (optional)"
                                value={value}
                                onChangeText={onChange}
                                keyboardType="numeric"
                                // render={props => 
                                //     <TextInputMask
                                //         {...props}
                                //         mask={'[00009]'}
                                //     />
                                // }
                            />
                            { errors.companionPortNumber && (
                                <HelperText
                                    style={styles.error}
                                    type="error"
                                >
                                    { errors.companionPortNumber.message }
                                </HelperText>
                            ) }
                        </>
                    )}
                />
                <Controller
                    name="useByDefault"
                    control={control}
                    render={({ onChange, value }) => (
                        <View style={styles.useByDefault}>
                            <Text>
                                { t('form.computer.use-by-default.label', 'Use by default') }
                            </Text>
                            <TouchableWithoutFeedback
                                onPress={() => onChange(!value)}
                            >
                                <Switch value={value}/>
                            </TouchableWithoutFeedback>
                        </View>
                    )}
                />
                <Button
                    style={styles.button}
                    mode="contained"
                    onPress={handleSubmit(onSubmit)}
                >
                    { t('button.save', 'Save') }
                </Button>
            </View>
        </Modalize>
    );
};

const styles = StyleSheet.create({
    root: {
        padding: 25,
        paddingTop: 0
    },
    input: {
        backgroundColor: '#FFF0',
        paddingHorizontal: 0,
        marginBottom: 10,
    },
    button: {
        marginTop: 20,
        zIndex: 0,
        elevation: 0,
    },
    error: {
        paddingHorizontal: 0,
    },
    useByDefault: {
        marginTop: 20,
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between'
    }
});

export default ComputerSheet;