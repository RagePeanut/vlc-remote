import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../services/vlc.dart';
import '../../../stores/status/status.dart';
import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class FullscreenButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Status status = Provider.of<Status>(context);
        return Observer(
            builder: (BuildContext context) => SecondaryButton(
                icon: (status.isFullscreen ?? false) ? Icons.fullscreen_exit : Icons.fullscreen,
                label: locale.buttonFullscreen(status.isFullscreen ?? false),
                onTap: () => VLC.fullscreen(),
            ),
        );
    }
}