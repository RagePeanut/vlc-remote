import React from 'react';

import { useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

import RemoteButton from './generic/RemoteButton';

const PowerButton = ({ style }) => {
    const open = useSelector(state => state.status.player.open);
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="power"
            onPress={() => { console.log('Power Button') }}
        >
            { t('button.power', 'Power ' + open ? 'ON' : 'OFF', { context: open.toString() }) }
        </RemoteButton>
    );
};

export default PowerButton;