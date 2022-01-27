import React, { useContext, useRef, useEffect, useState } from 'react';
import { StyleSheet, Image, ImageBackground, View, Dimensions } from 'react-native';

import Carousel from 'react-native-snap-carousel';
import { useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

import PosterContext from '../../context/poster';
import { play } from '../../services/vlc';

const PlaylistCarousel = () => {
    const { i18n: { language } } = useTranslation();
    const { width } = Dimensions.get('window');
    const { getPosterUrlForWidth } = useContext(PosterContext);
    const { playlist, medias } = useSelector(state => state);
    const [ animateIndexChange, setAnimateIndexChange ] = useState(false);
    const carousel = useRef();

    useEffect(() => {
        if(playlist.length === 0) return;
        const index = playlist.findIndex(file => file.current);
        if(carousel.current.currentIndex !== index) {
            setTimeout(() => {
                carousel.current.snapToItem(index, animateIndexChange, false);
                if(!animateIndexChange) setAnimateIndexChange(true);
            });
        }
    }, [ playlist ]);
    return (
        <>
            <Carousel
                ref={carousel}
                data={playlist}
                renderItem={({ item }) => {
                    const media = medias[item.fileName];
                    const uri =  media?.known && media.localized[language]?.posterPath
                        ? getPosterUrlForWidth(media.localized[language].posterPath, width)
                        : null;
                    return (
                        <View style={styles.item}>
                            {/* TODO: create default image */}
                            <ImageBackground
                                source={{ uri: uri ? null : 'https://www.nato-pa.int/sites/default/files/default_images/default-image.jpg' }}
                                style={styles.image}
                            >
                                <Image
                                    style={styles.image}
                                    source={{ uri }}
                                    resizeMode="contain"
                                />
                            </ImageBackground>
                        </View>
                    );
                }}
                sliderWidth={width}
                itemWidth={width}
                onSnapToItem={index => play(playlist[index].id)}
            />
        </>
    );
};

const styles = StyleSheet.create({
    image: {
        height: '100%',
        width: '100%',
    },
    item: {
        marginVertical: 90,
    }
});

export default PlaylistCarousel;