import React, { useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import { CircularProgress } from '@material-ui/core';

import SetupBody from 'components/SetupBody';

import { checkPortNumber, locateVlc } from 'api';

export default () => {
    const history = useHistory();

    useEffect(() => {
        (async () => {
            try {
                await locateVlc();
                const isDefaultPortNumber = await checkPortNumber("8080");
                history.push(isDefaultPortNumber ? "/password" : "/port");
            } catch(error) {
                console.log(error);
            }
        })();
    }, [ history ]);

    return (
        <div>
            <SetupBody title="Thank you for using VLC Remote!" subtitle="Make sure VLC is open while we are setting up the companion app.">
                <CircularProgress/>
            </SetupBody>
        </div>
    );
}