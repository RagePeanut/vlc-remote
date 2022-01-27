import React from 'react';

import InputScreen from './InputScreen';

import { checkPortNumber } from 'api';
import store from 'store/store';

const nonNumbersRegex = /[^\d]/g;

export default () => {
    const validate = async (port) => {
        if(await checkPortNumber(port)) {
            store.setVlcPort(port);
            return true;
        }
        return false;
    };

    const format = port => {
        return port.replace(nonNumbersRegex, "");
    };

    return (
        <InputScreen title="Just one thing..."
                     subtitle="Please insert your VLC port number into the field below."
                     label="VLC Port Number"
                     format={format}
                     validate={validate}
                     invalidMessage="VLC isn't listening on this port number"
                     nextPage="/password"/>
    );
};