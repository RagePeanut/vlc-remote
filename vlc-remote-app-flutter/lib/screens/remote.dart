import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:volume_watcher/volume_watcher.dart';

import '../services/vlc.dart';
import '../stores/files/files.dart';
import '../stores/status/status.dart';
import '../utils/sizer.dart';
import '../widgets/buttons/bottom/explorer_button.dart';
import '../widgets/buttons/bottom/playlist_button.dart';
import '../widgets/buttons/primary/fast_forward_button.dart';
import '../widgets/buttons/primary/fast_rewind_button.dart';
import '../widgets/buttons/primary/next_chapter_button.dart';
import '../widgets/buttons/primary/play_pause_button.dart';
import '../widgets/buttons/primary/previous_chapter_button.dart';
import '../widgets/buttons/secondary/audio_track_button.dart';
import '../widgets/buttons/secondary/donate_button.dart';
import '../widgets/buttons/secondary/fullscreen_button.dart';
import '../widgets/buttons/secondary/power_button.dart';
import '../widgets/buttons/secondary/screen_button.dart';
import '../widgets/buttons/secondary/subtitle_track_button.dart';
import '../widgets/buttons/secondary/video_track_button.dart';
import '../widgets/buttons/settings_button.dart';
import '../widgets/others/poster_carousel.dart';
import '../widgets/others/progress_bar.dart';

class Remote extends StatelessWidget {
    Remote({
        @required this.maxVolume,
    });

    final num maxVolume;

    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        Status status = Provider.of<Status>(context);

        return Stack(
            children: <Widget>[
                Column(
                    children: <Widget>[
                        VolumeWatcher(
                            onVolumeChangeListener: (num volume) {
                                int vlcVolume = ((VLC.MAX_VOLUME / maxVolume) * volume).toInt();
                                VLC.volume(vlcVolume);
                            },
                        ),
                        Expanded(
                            child: Observer(
                                builder: (BuildContext _) => PosterCarousel(
                                    initialIndex: files.currentlyPlayingIndex,
                                    medias: files.playlistAsMedias,
                                    onPosterChanged: (int index) {
                                        VLC.play(files.playlist[index]);
                                    }
                                ),
                            ),
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(child: PowerButton()),
                                Expanded(child: ScreenButton()),
                                Expanded(child: DonateButton()),
                                Expanded(child: SizedBox()),
                            ],
                            mainAxisSize: MainAxisSize.max,
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(child: VideoTrackButton()),
                                Expanded(child: AudioTrackButton()),
                                Expanded(child: SubtitleTrackButton()),
                                Expanded(child: FullscreenButton()),
                            ],
                            mainAxisSize: MainAxisSize.max,
                        ),
                        Sizer.sizedBox(height: 10.0),
                        ProgressBar(),
                        Sizer.sizedBox(height: 5.0),
                        Observer(
                            builder: (BuildContext context) => Text(
                                (status.title ?? "") + (status.year != null ? " (${status.year})" : ""),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                ),
                            ),
                        ),
                        Sizer.sizedBox(height: 7.5),
                        Row(
                            children: <Widget>[
                                PreviousChapterButton(),
                                FastRewindButton(),
                                PlayPauseButton(),
                                FastForwardButton(),
                                NextChapterButton(),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Sizer.sizedBox(
                            height: 30.0,
                            width: double.infinity,
                            child: ButtonBar(
                                buttonPadding: EdgeInsets.zero,
                                children: <Widget>[
                                    ExplorerButton(),
                                    PlaylistButton(),
                                ],
                            ),
                        ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                ),
                Positioned(
                    child: SettingsButton(),
                    top: 0,
                    right: 0,
                ),
            ],
        );
    }
}