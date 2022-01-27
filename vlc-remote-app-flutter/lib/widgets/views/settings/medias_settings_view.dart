import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../enums/date_display.dart';
import '../../../enums/time_indicator_type.dart';
import '../../../stores/language/language.dart';
import '../../../stores/settings/settings.dart';
import '../../../utils/locale/app_locale.dart';
import '../../settings_parts/settings_select.dart';
import '../../settings_parts/settings_switch.dart';
import 'settings_view.dart';

class MediasSettingsView extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Settings settings = Provider.of<Settings>(context);
        Language language = Provider.of<Language>(context);

        return SettingsView(
            items: <Widget>[
                Observer(
                    builder: (BuildContext context) => SettingsSwitch(
                        title: locale.settingsMediasShowAdultPostersTitle,
                        description: locale.settingsMediasShowAdultPostersDesc,
                        value: settings.showAdultPosters,
                        onChanged: settings.setShowAdultPosters,
                    ),
                ),
                Observer(
                    builder: (BuildContext context) => SettingsSwitch(
                        title: locale.settingsMediasUseOriginalTitleTitle,
                        description: locale.settingsMediasUseOriginalTitleDesc,
                        value: settings.useOriginalTitle,
                        onChanged: settings.setUseOriginalTitle,
                    ),
                ),
                Observer(
                    builder: (BuildContext context) => SettingsSelect(
                        title: locale.settingsMediasRightTimeIndicatorTitle,
                        description: locale.settingsMediasRightTimeIndicatorDesc,
                        value: settings.rightTimeIndicatorUsed == TimeIndicatorType.REMAINING
                                    ? locale.settingsMediasRightTimeIndicatorOptionTimeRemaining
                                    : locale.settingsMediasRightTimeIndicatorOptionRuntime,
                        selectableValues: [
                            locale.settingsMediasRightTimeIndicatorOptionTimeRemaining,
                            locale.settingsMediasRightTimeIndicatorOptionRuntime,
                        ],
                        onChanged: (String selected) {
                            TimeIndicatorType indicator = selected == locale.settingsMediasRightTimeIndicatorOptionTimeRemaining
                                ? TimeIndicatorType.REMAINING
                                : TimeIndicatorType.RUNTIME;
                            settings.setRightTimeIndicatorUsed(indicator);
                        },
                    ),
                ),
                Observer(
                    builder: (BuildContext context){
                        DateTime now = DateTime.now();

                        String year = now.year.toString();
                        String monthYear = DateFormat.yMMMM(language.short).format(now).split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ");
                        String full = DateFormat.yMMMMd(language.short).format(now);
                        
                        return SettingsSelect(
                            title: locale.settingsMediasReleaseDateTitle,
                            description: locale.settingsMediasReleaseDateDesc,
                            value: settings.releaseDateDisplay == DateDisplay.YEAR
                                        ? year
                                        : settings.releaseDateDisplay == DateDisplay.MONTH_YEAR
                                            ? monthYear
                                            : full,
                            selectableValues: [
                                year,
                                monthYear,
                                full,
                            ],
                            onChanged: (String selected) {
                                DateDisplay dateDisplay = selected == year
                                    ? DateDisplay.YEAR
                                    : selected == monthYear
                                        ? DateDisplay.MONTH_YEAR
                                        : DateDisplay.FULL;
                                settings.setReleaseDateDisplay(dateDisplay);
                            },
                        );
                    },
                ),
            ],
        );
    }
}