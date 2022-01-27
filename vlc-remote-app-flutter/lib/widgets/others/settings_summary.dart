import 'package:flutter/material.dart';

import '../../utils/sizer.dart';

class SettingsSummary extends StatelessWidget {

    SettingsSummary({
        @required this.title,
        @required this.description,
        this.padding = EdgeInsets.zero,
    });

    final String title, description;
    final EdgeInsets padding;

    @override
    Widget build(BuildContext context) {
        return Flexible(
            child: Padding(
                child: Column(
                    children: <Widget>[
                        Text(
                            title,
                            style: Sizer.textTheme.headline6.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                            ),
                        ),
                        Sizer.sizedBox(height: 2.0),
                        Text(
                            description,
                            style: Sizer.textTheme.overline.copyWith(
                                color: Theme.of(context).colorScheme.secondaryVariant,
                            ),
                        ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                ),
                padding: padding,
            ),
        );
    }

}