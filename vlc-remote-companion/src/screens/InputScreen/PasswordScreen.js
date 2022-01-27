import React from 'react';

import InputScreen from './InputScreen';

import { checkPassword } from 'api';
import store from 'store/store';

export default () => {
    const validate = async (password) => {
        if(await checkPassword(password)) {
            store.setPassword(password);
            return true;
        }
        return false;
    };

    return (
        <InputScreen title="One last thing..."
                     subtitle="Please insert your VLC password into the field below (used to control VLC remotely)."
                     label="Your VLC password"
                     validate={validate}
                     invalidMessage="Incorrect password"
                     nextPage="/home"
                     lastSetupScreen/>
    );
}