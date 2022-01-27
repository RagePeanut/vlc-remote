import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../services/vlc.dart';
import '../../stores/files/files.dart';
import '../../utils/locale/app_locale.dart';
import '../../utils/sizer.dart';
import '../cards/dismissible/dismissible_media_card.dart';
import 'app_bottom_sheet.dart';

class PlaylistBottomSheet extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        return AppBottomSheet(
            content: Expanded(
                child: Observer(
                    builder: (BuildContext context) => ListView.separated(
                        itemCount: files.playlist.length,
                        itemBuilder: (BuildContext context, int index) => Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: DismissibleMediaCard(
                                media: files.playlistAsMedias[index],
                                onDismissed: () => VLC.delete(files.playlist[index].id),
                            ),
                        ),
                        separatorBuilder: (BuildContext context, int _) => Sizer.sizedBox(height: 0.0),
                    ),
                ),
            ),
            title: locale.sheetPlaylist,
            heightFactor: 0.7,
            horizontalPadding: 0.0,
        );
    }
}