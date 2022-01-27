import 'package:mobx/mobx.dart';

import '../../enums/settings_category.dart';

part 'settings_history.g.dart';

class SettingsHistory = _SettingsHistory with _$SettingsHistory;

abstract class _SettingsHistory with Store {
    _SettingsHistory() {
        reset();
    }

    @observable
    ObservableList<SettingsCategory> _history;

    @computed
    SettingsCategory get currentCategory => _history[0];

    @action
    void addEntry(SettingsCategory category) {
        _history.insert(0, category);
    }

    @action
    SettingsCategory removeLastEntry() {
        return _history.length >= 2 ? _history.removeAt(0) : null;
    }

    @action
    void reset() {
        _history = ObservableList.of([ SettingsCategory.MAIN ]);
    }

    // TODO: uncomment if necessary, currently useless
    // int get length => _history.length;
}