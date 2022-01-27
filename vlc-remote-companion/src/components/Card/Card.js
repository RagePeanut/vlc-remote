import React from 'react';
import { Card, CardContent, Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(theme => ({
    root: {
        height: "100%",
    },
    content: {
        position: "relative",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        alignItems: "center",
        height: "100%",
        "&:last-child": {
            paddingBottom: theme.spacing(2),
        },
    },
}));

export default ({ children, title }) => {
    const classes = useStyles();

    return (
        <Card className={classes.root}>
            <CardContent className={classes.content}>
                <Typography variant="h6" align="center">{title}</Typography>
                {children}
            </CardContent>
        </Card>
    );
}