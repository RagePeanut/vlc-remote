import React from 'react';
import { View, StyleSheet } from 'react-native';

import { withTheme } from 'react-native-paper';

import Slider from 'react-native-slider';

const MarkedSlider = ({ value, min = 0, max, marks, onChange, theme }) => {
    return (
        <View>
            <Slider
                value={value}
                minimumValue={min}
                maximumValue={max}
                onValueChange={onChange}
                minimumTrackTintColor={theme.colors.primary}
                thumbTintColor={theme.colors.primary}
                thumbStyle={styles.thumb}
                trackStyle={styles.track}
            />
            <View style={styles.marks}>
                { marks.map(mark => 
                    <View 
                        key={mark}
                        style={{
                            ...styles.mark,
                            left: (mark / (max - min) * 100) + '%',
                            backgroundColor: theme.colors.primary,
                        }
                    }/>
                ) }
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    marks: {
        position: 'relative',
        marginHorizontal: 8,
    },
    mark: {
        position: 'absolute',
        top: -22.2,
        height: 3,
        width: 2,
        marginLeft: -1,
    },
    thumb: {
        height: 14,
        width: 14,
    },
    track: {
        height: 3,
    }
});

export default withTheme(MarkedSlider);