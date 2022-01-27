import React from 'react';

import { useTranslation } from 'react-i18next';

import RemoteButton from './generic/RemoteButton';

const ScreenButton = ({ style }) => {
    const { t } = useTranslation();

    return (
        <RemoteButton
            style={style}
            icon="monitor"
            onPress={() => console.log('Screen Button')}
        >
            { t('button.screen', 'Screen {{number}}', { number: 1 }) }
        </RemoteButton>
    );
};

export default ScreenButton;