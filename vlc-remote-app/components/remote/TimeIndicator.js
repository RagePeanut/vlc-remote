import React from 'react';

import { Text } from 'react-native-paper';

import Duration from '../../models/Duration';

const TimeIndicator = ({ time, style }) => {
    const duration = new Duration(time);

    return (
        <Text style={style}>
            { duration.toString() }
        </Text>
    );
};

export default TimeIndicator;