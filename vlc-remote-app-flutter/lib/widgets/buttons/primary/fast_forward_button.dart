import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../primary_button.dart';

class FastForwardButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return PrimaryButton(
            icon: Icons.fast_forward,
            onTap: () => VLC.fastForward(30),
            onDoubleTap: () => VLC.fastForward(300),
            onLongPress: () => VLC.fastForward(1),
        );
    }
}