import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { Box, Button, CircularProgress, FilledInput, FormControl, FormHelperText, InputLabel, Link, Slide , Snackbar } from '@material-ui/core';
import { Alert } from '@material-ui/lab';
import { makeStyles, useTheme } from '@material-ui/core/styles';

import SetupBody from 'components/SetupBody';

const useStyles = makeStyles(theme => ({
    button: {
        height: "100%",
        borderTopLeftRadius: 0,
        borderBottomLeftRadius: 0,
    },
    progress: {
        position: "absolute",
        top: "50%",
        left: "50%",
        margin: `-${theme.spacing(1.5)}px 0 0 -${theme.spacing(0.75)}px`,
    },
}));

export default ({ format, invalidMessage, label, lastSetupScreen, nextPage, subtitle, title, validate }) => {
    const theme = useTheme();
    const classes = useStyles();
    const history = useHistory();

    let [ validating, setValidating ] = useState(false);
    let [ showSnackbar, setShowSnackbar ] = useState(false);
    let [ value, setValue ] = useState();

    const onValidate = async (event) => {
        // Button clicked or enter pressed
        if(event.type === "click" || event.which === 13) {
            const _validate = async () => {
                setValidating(true);
                return validate(value);
            };
    
            if(value) {
                if(!validate || await _validate()) {
                    history.push(nextPage);
                    if(lastSetupScreen) {
                        localStorage.setItem("already_launched", "true");
                    }
                } else {
                    setValidating(false);
                    setShowSnackbar(true);
                }
            }
        }
    }

    const onValueChange = event => {
        setValue(format ? format(event.target.value) : event.target.value);
    };

    const onSnackbarClose = (_, reason) => {
        if(reason !== "clickaway") {
            setShowSnackbar(false);
        }
    };

    const id = `${label.replace(" ", "-").toLowerCase()}-input`;

    return (
        <div>
            <SetupBody title={title} subtitle={subtitle}>
                <FormControl required>
                    <InputLabel variant="filled" htmlFor={id}>{label}</InputLabel>
                    <Box display="flex">
                        <FilledInput value={value}
                                     onChange={onValueChange}
                                     onKeyPress={onValidate}
                                     id={id}
                                     aria-describedby={`${id}-text`}
                                     style={{ width: "100%" }}
                                     autoFocus/>
                        <Box position="relative">
                            <Button className={classes.button}
                                    onClick={onValidate}
                                    variant="contained"
                                    color="primary"
                                    disabled={validating}
                                    disableElevation>
                                Done
                            </Button>
                            { validating && <CircularProgress className={classes.progress} size={theme.spacing(3)}/> }
                        </Box>
                    </Box>
                    <FormHelperText>
                        <Link href="https://www.youtube.com/watch?v=CwW7HjwCMN8" target="_blank" rel="noopener">Check this video</Link> for help on how to setup VLC for remote control
                    </FormHelperText>
                </FormControl>
            </SetupBody>
            <Snackbar open={showSnackbar}
                      onClose={onSnackbarClose}
                      autoHideDuration={4000}
                      TransitionComponent={Slide}
                      key={Slide.name}>
                <Alert severity="error"
                       onClose={onSnackbarClose}
                       variant="filled"
                       elevation={6}>
                    {invalidMessage}
                </Alert>
            </Snackbar>
        </div>
    );
}