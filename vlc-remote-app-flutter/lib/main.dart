import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_watcher/volume_watcher.dart';

import 'screens/qr_scanner.dart';
import 'screens/remote.dart';
import 'screens/settings_screen.dart';
import 'services/companion.dart';
import 'services/tmdb.dart';
import 'services/vlc.dart';
import 'stores/files/files.dart';
import 'stores/language/language.dart';
import 'stores/settings/settings.dart';
import 'stores/settings_history/settings_history.dart';
import 'stores/status/status.dart';
import 'utils/locale/app_locale.dart';
import 'utils/sizer.dart';

// TODO: use inkwell instead of gesturedetector for all buttons

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<dynamic> res = await Future.wait([
        VolumeWatcher.getMaxVolume,
        (() async {
            Files files = Files();
            List<dynamic> res = await Future.wait([
                SharedPreferences.getInstance(),
                LocalStorage("storage").ready,
                (() async {
                    await DotEnv.load(fileName: '.env');
                    await TMDb.init(files);
                })(),
            ]);
            Settings settings = Settings(prefs: res[0]);
            Status status = Status(settings: settings);
            await Future.wait([
                VLC.init(files, status),
                Companion.init(files, status),
            ]);
            files.init(res[0].getInt("default_computer"));
            VLC.start();
            Companion.start();
            return [ files, settings, status ];
        })(),
        locale.init(),
    ]);
    runApp(
        App(
            maxVolume: res[0],
            files: res[1][0],
            settings: res[1][1],
            status: res[1][2],
        ),
    );
}

class App extends StatelessWidget {
    App({
        @required this.maxVolume,
        @required this.files,
        @required this.settings,
        @required this.status,
    }) : this.language = Language(),
         this.settingsHistory = SettingsHistory();

    final num maxVolume;
    final Files files;
    final Language language;
    final Settings settings;
    final SettingsHistory settingsHistory;
    final Status status;

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            child: MaterialApp(
                title: "VLC Remote",
                theme: ThemeData(
                    colorScheme: ColorScheme.dark(
                        background: Color(0xFF121212), // Co lor(0xFF313030),
                        onBackground: Colors.white,
                        surface: Color(0xFF1D1D1D), // Co lor(0xFF464646),
                        onSurface: Colors.white,
                        primary: Color(0xFFFF9100), // Co lor(0xFFFB9E3F), // Co lor(0xFFF48B00),
                        primaryVariant: Color(0xFF804900), // Co lor(0xFF744412),
                        onPrimary: Colors.white,
                        secondary: Colors.white,
                        secondaryVariant: Color(0xFF9E9E9E),
                        error: Color(0xFFC83E4D),
                        onError: Colors.white,
                    ),
                ),
                home: SafeArea(
                    child: Scaffold(
                        backgroundColor: Color(0xFF121212),// Color(0xFF131515),// Color(0xFF313030),
                        body: _PageWrapper(
                            page: Navigator(
                                initialRoute: "remote",
                                onGenerateRoute: (RouteSettings settings) {
                                    RoutePageBuilder builder;
                                    switch(settings.name) {
                                        case "remote":
                                            builder = (_, a1, a2) => Remote(maxVolume: maxVolume);
                                            break;
                                        case "settings":
                                            builder = (_, a1, a2) => SettingsScreen();
                                            break;
                                        case "qr_scanner":
                                            builder = (_, a1, a2) => QRScanner();
                                            break;
                                        default:
                                            throw Exception('Invalid route: ${settings.name}');
                                    }
                                    return PageRouteBuilder(pageBuilder: builder, settings: settings, transitionDuration: Duration.zero);
                                },
                            ),
                        ),
                    ),
                ),
                debugShowCheckedModeBanner: false,
            ),
            providers: [
                Provider<Files>.value(value: files),
                Provider<Language>.value(value: language),
                Provider<Settings>.value(value: settings),
                Provider<SettingsHistory>.value(value: settingsHistory),
                Provider<Status>.value(value: status),
            ],
        );
    }
}

class _PageWrapper extends StatelessWidget {
    _PageWrapper({this.page});

    final Widget page;

    @override
    Widget build(BuildContext context) {
        if(Sizer.deviceHeight == null) Sizer.init(context);
        return page;
    }
}
