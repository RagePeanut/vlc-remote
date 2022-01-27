import 'package:flutter/material.dart';

import '../../../utils/locale/app_locale.dart';
import '../bottom_button.dart';

class PlayerButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return BottomButton(
            icon: Icons.play_circle_filled,
            label: locale.buttonPlayer,
            isLeftButton: true,
            onTap: () {
                Navigator.of(context).pushReplacementNamed("remote");
            }
        );
    }
}