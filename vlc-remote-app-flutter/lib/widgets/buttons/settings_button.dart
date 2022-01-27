import 'package:flutter/material.dart';

import '../../utils/sizer.dart';
import 'primary_button.dart';

class SettingsButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return PrimaryButton(
            icon: Icons.settings,
            iconSize: Sizer.height(21.0),
            height: Sizer.square(45.0),
            width: Sizer.square(45.0),
            onTap: () => Navigator.of(context).pushNamed("settings"),
        );
    }
}