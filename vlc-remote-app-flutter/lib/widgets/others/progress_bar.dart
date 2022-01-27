import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../enums/time_indicator_type.dart';
import '../../services/vlc.dart';
import '../../stores/files/files.dart';
import '../../stores/settings/settings.dart';
import '../../stores/status/status.dart';
import '../../utils/sizer.dart';
import '../others/time_indicator.dart';

class ProgressBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        Status status = Provider.of<Status>(context);
        Settings settings = Provider.of<Settings>(context);

        return Padding(
            padding: Sizer.insetsHorizontal(15.0),
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            Observer(
                                builder: (BuildContext context) => TimeIndicator(
                                    time: status.time ?? 0,
                                ),
                            ),
                            Observer(
                                builder: (BuildContext context) => TimeIndicator(
                                    time: settings.rightTimeIndicatorUsed == TimeIndicatorType.REMAINING
                                            ? (status.length ?? 0) - (status.time ?? 0)
                                            : status.length ?? 0,
                                ),
                            ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Sizer.sizedBox(
                        height: 10.0,
                        width: double.infinity,
                        child: SliderTheme(
                            child: Observer(
                                builder: (BuildContext context) {
                                    List chapters = files.currentlyPlayingIndex != null ? files.playlistAsMedias[files.currentlyPlayingIndex].chapters : [];
                                    return Stack(
                                        children: <Widget>[
                                            Slider(
                                                value: status.progress ?? 0.0,
                                                min: 0.0,
                                                max: status.length?.toDouble() ?? 0.0,
                                                onChanged: (double value) => VLC.seek(value.toInt()),
                                            ),
                                            ...chapters.where((chapter) => chapter > 0 && chapter < status.length).map((chapter) => Align(
                                                alignment: Alignment((chapter / status.length) * 2 - 1, 0.0),
                                                child: Container(
                                                    height: Sizer.height(3.0),
                                                    width: Sizer.width(2.0),
                                                    color: chapter >= status.progress ? Theme.of(context).colorScheme.primary
                                                                                      : Theme.of(context).colorScheme.onPrimary,
                                                ),
                                            )),
                                        ],
                                    );
                                },
                            ),
                            data: SliderThemeData(
                                activeTrackColor: Theme.of(context).colorScheme.primary,
                                inactiveTrackColor: Theme.of(context).colorScheme.onBackground,
                                thumbColor: Theme.of(context).colorScheme.primary,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: Sizer.height(5.0),
                                ),
                                trackHeight: Sizer.height(3.0),
                                trackShape: _SliderTrackShape(),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}

class _SliderTrackShape extends RoundedRectSliderTrackShape {
    @override
    Rect getPreferredRect({
        bool isDiscrete = false,
        bool isEnabled = false,
        Offset offset = Offset.zero,
        @required RenderBox parentBox,
        @required SliderThemeData sliderTheme,
    }) {
        final double trackHeight = sliderTheme.trackHeight;
        final double trackLeft = offset.dx;
        final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
        final double trackWidth = parentBox.size.width;
        return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
    }
}