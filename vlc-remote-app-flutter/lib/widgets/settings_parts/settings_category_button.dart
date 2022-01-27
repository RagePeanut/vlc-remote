import 'package:flutter/material.dart';

import '../others/settings_summary.dart';

class SettingsCategoryButton extends StatelessWidget {
    SettingsCategoryButton({
        Key key,
        @required this.description,
        @required this.title,
        @required this.onPressed,
    }) : super(key: key);

    final String description;
    final String title;
    final void Function() onPressed;

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            child: Container(
                child: Row(
                    children: <Widget>[
                        SettingsSummary(
                            title: title,
                            description: description,
                        ),
                        Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.onBackground,
                        ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                color: Theme.of(context).colorScheme.background,
            ),
            onTap: onPressed,
        );
    }
}