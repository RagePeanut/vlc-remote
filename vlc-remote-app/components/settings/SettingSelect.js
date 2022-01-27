import React from 'react';

import Setting from './Setting';
import Select from '../../components/inputs/Select';

const ListItemSelect = ({ title, description, ...props }) => {
    return (
        <Setting
            title={title}
            description={description}
            right={<Select {...props}/>}
        />
        
    );
};

export default ListItemSelect;