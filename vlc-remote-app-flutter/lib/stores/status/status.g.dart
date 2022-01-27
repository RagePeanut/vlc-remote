// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Status on _Status, Store {
  final _$titleAtom = Atom(name: '_Status.title');

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

  final _$yearAtom = Atom(name: '_Status.year');

  @override
  String get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(String value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  final _$isFullscreenAtom = Atom(name: '_Status.isFullscreen');

  @override
  bool get isFullscreen {
    _$isFullscreenAtom.reportRead();
    return super.isFullscreen;
  }

  @override
  set isFullscreen(bool value) {
    _$isFullscreenAtom.reportWrite(value, super.isFullscreen, () {
      super.isFullscreen = value;
    });
  }

  final _$isOnAtom = Atom(name: '_Status.isOn');

  @override
  bool get isOn {
    _$isOnAtom.reportRead();
    return super.isOn;
  }

  @override
  set isOn(bool value) {
    _$isOnAtom.reportWrite(value, super.isOn, () {
      super.isOn = value;
    });
  }

  final _$isPausedAtom = Atom(name: '_Status.isPaused');

  @override
  bool get isPaused {
    _$isPausedAtom.reportRead();
    return super.isPaused;
  }

  @override
  set isPaused(bool value) {
    _$isPausedAtom.reportWrite(value, super.isPaused, () {
      super.isPaused = value;
    });
  }

  final _$loopAtom = Atom(name: '_Status.loop');

  @override
  bool get loop {
    _$loopAtom.reportRead();
    return super.loop;
  }

  @override
  set loop(bool value) {
    _$loopAtom.reportWrite(value, super.loop, () {
      super.loop = value;
    });
  }

  final _$repeatAtom = Atom(name: '_Status.repeat');

  @override
  bool get repeat {
    _$repeatAtom.reportRead();
    return super.repeat;
  }

  @override
  set repeat(bool value) {
    _$repeatAtom.reportWrite(value, super.repeat, () {
      super.repeat = value;
    });
  }

  final _$timeAtom = Atom(name: '_Status.time');

  @override
  int get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(int value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$lengthAtom = Atom(name: '_Status.length');

  @override
  int get length {
    _$lengthAtom.reportRead();
    return super.length;
  }

  @override
  set length(int value) {
    _$lengthAtom.reportWrite(value, super.length, () {
      super.length = value;
    });
  }

  final _$chapterAtom = Atom(name: '_Status.chapter');

  @override
  int get chapter {
    _$chapterAtom.reportRead();
    return super.chapter;
  }

  @override
  set chapter(int value) {
    _$chapterAtom.reportWrite(value, super.chapter, () {
      super.chapter = value;
    });
  }

  final _$chapterCountAtom = Atom(name: '_Status.chapterCount');

  @override
  int get chapterCount {
    _$chapterCountAtom.reportRead();
    return super.chapterCount;
  }

  @override
  set chapterCount(int value) {
    _$chapterCountAtom.reportWrite(value, super.chapterCount, () {
      super.chapterCount = value;
    });
  }

  final _$progressAtom = Atom(name: '_Status.progress');

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  final _$_StatusActionController = ActionController(name: '_Status');

  @override
  void update(Map<String, dynamic> data, List<Media> playlist) {
    final _$actionInfo =
        _$_StatusActionController.startAction(name: '_Status.update');
    try {
      return super.update(data, playlist);
    } finally {
      _$_StatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOff() {
    final _$actionInfo =
        _$_StatusActionController.startAction(name: '_Status.setOff');
    try {
      return super.setOff();
    } finally {
      _$_StatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchPower(bool wasOn) {
    final _$actionInfo =
        _$_StatusActionController.startAction(name: '_Status.switchPower');
    try {
      return super.switchPower(wasOn);
    } finally {
      _$_StatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
year: ${year},
isFullscreen: ${isFullscreen},
isOn: ${isOn},
isPaused: ${isPaused},
loop: ${loop},
repeat: ${repeat},
time: ${time},
length: ${length},
chapter: ${chapter},
chapterCount: ${chapterCount},
progress: ${progress}
    ''';
  }
}
