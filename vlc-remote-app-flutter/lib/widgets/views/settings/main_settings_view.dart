import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/settings_category.dart';
import '../../../stores/language/language.dart';
import '../../../utils/locale/app_locale.dart';
import '../../settings_parts/settings_category_button.dart';
import '../../settings_parts/settings_select.dart';
import 'settings_view.dart';

class MainSettingsView extends StatelessWidget {
    MainSettingsView({
        @required this.onCategoryPressed,
        @required this.onLanguageChanged,
    });

    final void Function(SettingsCategory) onCategoryPressed;
    final VoidCallback onLanguageChanged;

    @override
    Widget build(BuildContext context) {
        Language language = Provider.of<Language>(context);
        return SettingsView(
            items: <Widget>[
                SettingsCategoryButton(
                    title: locale.settingsComputersTitle,
                    description: locale.settingsComputersDesc,
                    onPressed: () => onCategoryPressed(SettingsCategory.COMPUTERS),
                ),
                SettingsCategoryButton(
                    title: locale.settingsExplorerTitle,
                    description: locale.settingsExplorerDesc,
                    onPressed: () => onCategoryPressed(SettingsCategory.EXPLORER),
                ),
                SettingsCategoryButton(
                    title: locale.settingsMediasTitle,
                    description: locale.settingsMediasDesc,
                    onPressed: () => onCategoryPressed(SettingsCategory.MEDIAS),
                ),
                SettingsSelect(
                    title: locale.settingsLanguageTitle,
                    description: locale.settingsLanguageDesc,
                    value: "Français",
                    selectableValues: [
                        "English",
                        "Français"
                    ],
                    onChanged: (String value) {
                        language.setLocale(Locale(value == "English" ? "en" : "fr"));
                        onLanguageChanged();
                    },
                ),
            ],
        );
    }
}