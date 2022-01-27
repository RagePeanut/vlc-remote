import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../enums/media_type.dart';
import '../../services/companion.dart';
import '../../services/tmdb.dart';
import '../../utils/regex.dart';
import '../file/file.dart';

part 'media.g.dart';

@JsonSerializable()
class Media extends _Media with _$Media {
    Media({
        @required File file,
        String id,
        String title,
        String originalTitle,
        String seriesName,
        String originalSeriesName,
        String releaseDate,
        String plot,
        String posterPath,
        List<int> chapters = const [],
        int globalRuntime,
        int preciseRuntime,
        int seasonNumber,
        int episodeNumber,
        MediaType type,
        bool adult = false,
        bool known = false,
        bool triedToFindMedia = false,
        bool allExtraInfoReceived = false,
    }) : super(
        file: file,
        id: id,
        title: title,
        originalTitle: originalTitle,
        seriesName: seriesName,
        originalSeriesName: originalSeriesName,
        releaseDate: releaseDate,
        plot: plot,
        posterPath: posterPath,
        chapters: chapters,
        globalRuntime: globalRuntime,
        preciseRuntime: preciseRuntime,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
        type: type,
        adult: adult,
        known: known,
        triedToFindMedia: triedToFindMedia,
        allExtraInfoReceived: allExtraInfoReceived,
    );

    factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

    Map<String, dynamic> toJson() => _$MediaToJson(this);
}

abstract class _Media with Store {
    final File file;
    bool triedToFindMedia, allExtraInfoReceived;
    MediaType type;

    @observable
    bool known, adult;

    @observable
    String id, title, originalTitle, seriesName, originalSeriesName, releaseDate, posterPath, plot;

    @observable
    int globalRuntime, preciseRuntime, episodeNumber, seasonNumber;

    @observable
    List chapters;

    @computed
    String get year => releaseDate?.substring(0, 4);

    @computed
    String get poster => TMDb.getPosterUrl(posterPath);

    @computed
    int get runtime => preciseRuntime ?? globalRuntime;

    _Media({
        this.file,
        this.id,
        String title,
        this.originalTitle,
        this.seriesName,
        this.originalSeriesName,
        this.releaseDate,
        this.plot,
        this.posterPath,
        this.chapters,
        this.globalRuntime,
        this.preciseRuntime,
        this.seasonNumber,
        this.episodeNumber,
        this.type,
        this.adult,
        this.known,
        this.triedToFindMedia,
        this.allExtraInfoReceived,
    }) : this.title = title ?? file.unslashedName.replaceAll(extensionRegex, "") {
        if(!triedToFindMedia) {
            _findMedia();
        }
        if(!allExtraInfoReceived) {
            Companion.extraInfo(this);
        }
    }

    @action
    void addExtraInfo(Map<String, dynamic> data) {
        this.chapters = data["chapters"] ?? this.chapters;
        this.preciseRuntime = data["duration"] ?? this.preciseRuntime;
        this.allExtraInfoReceived = this.chapters != null && this.runtime != null;
    }

    @action
    void update(Map<String, dynamic> data) {
        this.id = data["id"].toString();
        this.title = data["title"] ?? data["name"];
        this.originalTitle = data["original_title"] ?? data["original_name"];
        this.seriesName = data["series_name"];
        this.originalSeriesName = data["original_series_name"];
        this.releaseDate = data["release_date"] ?? data["air_date"] ?? data["first_air_date"];
        this.globalRuntime = globalRuntime ?? data["runtime"];
        this.plot = data["overview"];
        this.posterPath = data["poster_path"];
        this.seasonNumber = data["season_number"];
        this.episodeNumber = data["episode_number"];
        this.type = data["media_type"] == "movie" ? MediaType.MOVIE : (data["media_type"] == "episode" ? MediaType.EPISODE : MediaType.SERIES);
        this.adult = data["adult"] ?? false;
        this.known = true;
    }

    @action
    void setAsNonMedia() {
        this.id = null;
        this.title = file.unslashedName.replaceAll(extensionRegex, "");
        this.originalTitle = null;
        this.seriesName = null;
        this.originalSeriesName = null;
        this.releaseDate = null;
        this.globalRuntime = null;
        this.plot = null;
        this.posterPath = null;
        this.seasonNumber = null;
        this.episodeNumber = null;
        this.type = MediaType.NONE;
        this.adult = false;
        this.known = true;
    }

    Future<void> _findMedia() async {
        await TMDb.findMedia(file);
        this.triedToFindMedia = true;
    }
}