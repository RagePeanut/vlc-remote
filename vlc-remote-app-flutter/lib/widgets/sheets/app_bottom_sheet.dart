import 'package:flutter/material.dart';

import '../../utils/sizer.dart';

class AppBottomSheet extends StatelessWidget {
    AppBottomSheet({
        @required this.content,
        this.topPadding = 15.0,
        this.bottomPadding = 15.0,
        this.horizontalPadding = 15.0,
        this.heightFactor,
        this.title,
    });

    final Widget content;
    final double bottomPadding, horizontalPadding, topPadding, heightFactor;
    final String title;

    @override
    Widget build(BuildContext context) {
        Widget sheet = Padding(
            padding: Sizer.insets(horizontalPadding, topPadding, horizontalPadding, bottomPadding),
            child: Column(
                children: <Widget>[
                    Container(
                        height: Sizer.height(2.0),
                        width: Sizer.width(20.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        ),
                    ),
                    if(title != null) Sizer.sizedBox(height: 10.0),
                    if(title != null) Text(
                        title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: Sizer.fontSize(14.0), 
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    Sizer.sizedBox(height: 10.0),
                    content,
                ],
            ),
        );

        return heightFactor != null ? FractionallySizedBox(
            heightFactor: heightFactor,
            child: sheet,
        ) : sheet;
    }
}