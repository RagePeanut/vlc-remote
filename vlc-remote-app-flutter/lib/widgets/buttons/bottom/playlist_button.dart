import 'package:flutter/material.dart';

import '../../../utils/locale/app_locale.dart';
import '../../../utils/sizer.dart';
import '../../sheets/playlist_bottom_sheet.dart';
import '../bottom_button.dart';

class PlaylistButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return BottomButton(
            icon: Icons.playlist_play,
            label: locale.buttonPlaylist,
            isLeftButton: false,
            iconSize: Sizer.height(18.0),
            innerSeparation: 0.0,
            onTap: () => showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.background,
                builder: (BuildContext context) => PlaylistBottomSheet(),
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                    ),
                ),
            ),
        );
    }
}