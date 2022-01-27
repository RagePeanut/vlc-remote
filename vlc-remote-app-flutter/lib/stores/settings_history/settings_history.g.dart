// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_history.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsHistory on _SettingsHistory, Store {
  Computed<SettingsCategory> _$currentCategoryComputed;

  @override
  SettingsCategory get currentCategory => (_$currentCategoryComputed ??=
          Computed<SettingsCategory>(() => super.currentCategory,
              name: '_SettingsHistory.currentCategory'))
      .value;

  final _$_historyAtom = Atom(name: '_SettingsHistory._history');

  @override
  ObservableList<SettingsCategory> get _history {
    _$_historyAtom.reportRead();
    return super._history;
  }

  @override
  set _history(ObservableList<SettingsCategory> value) {
    _$_historyAtom.reportWrite(value, super._history, () {
      super._history = value;
    });
  }

  final _$_SettingsHistoryActionController =
      ActionController(name: '_SettingsHistory');

  @override
  void addEntry(SettingsCategory category) {
    final _$actionInfo = _$_SettingsHistoryActionController.startAction(
        name: '_SettingsHistory.addEntry');
    try {
      return super.addEntry(category);
    } finally {
      _$_SettingsHistoryActionController.endAction(_$actionInfo);
    }
  }

  @override
  SettingsCategory removeLastEntry() {
    final _$actionInfo = _$_SettingsHistoryActionController.startAction(
        name: '_SettingsHistory.removeLastEntry');
    try {
      return super.removeLastEntry();
    } finally {
      _$_SettingsHistoryActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_SettingsHistoryActionController.startAction(
        name: '_SettingsHistory.reset');
    try {
      return super.reset();
    } finally {
      _$_SettingsHistoryActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentCategory: ${currentCategory}
    ''';
  }
}
