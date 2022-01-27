import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../models/media/media.dart';
import '../../utils/regex.dart';
import '../settings/settings.dart';

part 'status.g.dart';

/// The status of the remote.
class Status = _Status with _$Status;

abstract class _Status with Store {
    /// Constructs an instance of [Status].
    _Status({
        @required this.settings,
    });

    final Settings settings;

    @observable
    String title, year;
    @observable
    bool isFullscreen, isOn, isPaused, loop, repeat;
    @observable
    int time, length, chapter, chapterCount;
    @observable
    double progress;

    /// Updates the status of the remote.
    @action
    void update(Map<String, dynamic> data, List<Media> playlist) {
        if(data["state"] == "stopped") {
            isFullscreen = false;
            isPaused = true;
            length = 0;
            chapter = 0;
            chapterCount = 1;
            title = "";
            year = null;
        } else {
            // This test is required because the fullscreen param is not instantly initialized when the state goes from "stopped" to "playing" or "paused"
            isFullscreen = data["fullscreen"].runtimeType == bool ? data["fullscreen"] : false;
            isPaused = data["state"] == "paused";
            length = max(data["length"], 0);
            chapter = data["information"]["chapter"];
            chapterCount = data["information"]["chapters"].length;
            Media currentlyPlaying = playlist.firstWhere((Media media) => media.file.name == data["information"]["category"]["meta"]["filename"], orElse: () => null);
            title = settings.useOriginalTitle ? currentlyPlaying?.originalTitle : currentlyPlaying?.title
                        ?? (data["information"]["title"].runtimeType == String
                                ? data["information"]["title"]
                                : importantNamePartRegex.firstMatch(data["information"]["category"]["meta"]["filename"])
                                                        .group(1)
                                                        .replaceAll(nonWordRegex, " "));
                                                        // TODO: find a way to not use importantNamePartRegex so that this regex can be removed from the project
            year = currentlyPlaying?.year;
        }
        isOn = true;
        loop = data["loop"];
        repeat = data["repeat"];
        time = max(data["time"], 0);
        progress = data["position"].toDouble() * length;
    }

    @action
    void setOff() {
        isOn = false;
        isFullscreen = false;
        isPaused = true;
        length = 0;
        chapter = 0;
        chapterCount = 1;
        title = "";
        year = null;
        loop = false;
        repeat = false;
        time = 0;
        progress = 0;
    }

    @action
    void switchPower(bool wasOn) {
        if(wasOn) setOff();
        else isOn = true;
    }
}