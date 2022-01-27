import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../../../utils/locale/app_locale.dart';
import '../secondary_button.dart';

class AudioTrackButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SecondaryButton(
            icon: Icons.audiotrack,
            label: locale.buttonAudioTrack,
            onTap: VLC.switchAudioTrack,
        );
    }
}