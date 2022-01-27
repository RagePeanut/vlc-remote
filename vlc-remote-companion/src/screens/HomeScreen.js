import React, { useState, useEffect } from 'react';
import { Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

import QRCard from 'components/Card/QRCard';
import TextCard from 'components/Card/TextCard';
import EditableTextCard from 'components/Card/EditableTextCard';

import store from 'store/store';

const nonNumbersRegex = /[^\d]/g;

const useStyles = makeStyles(theme => ({
    root: {
        height: `calc(100% + ${theme.spacing(2)}px)`,
    },
}));

export default () => {
    const classes = useStyles();

    let [ state, setState ] = useState({
        computerName: store.computerName,
        password: store.password,
        vlcPort: store.vlcPort,
        companionPort: store.companionPort,
    });

    useEffect(() => {
        store.addObserver("home", () => {
            setState({
                computerName: store.computerName,
                password: store.password,
                vlcPort: store.vlcPort,
                companionPort: store.companionPort,
            });
        });

        return () => store.removeObserver("home");
    }, []);

    const onVlcPortChange = port => {
        store.setVlcPort(port.replace(nonNumbersRegex, ""));
    }

    return (
        <div>
            <Grid container
                  className={classes.root}
                  spacing={2}
                  alignItems="stretch">
                <Grid item xs={6}>
                    <TextCard title="IP Address" value={store.ipAddress}/>
                </Grid>
                <Grid item xs={6}>
                    <EditableTextCard title="Password" value={state.password} onValueChange={store.setPassword}/>
                </Grid>
                <Grid item xs={6}>
                    <EditableTextCard title="VLC Port Number" value={state.vlcPort} onValueChange={onVlcPortChange}/>
                </Grid>
                <Grid item xs={6}>
                    <TextCard title="Companion Port Number" value={state.companionPort}/>
                </Grid>
                <Grid item xs={6}>
                    <EditableTextCard title="Name" value={state.computerName} onValueChange={store.setComputerName}/>
                </Grid>
                <Grid item xs={6}>
                    <QRCard value={`ip=${store.ipAddress}\npw=${state.password}\nvp=${state.vlcPort}\ncp=${state.companionPort}\nnm=${state.computerName}`}/>
                </Grid>
            </Grid>
        </div>
    );
}