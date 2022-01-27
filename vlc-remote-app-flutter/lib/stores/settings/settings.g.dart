// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Settings on _Settings, Store {
  final _$explorerDisplayAtom = Atom(name: '_Settings.explorerDisplay');

  @override
  DataDisplay get explorerDisplay {
    _$explorerDisplayAtom.reportRead();
    return super.explorerDisplay;
  }

  @override
  set explorerDisplay(DataDisplay value) {
    _$explorerDisplayAtom.reportWrite(value, super.explorerDisplay, () {
      super.explorerDisplay = value;
    });
  }

  final _$releaseDateDisplayAtom = Atom(name: '_Settings.releaseDateDisplay');

  @override
  DateDisplay get releaseDateDisplay {
    _$releaseDateDisplayAtom.reportRead();
    return super.releaseDateDisplay;
  }

  @override
  set releaseDateDisplay(DateDisplay value) {
    _$releaseDateDisplayAtom.reportWrite(value, super.releaseDateDisplay, () {
      super.releaseDateDisplay = value;
    });
  }

  final _$rightTimeIndicatorUsedAtom =
      Atom(name: '_Settings.rightTimeIndicatorUsed');

  @override
  TimeIndicatorType get rightTimeIndicatorUsed {
    _$rightTimeIndicatorUsedAtom.reportRead();
    return super.rightTimeIndicatorUsed;
  }

  @override
  set rightTimeIndicatorUsed(TimeIndicatorType value) {
    _$rightTimeIndicatorUsedAtom
        .reportWrite(value, super.rightTimeIndicatorUsed, () {
      super.rightTimeIndicatorUsed = value;
    });
  }

  final _$showAdultPostersAtom = Atom(name: '_Settings.showAdultPosters');

  @override
  bool get showAdultPosters {
    _$showAdultPostersAtom.reportRead();
    return super.showAdultPosters;
  }

  @override
  set showAdultPosters(bool value) {
    _$showAdultPostersAtom.reportWrite(value, super.showAdultPosters, () {
      super.showAdultPosters = value;
    });
  }

  final _$useOriginalTitleAtom = Atom(name: '_Settings.useOriginalTitle');

  @override
  bool get useOriginalTitle {
    _$useOriginalTitleAtom.reportRead();
    return super.useOriginalTitle;
  }

  @override
  set useOriginalTitle(bool value) {
    _$useOriginalTitleAtom.reportWrite(value, super.useOriginalTitle, () {
      super.useOriginalTitle = value;
    });
  }

  final _$_SettingsActionController = ActionController(name: '_Settings');

  @override
  void setExplorerDisplay(DataDisplay value) {
    final _$actionInfo = _$_SettingsActionController.startAction(
        name: '_Settings.setExplorerDisplay');
    try {
      return super.setExplorerDisplay(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReleaseDateDisplay(DateDisplay value) {
    final _$actionInfo = _$_SettingsActionController.startAction(
        name: '_Settings.setReleaseDateDisplay');
    try {
      return super.setReleaseDateDisplay(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRightTimeIndicatorUsed(TimeIndicatorType value) {
    final _$actionInfo = _$_SettingsActionController.startAction(
        name: '_Settings.setRightTimeIndicatorUsed');
    try {
      return super.setRightTimeIndicatorUsed(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowAdultPosters(bool value) {
    final _$actionInfo = _$_SettingsActionController.startAction(
        name: '_Settings.setShowAdultPosters');
    try {
      return super.setShowAdultPosters(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUseOriginalTitle(bool value) {
    final _$actionInfo = _$_SettingsActionController.startAction(
        name: '_Settings.setUseOriginalTitle');
    try {
      return super.setUseOriginalTitle(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
explorerDisplay: ${explorerDisplay},
releaseDateDisplay: ${releaseDateDisplay},
rightTimeIndicatorUsed: ${rightTimeIndicatorUsed},
showAdultPosters: ${showAdultPosters},
useOriginalTitle: ${useOriginalTitle}
    ''';
  }
}
