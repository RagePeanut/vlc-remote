import React from 'react';
import { Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

import Card from './Card';

const useStyles = makeStyles({
    root: {
        userSelect: "text",
    },
});

export default ({ title, value }) => {
    const classes = useStyles();

    return (
        <Card title={title}>
            <Typography className={classes.root} color="primary" variant="h4" align="center">{value}</Typography>
        </Card>
    );
}