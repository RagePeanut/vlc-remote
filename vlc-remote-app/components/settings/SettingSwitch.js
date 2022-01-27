import React from 'react';

import { Switch } from 'react-native-paper';

import Setting from './Setting';

const SettingSwitch = ({ title, description, onChange, ...props }) => {
    return (
        <Setting
            title={title}
            description={description}
            right={<Switch onValueChange={onChange} {...props}/>}
        />
    );
};

export default SettingSwitch;