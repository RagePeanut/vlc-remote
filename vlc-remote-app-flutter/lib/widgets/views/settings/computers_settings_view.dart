import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../models/computer/computer.dart';
import '../../../stores/files/files.dart';
import '../../../utils/locale/app_locale.dart';
import '../../../utils/sizer.dart';
import '../../cards/dismissible/dismissible_computer_card.dart';
import '../../sheets/computer_bottom_sheet.dart';
import 'settings_view.dart';

class ComputersSettingsView extends StatelessWidget {
    ComputersSettingsView({
        @required this.getScaffoldKey,
    });

    final GlobalKey<ScaffoldState> Function() getScaffoldKey;
    BuildContext _context;

    @override
    Widget build(BuildContext context) {
        _context = context;
        Files files = Provider.of<Files>(context);
        return Scaffold(
            body: Observer(
                builder: (BuildContext context) => files.computers.length > 0
                    ? SettingsView(
                        addPadding: false,
                        items: files.computers.map((Computer computer) => DismissibleComputerCard(
                            computer: computer,
                            onDismissed: () => files.removeComputer(computer),
                            onLongPress: () => showComputerSheet(computer),
                        )).toList(),
                    )
                    : Container(
                        alignment: Alignment.center,
                        color: Theme.of(context).colorScheme.background,
                        child: Text(
                            locale.otherNoComputer,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                            ),
                        ),
                    ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: Sizer.height(20.0),
                ),
                onPressed: showComputerSheet,
            ),
        );
    }

    void showComputerSheet([ Computer computer, bool isScanned ]) {
        showModalBottomSheet(
            context: _context,
            backgroundColor: Theme.of(_context).colorScheme.background,
            builder: (BuildContext context) => Wrap(
                children: <Widget>[
                    ComputerBottomSheet(
                        computer: computer,
                        isScanned: isScanned,
                    ),
                ],
            ),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                ),
            ),
        );
    }
}