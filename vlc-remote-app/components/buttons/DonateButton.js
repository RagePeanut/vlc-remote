import React from 'react';

import { useTranslation } from 'react-i18next';
import { FontAwesome5 } from '@expo/vector-icons';

import RemoteButton from './generic/RemoteButton';

const DonateButton = ({ style }) => {
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="donate"
            Icon={FontAwesome5}
            onPress={() => console.log('Donate Button')}
        >
            { t('button.donate', 'Donate') }
        </RemoteButton>
    );
};

export default DonateButton;