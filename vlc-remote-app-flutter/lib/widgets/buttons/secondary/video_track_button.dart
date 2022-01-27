import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class VideoTrackButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SecondaryButton(
            icon: Icons.video_label,
            label: locale.buttonVideoTrack,
            onTap: VLC.switchVideoTrack,
        );
    }
}