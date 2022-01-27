import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../services/companion.dart';
import '../../../stores/files/files.dart';
import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class ScreenButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        return Observer(
            builder: (BuildContext context) => SecondaryButton(
                icon: Icons.input,
                label: locale.buttonScreen(files.screenNumber),
                onTap: Companion.switchScreen,
            ),
        );
    }
}