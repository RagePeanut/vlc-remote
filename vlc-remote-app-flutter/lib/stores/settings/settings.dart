import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums/data_display.dart';
import '../../enums/date_display.dart';
import '../../enums/time_indicator_type.dart';

part 'settings.g.dart';

class Settings = _Settings with _$Settings;

abstract class _Settings with Store {
    _Settings({
        @required this.prefs,
    }) : this.explorerDisplay = DataDisplay.values[prefs.getInt("explorer_display") ?? 0],
         this.releaseDateDisplay = DateDisplay.values[prefs.getInt("release_date_format") ?? 2],
         this.rightTimeIndicatorUsed = TimeIndicatorType.values[prefs.getInt("right_time_indicator_used") ?? 0],
         this.showAdultPosters = prefs.getBool("show_adult_posters") ?? false,
         this.useOriginalTitle = prefs.getBool("use_original_title") ?? false;

    final SharedPreferences prefs;

    @observable
    DataDisplay explorerDisplay;

    @observable
    DateDisplay releaseDateDisplay;

    @observable
    TimeIndicatorType rightTimeIndicatorUsed;

    @observable
    bool showAdultPosters;

    @observable
    bool useOriginalTitle;

    @action
    void setExplorerDisplay(DataDisplay value) {
        this.explorerDisplay = value;
        prefs.setInt("explorer_display", value.index);
    }

    @action
    void setReleaseDateDisplay(DateDisplay value) {
        this.releaseDateDisplay = value;
        prefs.setInt("release_date_format", value.index);
    }

    @action
    void setRightTimeIndicatorUsed(TimeIndicatorType value) {
        this.rightTimeIndicatorUsed = value;
        prefs.setInt("right_time_indicator_used", value.index);
    }

    @action
    void setShowAdultPosters(bool value) {
        this.showAdultPosters = value;
        prefs.setBool("show_adult_posters", value);
    }
    
    @action
    void setUseOriginalTitle(bool value) {
        this.useOriginalTitle = value;
        prefs.setBool("use_original_title", value);
    }
}