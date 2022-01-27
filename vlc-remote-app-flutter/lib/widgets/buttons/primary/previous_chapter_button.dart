import 'package:flutter/material.dart';

import '../../../services/vlc.dart';
import '../primary_button.dart';

class PreviousChapterButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return PrimaryButton(
            icon: Icons.arrow_left,
            onTap: () => VLC.previousChapter(),
        );
    }
}