import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/computer/computer.dart';
import '../../stores/files/files.dart';
import '../../utils/locale/app_locale.dart';
import 'app_dialog.dart';

class ConnectionDialog extends StatelessWidget {
    ConnectionDialog({
        @required this.computer,
    });

    final Computer computer;

    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        return AppDialog(
            content: Text(files.currentComputer != null
                ? locale.dialogConnectionCurrentlyConnected(files.currentComputer.name)
                : locale.dialogConnectionNotConnected,
            ),
            onConfirmPressed: (label) => files.connectToComputer(computer),
            title: locale.dialogConnectionTitle(computer.name),
        );
    }
}