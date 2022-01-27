import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../enums/media_type.dart';
import '../../models/media/media.dart';
import '../../stores/settings/settings.dart';
import '../../utils/sizer.dart';
import '../dialogs/media_dialog.dart';
import '../others/tiny_poster.dart';

class MediaCard extends StatelessWidget {
    MediaCard({
        @required this.media,
    });

    final Media media;

    @override
    Widget build(BuildContext context) {
        Settings settings = Provider.of<Settings>(context);
        
        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Padding(
                padding: Sizer.insetsAll(10.0),
                child: Row(
                    children: <Widget>[
                        TinyPoster(
                            media: media,
                            height: Sizer.width(60.0), // Using width to preserve the aspect ratio
                        ),
                        Sizer.sizedBox(width: 5.0),
                        Expanded(
                            child: Column(
                                children: <Widget>[
                                    Observer(
                                        builder: (BuildContext context) {
                                            String title = settings.useOriginalTitle ? media.originalTitle : media.title;
                                            bool isTitleAndYearAvailable = media.known && media.type != MediaType.NONE;
                                            return Text(
                                                isTitleAndYearAvailable ? "$title (${media.year})" : media.file.unslashedName,
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: Sizer.fontSize(13.0),
                                                ),
                                            );
                                        },
                                    ),
                                    Text(
                                        media.file.unslashedName,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontSize: Sizer.fontSize(9.0),
                                        ),
                                    ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                        ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                ),
            ),
            onTap: () => showDialog(
                builder: (BuildContext context) => MediaDialog(
                    media: media,
                    showAddToPlaylistButton: false,
                ),
                context: context,
            ), 
        );
    }
}