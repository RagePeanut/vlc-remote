import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../primary_button.dart';

class NextChapterButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return PrimaryButton(
            icon: Icons.arrow_right,
            onTap: () => VLC.nextChapter(),
        );
    }
}