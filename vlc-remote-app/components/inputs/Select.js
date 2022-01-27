import React, { useState, useCallback } from 'react';

import { Button, Menu, withTheme } from 'react-native-paper';

const Select = ({
    value,
    options,
    mapOptionToText = option => option?.toString(),
    onChange,
    theme,
    ...props
}) => {
    const [ open, setOpen ] = useState(false);

    const handlePress = useCallback(option => {
        onChange(option);
        setOpen(false);
    }, [ onChange ]);

    return (
        <Menu
            visible={open}
            onDismiss={() => setOpen(false)}
            anchor={
                <Button
                    icon="chevron-down"
                    color={theme.colors.text}
                    uppercase={false}
                    onPress={() => setOpen(true)}
                >
                    { mapOptionToText(value) }
                </Button>
            }
            { ...props }
        >
            { options.map(option =>
                <Menu.Item
                    key={option}
                    title={mapOptionToText(option)}
                    onPress={() => handlePress(option)}
                />
            ) }
        </Menu>
    );
};

export default withTheme(Select);