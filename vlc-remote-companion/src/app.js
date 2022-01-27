import React from 'react';
import { MemoryRouter, Route, Redirect, Switch } from 'react-router-dom';
import { CssBaseline} from '@material-ui/core';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';
import { common, orange } from '@material-ui/core/colors';

import HomeScreen from 'screens/HomeScreen';
import PasswordScreen from 'screens/InputScreen/PasswordScreen';
import PortScreen from "screens/InputScreen/PortScreen";
import WelcomeScreen from 'screens/WelcomeScreen';

const theme = createMuiTheme({
    overrides: {
        MuiCssBaseline: {
            "@global": {
                border: 0,
                outline: 0,
                "body, html, #app, #app > div": {
                    height: "100%",
                    width: "100%",
                },
            },
        },
        MuiTypography: {
            root: {
                userSelect: "none",
            },
        },
    },
    palette: {
        primary: {
            main: orange.A400,
            dark: orange[700],
            contrastText: common.white,
        },
    },
});

theme.overrides.MuiCssBaseline["@global"] = {
    ...theme.overrides.MuiCssBaseline["@global"],
    "#app > div": {
        padding: theme.spacing(3),
    },
    "::selection": {
        backgroundColor: theme.palette.primary.main,
        color: theme.palette.primary.contrastText,
    },
}

export default () => {
    const alreadyLaunched = localStorage.getItem("already_launched");
    return (
        <ThemeProvider theme={theme}>
            <CssBaseline/>
            <MemoryRouter>
                <Switch>
                    <Route path="/" exact>
                        { alreadyLaunched ? <Redirect to="/home"/> : <Redirect to="/welcome"/> }
                    </Route>
                    <Route path="/home" component={HomeScreen}/>
                    <Route path="/welcome" component={WelcomeScreen}/>
                    <Route path="/password" component={PasswordScreen}/>
                    <Route path="/port" component={PortScreen}/>
                </Switch>
            </MemoryRouter>
        </ThemeProvider>
    );
};
