import 'package:flutter/material.dart';

import '../../utils/locale/app_locale.dart';
import '../../utils/sizer.dart';

class AppDialog extends StatelessWidget {
    AppDialog({
        String cancelLabel,
        List<String> confirmLabels,
        @required this.content,
        @required this.onConfirmPressed,
        @required this.title,
    }) : this.cancelLabel = cancelLabel ?? locale.buttonCancel,
         this.confirmLabels = confirmLabels ?? [ locale.buttonConfirm ];

    final String cancelLabel, title;
    final List<String> confirmLabels;
    final Widget content;
    final Function(String) onConfirmPressed;

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            actions: <Widget>[
                FlatButton(
                    child: Text(cancelLabel),
                    onPressed: Navigator.of(context).pop,
                ),
                for(String confirmLabel in confirmLabels)
                    FlatButton(
                        child: Text(
                            confirmLabel,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                            ),
                        ),
                        onPressed: () {
                            // Handles both bool and void returning functions
                            if(onConfirmPressed(confirmLabel) != false) Navigator.of(context).pop();
                        }
                    ),
            ],
            backgroundColor: Theme.of(context).colorScheme.background,
            content: content,
            contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(title),
            titleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Sizer.fontSize(18.0),
            ),
        );
    }
}