import React, { useMemo } from 'react';
import { StyleSheet } from 'react-native';

import { Text } from 'react-native-paper';
import { useSelector } from 'react-redux';
import { useTranslation } from 'react-i18next';

const MediaTitle = () => {
    const { i18n: { language } } = useTranslation();
    const { fileName, year, medias, useOriginalTitle } = useSelector(state => ({
        ...state.status.media,
        medias: state.medias,
        useOriginalTitle: state.settings.useOriginalTitle,
    }));

    const title = useMemo(() => {
        const media = medias[fileName];
        if(media?.known) {
            if(!useOriginalTitle && media.localized[language]) {
                return `${media.localized[language].title} (${new Date(media.releaseDate).getFullYear()})`;
            }
            return `${media.originalTitle} (${new Date(media.releaseDate).getFullYear()})`;
        }
        return fileName + (year ? ` (${year})` : '');
    }, [ fileName, year, medias, language, useOriginalTitle ]);

    return (
        <Text style={styles.root} numberOfLines={1}>
            { title }
        </Text>
    );
};

export default MediaTitle;

const styles = StyleSheet.create({
    root: {
        textAlign: 'center',
        marginTop: 10,
        marginBottom: 5,
        marginHorizontal: 25,
        fontSize: 15,
    },
});