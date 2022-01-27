import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../enums/data_display.dart';
import '../../../stores/settings/settings.dart';
import '../../../utils/locale/app_locale.dart';
import '../../settings_parts/settings_select.dart';
import 'settings_view.dart';

class ExplorerSettingsView extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Settings settings = Provider.of<Settings>(context);

        return SettingsView(
            items: <Widget>[
                Observer(
                    builder: (BuildContext context) => SettingsSelect(
                        title: locale.settingsExplorerDisplayTypeTitle,
                        description: locale.settingsExplorerDisplayTypeDesc,
                        value: settings.explorerDisplay == DataDisplay.GRID
                                    ? locale.settingsExplorerDisplayTypeOptionGrid
                                    : locale.settingsExplorerDisplayTypeOptionList,
                        selectableValues: [
                            locale.settingsExplorerDisplayTypeOptionGrid,
                            locale.settingsExplorerDisplayTypeOptionList,
                        ],
                        onChanged: (String selected) {
                            DataDisplay display = selected == locale.settingsExplorerDisplayTypeOptionGrid
                                ? DataDisplay.GRID
                                : DataDisplay.LIST;
                            settings.setExplorerDisplay(display);
                        },
                    ),
                ),
            ],
        );
    }
}