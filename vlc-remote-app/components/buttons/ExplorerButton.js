import React from 'react';

import { useTranslation } from 'react-i18next';

import PositionedButton from './generic/PositionedButton';

const ExplorerButton = (props) => {
    const { t } = useTranslation();

    return (
        <PositionedButton
            icon="compass"
            onPress={() => console.log('Explorateur')}
            {...props}
        >
            { t('button.explorer', 'Expldforer') }
        </PositionedButton>
    );
};

export default ExplorerButton;