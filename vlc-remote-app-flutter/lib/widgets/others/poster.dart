import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../models/media/media.dart';
import '../../stores/settings/settings.dart';
import '../../utils/locale/app_locale.dart';
import '../../utils/sizer.dart';
import '../dialogs/media_dialog.dart';

class Poster extends StatelessWidget {
    Poster({
        @required this.media,
    });

    final Media media;

    @override
    Widget build (BuildContext context) {
        Settings settings = Provider.of<Settings>(context);

        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
                alignment: Alignment.center,
                height: Sizer.square(275.0),
                child: media != null
                    ? Observer(
                        builder: (BuildContext context) {
                            bool isImageAvailable = media.posterPath != null;
                            bool canShowPoster = settings.showAdultPosters || !media.adult;
                            if(canShowPoster && isImageAvailable) {
                                return Image.network(
                                    media.poster,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent event) {
                                        if(event == null) return child;
                                        return Center(
                                            child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                                                strokeWidth: Sizer.width(2.0),
                                                value: event.cumulativeBytesLoaded / event.expectedTotalBytes,
                                            ),
                                        );
                                    },
                                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                        // TODO: upgrade flutter when this bug is fixed https://github.com/flutter/flutter/issues/56454
                                        // Temporary workaround for error being thrown when the image starts loading out of the screen
                                        return Image.network(media.poster);
                                    },
                                );
                            }
                            return Text(
                                locale.otherNoPoster,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: Sizer.fontSize(16.0),
                                ),
                            );
                        }
                    )
                    : SizedBox(),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                ),
            ),
            onTap: () => showDialog(
                builder: (BuildContext context) => MediaDialog(
                    media: media,
                    showAddToPlaylistButton: false,
                    showPlayButton: false,
                ),
                context: context,
            ),
        );
    }
}