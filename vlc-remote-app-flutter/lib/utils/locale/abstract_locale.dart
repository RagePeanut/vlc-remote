import 'dart:convert';
import 'dart:ui';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractLocale {
    static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    static const String _storageKey = "VLCRemote_";
    static const Map<String, List<String>> _supportedLanguages = {
        "en": [],
        "fr": [],
    };

    Locale _locale;
    Map<dynamic, dynamic> _localizedValues = Map<dynamic, dynamic>();
    VoidCallback _onLocaleChangedCallback;

    Locale get currentLocale => _locale;
    String get currentLanguage => _locale?.languageCode ?? "";
    set onLocaleChangedCallback(VoidCallback callback) => _onLocaleChangedCallback = callback;
    Iterable<Locale> get supportedLocales {
        final List<Locale> supported = [];
        _supportedLanguages.forEach((String language, List<String> countries) {
            supported.add(Locale(language));
            supported.addAll(countries.map((String country) => Locale(language, country)));
        });
        return supported;
    }

    /// Returns the string corresponding to the identifier in the current locale.
    /// 
    /// The identifier can represent a hierarchy by separating keys by dots (e.g. `authentication.logging_in` will return the logging_in value from authentication's map).
    @protected
    String text(String identifier) {
        if(_localizedValues == null) throw Exception("Localized values haven\'t been initialized"); 
        List<String> keys = identifier.split(".");
        Map<dynamic, dynamic> currentLevel = _localizedValues;
        for(int i = 0; i < keys.length; i++) {
            final dynamic currentLevelValue = currentLevel[keys[i]];
            if(currentLevelValue == null) throw Exception("Identifier $identifier not found in the ${_locale.toLanguageTag()} locale: key ${keys[i]} doesn\'t exist");
            if(currentLevelValue is Map) currentLevel = currentLevelValue;
        }
        return currentLevel[keys.last];
    }

    /// Initializes the app locale one time based on the device locale.
    Future<void> init() async {
        if(_locale == null) {
            // Setting fallback english words for incomplete translations
            await setNewLocale(Locale("en"));
            await setNewLocale(
                await getPreferredLocale("locale") ?? await getDeviceLocale(),
            );
        }
    }

    /// Returns the device locale.
    Future<Locale> getDeviceLocale() async {
        final String deviceLocaleString = await Devicelocale.currentLocale;
        final List<String> deviceLocale = deviceLocaleString.split(RegExp("[_-]"));
        // deviceLocale[0] is the language code, deviceLocale[1] is the country code
        return Locale(deviceLocale[0], deviceLocale[1]);
    }
    
    /// Returns the user's preferred locale, or null if none set.
    Future<Locale> getPreferredLocale(String name) async {
        final SharedPreferences prefs = await _prefs;
        final String prefLocaleString = prefs.getString(_storageKey + name);
        if(prefLocaleString != null) {
            final List<String> prefLocale = prefLocaleString.split(RegExp("[_-]"));
            // prefLocale[0] is the language code, prefLocale[1] is the country code
            return prefLocale.length == 1 ? Locale(prefLocale[0]) : Locale(prefLocale[0], prefLocale[1]);
        }
        return null;
    }

    /// Changes the locale used by the app.
    @protected
    Future<void> setNewLocale(Locale newLocale, [bool saveInPrefs = false]) async {
        if(_supportedLanguages[newLocale.languageCode] == null)
            _locale = Locale("en");
        else if(_supportedLanguages[newLocale.languageCode].any((String countryCode) => countryCode == newLocale.countryCode))
            _locale = newLocale;
        else _locale = Locale(newLocale.languageCode);
        final String jsonContent = await rootBundle.loadString("locale/${_locale.toLanguageTag()}.json");
        _localizedValues = _addMissingKeys(_localizedValues, jsonDecode(jsonContent));
        if(saveInPrefs) await _setPreferredLocale("locale", _locale.languageCode, _locale.countryCode);
        if(_onLocaleChangedCallback != null) _onLocaleChangedCallback();
    }

    Map<dynamic, dynamic> _addMissingKeys(Map map, Map toAdd) {
        for(dynamic key in toAdd.keys) {
            if(toAdd[key] is Map) {
                 map.putIfAbsent(key, () => Map<dynamic, dynamic>());
                 _addMissingKeys(map[key], toAdd[key]);
            } else map[key] = toAdd[key];
        }
        return map;
    }

    /// Sets the user's preferred locale.
    Future<bool> _setPreferredLocale(String name, String languageCode, [String countryCode]) async {
        final SharedPreferences prefs = await _prefs;
        return prefs.setString(_storageKey + name, countryCode == null ? languageCode : languageCode + "-" + countryCode);
    }
}