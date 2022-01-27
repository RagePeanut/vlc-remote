import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../services/vlc.dart';
import '../../../stores/status/status.dart';
import '../primary_button.dart';

class PlayPauseButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Status status = Provider.of<Status>(context);
        return Observer(
            builder: (BuildContext context) => PrimaryButton(
                icon: (status.isPaused ?? true) ? Icons.play_arrow : Icons.pause,
                isCenterButton: true,
                onTap: VLC.togglePause,
            ),
        );
    }
}
