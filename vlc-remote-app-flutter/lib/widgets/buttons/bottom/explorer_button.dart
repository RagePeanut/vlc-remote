import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../utils/locale/app_locale.dart';
import '../../sheets/explorer_bottom_sheet.dart';
import '../bottom_button.dart';

class ExplorerButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return BottomButton(
            icon: FlutterIcons.compass_faw5s,
            label: locale.buttonExplorer,
            isLeftButton: true,
            onTap: () => showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.background,
                builder: (BuildContext context) => ExplorerBottomSheet(),
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                    ),
                ),
            ),
        );
    }
}