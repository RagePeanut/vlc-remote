import React, { useState, useEffect } from 'react';
import { Image, StyleSheet } from 'react-native';

import { Swipeable } from 'react-native-gesture-handler';
import { withTheme } from 'react-native-paper';
import { useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

import ListItem from '../../libs/react-native-paper/ListItem';
import PlaylistItemAction from './PlaylistItemAction';
import Duration from '../../models/Duration';
import { play, removeFromPlaylist } from '../../services/vlc';
import { LEFT, RIGHT } from '../../enums/Position';
import { SECOND } from '../../enums/Time';
import PosterContext from '../../context/poster';

const PlaylistItem = ({ item, theme }) => {
    const { i18n: { language } } = useTranslation();
    const { getPosterUrlForWidth } = useContext(PosterContext);
    const { medias, useOriginalTitle } = useSelector(state => ({
        medias: state.medias,
        useOriginalTitle: state.settings.useOriginalTitle,
    }));

    const [ ready, setReady ] = useState(false);
    const [ title, setTitle ] = useState(null);
    const [ poster, setPoster ] = useState('https://www.nato-pa.int/sites/default/files/default_images/default-image.jpg');
    const [ description, setDescription ] = useState(null);

    useEffect(() => {
        const durationOptions = {
            showSeconds: false,
            separator: 'h',
        };
        const media = medias[item.fileName];
        if(media?.known) {
            setDescription(media.releaseDate.match(/\d{4}/)[0] + ' • ' + new Duration(item.duration, SECOND).toString(durationOptions));
            if(media.localized[language]) {
                setTitle(useOriginalTitle ? media.originalTitle : media.localized[language].title);
                if(media.localized[language].posterPath) {
                    setPoster(getPosterUrlForWidth(media.localized[language].posterPath, 60));
                } 
            } else {
                setTitle(media.originalTitle);
            }
        } else {
            setTitle(item.fileName);
            setDescription(new Duration(item.duration, SECOND).toString(durationOptions));
        }
        setReady(true);
    }, [ language, medias[item.fileName], useOriginalTitle ]);

    if(!ready) {
        return null;
    }

    return (
        <Swipeable
            renderLeftActions={() => <PlaylistItemAction position={LEFT}/>}
            renderRightActions={() => <PlaylistItemAction position={RIGHT}/>}
            onSwipeableOpen={() => removeFromPlaylist(item.id)}
        >
            <ListItem
                title={title}
                description={description}
                titleNumberOfLines={2}
                descriptionNumberOfLines={1}
                contentStyle={styles.content}
                style={[ styles.root, { backgroundColor: item.current ? theme.colors.surface : theme.colors.background } ]}
                left={() =>
                    <Image
                        style={styles.image}
                        source={{ uri: poster }}
                    />
                }
                onPress={() => item.current || play(item.id)}
            />
        </Swipeable>
    );
}

const styles = StyleSheet.create({
    root: {
        paddingVertical: 10,
        paddingHorizontal: 15,
    },
    content: {
        justifyContent: 'flex-start',
    },
    image: {
        height: 90, 
        width: 60,
    },
});

export default withTheme(PlaylistItem);