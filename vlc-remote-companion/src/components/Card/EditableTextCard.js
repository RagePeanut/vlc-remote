import React, { useRef } from 'react';
import { IconButton, InputBase } from '@material-ui/core';
import { Edit } from '@material-ui/icons';
import { makeStyles } from '@material-ui/core/styles';

import Card from "./Card";

const useStyles = makeStyles(theme => ({
    button: {
        position: "absolute",
        bottom: theme.spacing(1),
        right: theme.spacing(1),
    },
    input: {
        color: theme.palette.primary.main,
        padding: 0,
        textAlign: "center",
        ...theme.typography.h4,
    },
}));

export default ({ onValueChange, title, value }) => {
    const classes = useStyles();
    const input = useRef(null);

    const onInputValueChange = event => {
        onValueChange && onValueChange(event.target.value);
    };

    const onKeyPressInInput = event => {
        if(event.which === 13) {
            input.current.blur();
        }
    }

    const onButtonClick = () => {
        input.current.select();
    };
    
    return (
        <Card title={title}>
            <InputBase classes={ { input: classes.input } }
                       value={value}
                       placeholder={title}
                       onChange={onInputValueChange}
                       onKeyPress={onKeyPressInInput}
                       inputRef={input}
                       inputProps={{ "aria-label": "naked" }}/>
            <IconButton className={classes.button}
                        onClick={onButtonClick}
                        aria-label="edit">
                <Edit/>
            </IconButton>           
        </Card>  
    );
};