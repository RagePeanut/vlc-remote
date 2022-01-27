import React, { useEffect, useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import QRCode from 'qrcode.react';

import Card from './Card';

const useStyles = makeStyles({
   root: {
       // Fixes the QR card being bigger than other cards
       position: "absolute",
   },
});

export default ({ value }) => {
    const classes = useStyles();

    let [ qrValue, setQrValue ] = useState(value);

    useEffect(() => setQrValue(value), [ value ]);

    return (
        <Card>
            <QRCode className={classes.root}
                    value={qrValue}
                    size={160}/>
        </Card>
    );
}