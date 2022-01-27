import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../others/settings_summary.dart';

class SettingsSwitch extends StatelessWidget {

    SettingsSwitch({
        @required this.description,
        @required this.onChanged,
        @required this.value,
        @required this.title,
    });

    final String title, description;
    final bool value;
    final void Function(bool) onChanged;

    @override
    Widget build(BuildContext context) {
        return Row(
            children: <Widget>[
                SettingsSummary(
                    title: title,
                    description: description,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).buttonTheme.colorScheme.primary,
                    inactiveThumbColor: Theme.of(context).buttonTheme.colorScheme.secondary,
                    inactiveTrackColor: Theme.of(context).buttonTheme.colorScheme.secondaryVariant,
                    onChanged: onChanged,
                    value: value,
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
    }

}