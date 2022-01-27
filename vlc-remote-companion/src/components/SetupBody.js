import React from 'react';
import { Box, Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(theme => ({
    root: {
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        alignItems: "center",
        height: "100%",
        padding: theme.spacing(3),
        boxSizing: "border-box",
    },
    subtitle: {
        marginBottom: theme.spacing(3),
    },
}));

export default ({ title, subtitle, children }) => {
    const classes = useStyles();

    return (
        <Box className={classes.root}>
            <Typography variant="h5" gutterBottom>{title}</Typography>
            <Typography className={classes.subtitle} variant="subtitle1">{subtitle}</Typography>
            {children}
        </Box>
    );
}