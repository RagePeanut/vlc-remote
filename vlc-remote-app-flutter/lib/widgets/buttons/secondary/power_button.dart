import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../services/companion.dart';
import '../../../stores/status/status.dart';
import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class PowerButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Status status = Provider.of<Status>(context);
        return Observer(
            builder: (BuildContext context) => SecondaryButton(
                icon: Icons.power_settings_new,
                label: locale.buttonPower(status.isOn ?? false),
                onTap: Companion.power,
            ),
        );
    }
}