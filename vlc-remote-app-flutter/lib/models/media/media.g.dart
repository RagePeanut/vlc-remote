// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media(
    file: json['file'] == null
        ? null
        : File.fromJson(json['file'] as Map<String, dynamic>),
    id: json['id'] as String,
    title: json['title'] as String,
    originalTitle: json['originalTitle'] as String,
    seriesName: json['seriesName'] as String,
    originalSeriesName: json['originalSeriesName'] as String,
    releaseDate: json['releaseDate'] as String,
    plot: json['plot'] as String,
    posterPath: json['posterPath'] as String,
    chapters: (json['chapters'] as List)?.map((e) => e as int)?.toList(),
    globalRuntime: json['globalRuntime'] as int,
    preciseRuntime: json['preciseRuntime'] as int,
    seasonNumber: json['seasonNumber'] as int,
    episodeNumber: json['episodeNumber'] as int,
    type: _$enumDecodeNullable(_$MediaTypeEnumMap, json['type']),
    adult: json['adult'] as bool,
    known: json['known'] as bool,
    triedToFindMedia: json['triedToFindMedia'] as bool,
    allExtraInfoReceived: json['allExtraInfoReceived'] as bool,
  );
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'file': instance.file,
      'triedToFindMedia': instance.triedToFindMedia,
      'allExtraInfoReceived': instance.allExtraInfoReceived,
      'type': _$MediaTypeEnumMap[instance.type],
      'known': instance.known,
      'adult': instance.adult,
      'id': instance.id,
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'seriesName': instance.seriesName,
      'originalSeriesName': instance.originalSeriesName,
      'releaseDate': instance.releaseDate,
      'posterPath': instance.posterPath,
      'plot': instance.plot,
      'globalRuntime': instance.globalRuntime,
      'preciseRuntime': instance.preciseRuntime,
      'episodeNumber': instance.episodeNumber,
      'seasonNumber': instance.seasonNumber,
      'chapters': instance.chapters,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MediaTypeEnumMap = {
  MediaType.UNKNOWN: 'UNKNOWN',
  MediaType.EPISODE: 'EPISODE',
  MediaType.MOVIE: 'MOVIE',
  MediaType.SERIES: 'SERIES',
  MediaType.NONE: 'NONE',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Media on _Media, Store {
  Computed<String> _$yearComputed;

  @override
  String get year => (_$yearComputed ??=
          Computed<String>(() => super.year, name: '_Media.year'))
      .value;
  Computed<String> _$posterComputed;

  @override
  String get poster => (_$posterComputed ??=
          Computed<String>(() => super.poster, name: '_Media.poster'))
      .value;
  Computed<int> _$runtimeComputed;

  @override
  int get runtime => (_$runtimeComputed ??=
          Computed<int>(() => super.runtime, name: '_Media.runtime'))
      .value;

  final _$knownAtom = Atom(name: '_Media.known');

  @override
  bool get known {
    _$knownAtom.reportRead();
    return super.known;
  }

  @override
  set known(bool value) {
    _$knownAtom.reportWrite(value, super.known, () {
      super.known = value;
    });
  }

  final _$adultAtom = Atom(name: '_Media.adult');

  @override
  bool get adult {
    _$adultAtom.reportRead();
    return super.adult;
  }

  @override
  set adult(bool value) {
    _$adultAtom.reportWrite(value, super.adult, () {
      super.adult = value;
    });
  }

  final _$idAtom = Atom(name: '_Media.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$titleAtom = Atom(name: '_Media.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$originalTitleAtom = Atom(name: '_Media.originalTitle');

  @override
  String get originalTitle {
    _$originalTitleAtom.reportRead();
    return super.originalTitle;
  }

  @override
  set originalTitle(String value) {
    _$originalTitleAtom.reportWrite(value, super.originalTitle, () {
      super.originalTitle = value;
    });
  }

  final _$seriesNameAtom = Atom(name: '_Media.seriesName');

  @override
  String get seriesName {
    _$seriesNameAtom.reportRead();
    return super.seriesName;
  }

  @override
  set seriesName(String value) {
    _$seriesNameAtom.reportWrite(value, super.seriesName, () {
      super.seriesName = value;
    });
  }

  final _$originalSeriesNameAtom = Atom(name: '_Media.originalSeriesName');

  @override
  String get originalSeriesName {
    _$originalSeriesNameAtom.reportRead();
    return super.originalSeriesName;
  }

  @override
  set originalSeriesName(String value) {
    _$originalSeriesNameAtom.reportWrite(value, super.originalSeriesName, () {
      super.originalSeriesName = value;
    });
  }

  final _$releaseDateAtom = Atom(name: '_Media.releaseDate');

  @override
  String get releaseDate {
    _$releaseDateAtom.reportRead();
    return super.releaseDate;
  }

  @override
  set releaseDate(String value) {
    _$releaseDateAtom.reportWrite(value, super.releaseDate, () {
      super.releaseDate = value;
    });
  }

  final _$posterPathAtom = Atom(name: '_Media.posterPath');

  @override
  String get posterPath {
    _$posterPathAtom.reportRead();
    return super.posterPath;
  }

  @override
  set posterPath(String value) {
    _$posterPathAtom.reportWrite(value, super.posterPath, () {
      super.posterPath = value;
    });
  }

  final _$plotAtom = Atom(name: '_Media.plot');

  @override
  String get plot {
    _$plotAtom.reportRead();
    return super.plot;
  }

  @override
  set plot(String value) {
    _$plotAtom.reportWrite(value, super.plot, () {
      super.plot = value;
    });
  }

  final _$globalRuntimeAtom = Atom(name: '_Media.globalRuntime');

  @override
  int get globalRuntime {
    _$globalRuntimeAtom.reportRead();
    return super.globalRuntime;
  }

  @override
  set globalRuntime(int value) {
    _$globalRuntimeAtom.reportWrite(value, super.globalRuntime, () {
      super.globalRuntime = value;
    });
  }

  final _$preciseRuntimeAtom = Atom(name: '_Media.preciseRuntime');

  @override
  int get preciseRuntime {
    _$preciseRuntimeAtom.reportRead();
    return super.preciseRuntime;
  }

  @override
  set preciseRuntime(int value) {
    _$preciseRuntimeAtom.reportWrite(value, super.preciseRuntime, () {
      super.preciseRuntime = value;
    });
  }

  final _$episodeNumberAtom = Atom(name: '_Media.episodeNumber');

  @override
  int get episodeNumber {
    _$episodeNumberAtom.reportRead();
    return super.episodeNumber;
  }

  @override
  set episodeNumber(int value) {
    _$episodeNumberAtom.reportWrite(value, super.episodeNumber, () {
      super.episodeNumber = value;
    });
  }

  final _$seasonNumberAtom = Atom(name: '_Media.seasonNumber');

  @override
  int get seasonNumber {
    _$seasonNumberAtom.reportRead();
    return super.seasonNumber;
  }

  @override
  set seasonNumber(int value) {
    _$seasonNumberAtom.reportWrite(value, super.seasonNumber, () {
      super.seasonNumber = value;
    });
  }

  final _$chaptersAtom = Atom(name: '_Media.chapters');

  @override
  List<dynamic> get chapters {
    _$chaptersAtom.reportRead();
    return super.chapters;
  }

  @override
  set chapters(List<dynamic> value) {
    _$chaptersAtom.reportWrite(value, super.chapters, () {
      super.chapters = value;
    });
  }

  final _$_MediaActionController = ActionController(name: '_Media');

  @override
  void addExtraInfo(Map<String, dynamic> data) {
    final _$actionInfo =
        _$_MediaActionController.startAction(name: '_Media.addExtraInfo');
    try {
      return super.addExtraInfo(data);
    } finally {
      _$_MediaActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(Map<String, dynamic> data) {
    final _$actionInfo =
        _$_MediaActionController.startAction(name: '_Media.update');
    try {
      return super.update(data);
    } finally {
      _$_MediaActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAsNonMedia() {
    final _$actionInfo =
        _$_MediaActionController.startAction(name: '_Media.setAsNonMedia');
    try {
      return super.setAsNonMedia();
    } finally {
      _$_MediaActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
known: ${known},
adult: ${adult},
id: ${id},
title: ${title},
originalTitle: ${originalTitle},
seriesName: ${seriesName},
originalSeriesName: ${originalSeriesName},
releaseDate: ${releaseDate},
posterPath: ${posterPath},
plot: ${plot},
globalRuntime: ${globalRuntime},
preciseRuntime: ${preciseRuntime},
episodeNumber: ${episodeNumber},
seasonNumber: ${seasonNumber},
chapters: ${chapters},
year: ${year},
poster: ${poster},
runtime: ${runtime}
    ''';
  }
}
