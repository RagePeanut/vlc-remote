import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../enums/date_display.dart';
import '../../enums/media_type.dart';
import '../../models/media/media.dart';
import '../../services/tmdb.dart';
import '../../services/vlc.dart';
import '../../stores/files/files.dart';
import '../../stores/language/language.dart';
import '../../stores/settings/settings.dart';
import '../../utils/locale/app_locale.dart';
import '../../utils/regex.dart';
import '../../utils/sizer.dart';
import '../app_input.dart';
import '../others/tiny_poster.dart';

class MediaDialog extends StatefulWidget {
    MediaDialog({
        @required this.media,
        this.showAddToPlaylistButton = true,
        this.showPlayButton = true,
    });

    final Media media;
    final bool showAddToPlaylistButton, showPlayButton;

    @override
    _MediaDialogState createState() => _MediaDialogState();
}

class _MediaDialogState extends State<MediaDialog> {
    double fadeProportionalHeight = 1;
    TextEditingController idFieldController;

    @override
    void initState() {
        idFieldController = TextEditingController();
        idFieldController.text = widget.media.id;
        super.initState();
    }

    @override
    void dispose() {
        idFieldController?.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        Settings settings = Provider.of<Settings>(context);
        Language language = Provider.of<Language>(context);

        bool showButtons = widget.showAddToPlaylistButton || widget.showPlayButton;

        return SimpleDialog(
            children: <Widget>[
                Padding(
                    padding: showButtons ? Sizer.insets(15.0, 15.0, 15.0, 0.0) : Sizer.insetsAll(15.0),
                    child: Observer(
                        builder: (BuildContext context) {
                            String title = settings.useOriginalTitle ? (widget.media.originalTitle ?? widget.media.title) : widget.media.title;
                            if(widget.media.type == MediaType.EPISODE)
                                title += " (${settings.useOriginalTitle ? (widget.media.originalSeriesName ?? widget.media.seriesName) : widget.media.seriesName})";
                            
                            String releaseDate;
                            if(widget.media.type == MediaType.MOVIE || widget.media.type == MediaType.SERIES) {
                                switch(settings.releaseDateDisplay) {
                                    case DateDisplay.FULL:
                                        releaseDate = DateFormat.yMMMMd(language.short).format(DateTime.parse(widget.media.releaseDate));
                                        break;
                                    case DateDisplay.MONTH_YEAR:
                                        releaseDate = DateFormat.yMMMM(language.short).format(DateTime.parse(widget.media.releaseDate)).split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ");
                                        break;
                                    case DateDisplay.YEAR:
                                    default:
                                        releaseDate = widget.media.year;
                                        break;
                                }
                            }

                            return Column(
                                children: <Widget>[
                                    SizedBox(
                                        height: Sizer.width(120.0),
                                        child: Row(
                                            children: <Widget>[
                                                TinyPoster(
                                                    media: widget.media,
                                                    height: Sizer.width(120.0), // Using width to preserve the aspect ratio
                                                ),
                                                Sizer.sizedBox(width: 7.5),
                                                Expanded(
                                                    child: Column(
                                                        children: <Widget>[
                                                            Text(
                                                                title,
                                                                style: TextStyle(
                                                                    color: Theme.of(context).colorScheme.onSurface,
                                                                    fontSize: Sizer.fontSize(15.0),
                                                                ),
                                                            ),
                                                            if(widget.media.known && widget.media.type != MediaType.NONE)
                                                                DefaultTextStyle(
                                                                    child: Wrap(
                                                                        children: <Widget>[
                                                                            if(widget.media.type == MediaType.EPISODE) 
                                                                                Text(locale.dialogMediaSeasonEpisode(widget.media.seasonNumber, widget.media.episodeNumber))
                                                                            else
                                                                                Text(releaseDate),
                                                                            Text(
                                                                                "  •  ",
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                ),
                                                                            ),
                                                                            Observer(
                                                                                builder: (BuildContext context) => Text(
                                                                                    locale.dialogMediaRuntime(widget.media.runtime),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).colorScheme.secondaryVariant,
                                                                        fontSize: Sizer.fontSize(10.0),
                                                                    ),
                                                                ),
                                                            Sizer.sizedBox(height: 5.0),
                                                            Expanded(
                                                                child: ShaderMask(
                                                                    child: NotificationListener<ScrollUpdateNotification>(
                                                                        child: SingleChildScrollView(
                                                                            child: Text(
                                                                                widget.media.plot ?? locale.dialogMediaPlotMissing,
                                                                                style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.onSurface,
                                                                                    fontSize: Sizer.fontSize(11.0),
                                                                                ),
                                                                            ),
                                                                        ),
                                                                        onNotification: (ScrollUpdateNotification notification) {
                                                                            setState(() {
                                                                                fadeProportionalHeight = notification.metrics.extentAfter / (notification.metrics.extentBefore + notification.metrics.extentAfter);
                                                                            });
                                                                            return false;
                                                                        },
                                                                    ),
                                                                    blendMode: BlendMode.dstIn,
                                                                    shaderCallback: (Rect bounds) => LinearGradient(
                                                                        begin: Alignment.topCenter,
                                                                        end: Alignment.bottomCenter,
                                                                        colors: <Color>[
                                                                            Colors.black,
                                                                            fadeProportionalHeight == 0 ? Colors.black : Colors.transparent,
                                                                        ],
                                                                    ).createShader(Rect.fromLTRB(0, bounds.height - (bounds.height * 0.2 * fadeProportionalHeight), bounds.width, bounds.height)),
                                                                ),
                                                            ),
                                                        ],
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                    ),
                                                ),
                                            ],
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                    ),
                                    Sizer.sizedBox(height: 10.0),
                                    AppInput(
                                        hintText: locale.inputIdHint,
                                        labelText: locale.inputIdLabel,
                                        isDense: true,
                                        controller: idFieldController,
                                        onSubmitted: (String value) async {
                                            if(value.length == 0) {
                                                files.setMediaAsNonMedia(widget.media.file);
                                            } else if(value != widget.media.id) {
                                                String id = idRegex.firstMatch(value)?.group(0);
                                                if(id != null) {
                                                    // TODO: add loading spinner and call TMDb.fixMedia with that id
                                                    await TMDb.fixMedia(id, widget.media.file);
                                                    idFieldController.value = TextEditingValue(
                                                        text: widget.media.id,
                                                        selection: TextSelection.fromPosition(
                                                            TextPosition(offset: widget.media.id.length),  
                                                        ),
                                                    );
                                                }
                                            }
                                        },
                                        validator: (String value) => value.length == 0 || idRegex.hasMatch(value) ? null : locale.inputInvalidId,
                                    ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                            );
                        },
                    ),
                ),
                if(showButtons)
                    Padding(
                        padding: Sizer.insetsAll(5.0),
                        child: ButtonBar(
                            children: <IconButton>[
                                if(widget.showPlayButton)
                                    IconButton(
                                        icon: Icon(
                                            Icons.play_arrow,
                                            color: Theme.of(context).colorScheme.primary,
                                        ),
                                        iconSize: Sizer.fontSize(28.0),
                                        onPressed: () {
                                            VLC.play(widget.media.file);
                                            Navigator.of(context).pop();
                                        },
                                        padding: Sizer.insets(10.0, 5.0, 10.0, 5.0),
                                    ),
                                if(widget.showAddToPlaylistButton)
                                    IconButton(
                                        icon: Icon(
                                            Icons.playlist_add,
                                            color: Theme.of(context).colorScheme.primary,
                                        ),
                                        iconSize: Sizer.fontSize(28.0),
                                        onPressed: () {
                                            VLC.addToPlaylist(widget.media.file.uri);
                                            Navigator.of(context).pop();
                                        },
                                        padding: Sizer.insets(10.0, 5.0, 10.0, 5.0),
                                    ),
                            ],
                            buttonPadding: EdgeInsets.zero,
                        ),
                    ),
            ],
            contentPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).colorScheme.background,
        );
    }
}