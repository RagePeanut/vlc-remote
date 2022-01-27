import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../utils/sizer.dart';

class DismissibleCard extends StatelessWidget {
    DismissibleCard({
        @required this.card,
        @required this.onDismissed,
    });

    final Widget card;
    final VoidCallback onDismissed;

    @override
    Widget build(BuildContext context) {
        List<Widget> rowContent = [
            Sizer.sizedBox(width: 10.0),
            Icon(
                FlutterIcons.trash_faw5s,
                color: Theme.of(context).colorScheme.onError,
                size: Sizer.height(10.0),
            ),
            Sizer.sizedBox(width: 3.0),
            Text(
                "REMOVE",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: Sizer.fontSize(10.0),
                ),
            ),
        ];

        return Dismissible(
            key: UniqueKey(),
            child: card,
            background: Container(
                color: Theme.of(context).colorScheme.error,
                child: Row(
                    children: rowContent,
                ),
            ),
            secondaryBackground: Container(
                color: Theme.of(context).colorScheme.error,
                child: Row(
                    children: rowContent.reversed.toList(),
                    mainAxisAlignment: MainAxisAlignment.end,
                ),
            ),
            onDismissed: (DismissDirection _) => onDismissed(),
        );
    }
}