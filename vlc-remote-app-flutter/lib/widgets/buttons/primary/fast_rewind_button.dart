import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../primary_button.dart';

class FastRewindButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return PrimaryButton(
            icon: Icons.fast_rewind,
            onTap: () => VLC.fastRewind(30),
            onDoubleTap: () => VLC.fastRewind(300),
            onLongPress: () => VLC.fastRewind(1),
        );
    }
}