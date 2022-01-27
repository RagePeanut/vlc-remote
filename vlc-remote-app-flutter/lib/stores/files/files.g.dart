// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Files on _Files, Store {
  Computed<ObservableList<Media>> _$filesAsMediasComputed;

  @override
  ObservableList<Media> get filesAsMedias => (_$filesAsMediasComputed ??=
          Computed<ObservableList<Media>>(() => super.filesAsMedias,
              name: '_Files.filesAsMedias'))
      .value;
  Computed<ObservableList<Media>> _$playlistAsMediasComputed;

  @override
  ObservableList<Media> get playlistAsMedias => (_$playlistAsMediasComputed ??=
          Computed<ObservableList<Media>>(() => super.playlistAsMedias,
              name: '_Files.playlistAsMedias'))
      .value;

  final _$currentlyPlayingIndexAtom =
      Atom(name: '_Files.currentlyPlayingIndex');

  @override
  int get currentlyPlayingIndex {
    _$currentlyPlayingIndexAtom.reportRead();
    return super.currentlyPlayingIndex;
  }

  @override
  set currentlyPlayingIndex(int value) {
    _$currentlyPlayingIndexAtom.reportWrite(value, super.currentlyPlayingIndex,
        () {
      super.currentlyPlayingIndex = value;
    });
  }

  final _$currentComputerAtom = Atom(name: '_Files.currentComputer');

  @override
  Computer get currentComputer {
    _$currentComputerAtom.reportRead();
    return super.currentComputer;
  }

  @override
  set currentComputer(Computer value) {
    _$currentComputerAtom.reportWrite(value, super.currentComputer, () {
      super.currentComputer = value;
    });
  }

  final _$computersAtom = Atom(name: '_Files.computers');

  @override
  ObservableList<Computer> get computers {
    _$computersAtom.reportRead();
    return super.computers;
  }

  @override
  set computers(ObservableList<Computer> value) {
    _$computersAtom.reportWrite(value, super.computers, () {
      super.computers = value;
    });
  }

  final _$directoryAtom = Atom(name: '_Files.directory');

  @override
  String get directory {
    _$directoryAtom.reportRead();
    return super.directory;
  }

  @override
  set directory(String value) {
    _$directoryAtom.reportWrite(value, super.directory, () {
      super.directory = value;
    });
  }

  final _$filesAtom = Atom(name: '_Files.files');

  @override
  ObservableList<File> get files {
    _$filesAtom.reportRead();
    return super.files;
  }

  @override
  set files(ObservableList<File> value) {
    _$filesAtom.reportWrite(value, super.files, () {
      super.files = value;
    });
  }

  final _$mediasAtom = Atom(name: '_Files.medias');

  @override
  ObservableMap<String, Media> get medias {
    _$mediasAtom.reportRead();
    return super.medias;
  }

  @override
  set medias(ObservableMap<String, Media> value) {
    _$mediasAtom.reportWrite(value, super.medias, () {
      super.medias = value;
    });
  }

  final _$playlistAtom = Atom(name: '_Files.playlist');

  @override
  ObservableList<PlaylistFile> get playlist {
    _$playlistAtom.reportRead();
    return super.playlist;
  }

  @override
  set playlist(ObservableList<PlaylistFile> value) {
    _$playlistAtom.reportWrite(value, super.playlist, () {
      super.playlist = value;
    });
  }

  final _$screenNumberAtom = Atom(name: '_Files.screenNumber');

  @override
  int get screenNumber {
    _$screenNumberAtom.reportRead();
    return super.screenNumber;
  }

  @override
  set screenNumber(int value) {
    _$screenNumberAtom.reportWrite(value, super.screenNumber, () {
      super.screenNumber = value;
    });
  }

  final _$_FilesActionController = ActionController(name: '_Files');

  @override
  void reset() {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.reset');
    try {
      return super.reset();
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDirectory(String path, Map<String, dynamic> data) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.updateDirectory');
    try {
      return super.updateDirectory(path, data);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlaylist(Map<String, dynamic> data) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.updatePlaylist');
    try {
      return super.updatePlaylist(data);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMedia(File file, Map<String, dynamic> data) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.updateMedia');
    try {
      return super.updateMedia(file, data);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMediaAsNonMedia(File file) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.setMediaAsNonMedia');
    try {
      return super.setMediaAsNonMedia(file);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateScreenNumber(int screenNumber) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.updateScreenNumber');
    try {
      return super.updateScreenNumber(screenNumber);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addComputer(Computer computer, bool isDefault) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.addComputer');
    try {
      return super.addComputer(computer, isDefault);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeComputer(Computer computer) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.removeComputer');
    try {
      return super.removeComputer(computer);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateComputer(int id, String ipAddress, String name, String password,
      String vlcPort, String companionPort, bool isDefault) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.updateComputer');
    try {
      return super.updateComputer(
          id, ipAddress, name, password, vlcPort, companionPort, isDefault);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void connectToComputer(Computer computer) {
    final _$actionInfo =
        _$_FilesActionController.startAction(name: '_Files.connectToComputer');
    try {
      return super.connectToComputer(computer);
    } finally {
      _$_FilesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentlyPlayingIndex: ${currentlyPlayingIndex},
currentComputer: ${currentComputer},
computers: ${computers},
directory: ${directory},
files: ${files},
medias: ${medias},
playlist: ${playlist},
screenNumber: ${screenNumber},
filesAsMedias: ${filesAsMedias},
playlistAsMedias: ${playlistAsMedias}
    ''';
  }
}
