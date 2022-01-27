import 'package:flutter/material.dart';

import '../others/settings_summary.dart';

class SettingsSelect extends StatelessWidget {

    SettingsSelect({
        @required this.description,
        @required this.onChanged,
        @required this.value,
        @required this.selectableValues,
        @required this.title,
    });

    final String title, description, value;
    final List<String> selectableValues;
    final void Function(String) onChanged;

    @override
    Widget build(BuildContext context) {
        return Row(
            children: <Widget>[
                SettingsSummary(
                    title: title,
                    description: description,
                ),
                DropdownButton<String>(
                    onChanged: onChanged,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: selectableValues.map((String value) =>
                        DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                        ),
                    ).toList(),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground
                    ),
                    value: value,
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
    }

}