import React, { useState, useEffect, useMemo } from 'react';
import { StyleSheet, View } from 'react-native';

import { useSelector } from 'react-redux';

import TimeIndicator from './TimeIndicator';
import MarkedSlider from './MarkedSlider';
import { SECOND } from '../../enums/Time';
import { TIME_REMAINING } from '../../enums/TimeIndicator';
import { seek } from '../../services/vlc';

const ProgressBar = () => {
    const rightTimeIndicator = useSelector(state => state.settings.rightTimeIndicator);
    const { currentTime, length, chapters } = useSelector(state => ({ ...state.status.media, ...state.status.player }));
    const [ value, setValue ] = useState(currentTime * SECOND);
    const end = useMemo(() => length * SECOND, [ length ]);

    useEffect(() => {
        setValue(currentTime * SECOND);
    }, [ currentTime, setValue ]);

    const handleChange = newValue => {
        const rounded = Math.round(newValue / SECOND);
        setValue(rounded * SECOND);
        seek(rounded);
    };

    return (
        <View style={styles.root}>
            <View style={styles.indicators}>
                <TimeIndicator
                    style={styles.indicator}
                    time={value}
                />
                <TimeIndicator
                    style={styles.indicator}
                    time={rightTimeIndicator === TIME_REMAINING ? end - value : end}
                />
            </View>
            <MarkedSlider
                value={value}
                max={end}
                onChange={handleChange}
                marks={chapters}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    root: {
        marginHorizontal: 25,
    },
    indicators: {
        display: 'flex',
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: -10,
    },
    indicator: {
        fontSize: 12,
    },
});

export default ProgressBar;