import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../models/media/media.dart';
import '../../services/tmdb.dart';
import '../../stores/settings/settings.dart';
import '../../utils/sizer.dart';

class TinyPoster extends StatelessWidget {
    const TinyPoster({
        @required this.media,
        @required this.height,
        double width,
    }) : this.width = width ?? height / 3 * 2;

    final double height, width;
    final Media media;

    @override
    Widget build(BuildContext context) {
        Settings settings = Provider.of<Settings>(context);

        return Container(
            height: height,
            width: width,
            child: Observer(
                builder: (BuildContext context) {
                    bool isImageAvailable = media.posterPath != null;
                    bool canShowPoster = settings.showAdultPosters || !media.adult;
                    if(canShowPoster && isImageAvailable) {
                        String posterUrl = TMDb.getPosterUrl(media.posterPath, width);
                        return Image.network(
                            posterUrl,
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
                                return Image.network(posterUrl);
                            },
                        );
                    }
                    return Container(
                        child: Icon(
                            FlutterIcons.image_off_mco,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: width / 3,
                        ),
                        alignment: Alignment.center,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                    );
                },
            ),
            alignment: Alignment.topLeft,
        );
    }
}