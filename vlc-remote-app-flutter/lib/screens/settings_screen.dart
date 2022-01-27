import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../enums/settings_category.dart';
import '../models/computer/computer.dart';
import '../stores/settings_history/settings_history.dart';
import '../utils/locale/app_locale.dart';
import '../widgets/views/settings/computers_settings_view.dart';
import '../widgets/views/settings/explorer_settings_view.dart';
import '../widgets/views/settings/main_settings_view.dart';
import '../widgets/views/settings/medias_settings_view.dart';

class SettingsScreen extends StatefulWidget {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
    Map<SettingsCategory, Widget> _views;
    BuildContext _context;

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _views = {
            SettingsCategory.MAIN: MainSettingsView(
                onCategoryPressed: _navigateTo,
                onLanguageChanged: () => setState((){}),
            ),
            SettingsCategory.COMPUTERS: ComputersSettingsView(
                getScaffoldKey: () => widget._scaffoldKey,
            ),
            SettingsCategory.EXPLORER: ExplorerSettingsView(),
            SettingsCategory.MEDIAS: MediasSettingsView(),
        };
    }

    @override
    Widget build(BuildContext context) {
        SettingsHistory history = Provider.of<SettingsHistory>(context);
        if(_context == null) {
            history.reset(); // Prevents the user not going on main settings when he pressed "back" to exit settings instead of using the back icon at the top left of the page
            _context = context; // Used in didChangeDependencies()
        }
        return Scaffold(
            key: widget._scaffoldKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Observer(
                    builder: (BuildContext context) => AppBar(
                        actions: <Widget>[
                            if(history.currentCategory == SettingsCategory.COMPUTERS)
                                IconButton(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    icon: Icon(FlutterIcons.qrcode_mco),
                                    onPressed: () async {
                                        String data = (await Navigator.of(context).pushNamed("qr_scanner")) as String;
                                        try {
                                            Computer computer = Computer.fromQRData(data);
                                            (_views[SettingsCategory.COMPUTERS] as ComputersSettingsView).showComputerSheet(computer, true);
                                        } catch(e) {
                                            // TODO: show snackbar
                                            print(e);
                                        }
                                    },
                                ),
                        ],
                        backgroundColor: Theme.of(context).colorScheme.background,
                        centerTitle: true,
                        elevation: 0.0,
                        leading: IconButton(
                            color: Theme.of(context).colorScheme.onBackground,
                            icon: const BackButtonIcon(),
                            onPressed: () {
                                SettingsCategory lastHistoryEntry = history.removeLastEntry();
                                if(lastHistoryEntry == null) Navigator.of(context).maybePop();
                                else {
                                    widget._scaffoldKey.currentState.hideCurrentSnackBar();
                                    setState(() {});
                                }
                            }
                        ),
                        title: Text(
                            locale.settingsCategoryTitle(history.currentCategory),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                            ),
                        ),
                    ),
                ),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: _views[history.currentCategory],
        );
    }

    void _navigateTo(SettingsCategory category) {
        SettingsHistory history = Provider.of<SettingsHistory>(_context, listen: false);
        setState(() => history.addEntry(category));
    }
}