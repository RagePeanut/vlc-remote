import { DefaultTheme as PaperLightTheme, DarkTheme as PaperDarkTheme } from 'react-native-paper';
import { DefaultTheme as NavigationLightTheme, DarkTheme as NavigationDarkTheme } from '@react-navigation/native';

import { LIGHT, DARK } from '../enums/Theme';

const globalColors = {
    danger: '#B00020',
    textOnDark: '#FFFFFF',
}

const themes = {
    [LIGHT]: {
        ...NavigationLightTheme,
        ...PaperLightTheme,
        colors: {
            ...NavigationLightTheme.colors,
            ...PaperLightTheme.colors,
            ...globalColors,
        }
    },
    [DARK]: {
        ...NavigationDarkTheme,
        ...PaperDarkTheme,
        colors: {
            ...NavigationDarkTheme.colors,
            ...PaperDarkTheme.colors,
            ...globalColors,
        }
    }
};

export default theme => themes[theme];