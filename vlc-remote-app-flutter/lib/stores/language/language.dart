import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:mobx/mobx.dart';

import '../../utils/locale/app_locale.dart';

part 'language.g.dart';

class Language = _Language with _$Language;

abstract class _Language with Store {
    _Language() : this.short = locale.currentLanguage {
        initializeDateFormatting(short);
    }

    static const Map<String, String> languages = {
        "en": "English",
        "fr": "Français",
    };

    @computed
    String get long => languages[short];

    @observable
    String short;

    // TODO: uncomment if it turns out to be necessary, not seeing an use to it currently
    // @observable
    // Locale _locale;

    @action
    Future<void> setLocale(Locale newLocale) async {
        await locale.changeLocale(newLocale);
        short = locale.currentLanguage;
        // TODO: uncomment if it turns out to be necessary, not seeing an use to it currently
        // _locale = locale.currentLocale;
    }
}