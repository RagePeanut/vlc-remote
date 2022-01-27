import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class DonateButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SecondaryButton(
            icon: FlutterIcons.donate_faw5s,
            label: locale.buttonDonate,
            onTap: () {
                // TODO: show donate dialog
            }
        );
    }
}