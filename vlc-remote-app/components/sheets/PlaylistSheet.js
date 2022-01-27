import React from 'react';

import { Modalize } from 'react-native-modalize';
import { useSelector } from 'react-redux';

import PlaylistItem from '../lists/PlaylistItem';

const PlaylistSheet = ({ sheetRef }) => {
    const playlist = useSelector(state => state.playlist);

    return (
        <Modalize
            ref={sheetRef}
            modalHeight={400}
        >
            { playlist.map(item => {
                <PlaylistItem key={item.id} item={item}/>
            }) }
        </Modalize>
    );
}

export default PlaylistSheet;