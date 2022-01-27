import 'dart:ui';

import '../../enums/settings_category.dart';
import 'abstract_locale.dart';

class AppLocale extends AbstractLocale {
    Future<void> changeLocale(Locale locale) => setNewLocale(locale, true);

    // Getters for all the translatable strings.
    String get buttonAddToPlaylist => text("button.add_to_playlist");
    String get buttonAudioTrack => text("button.audio_track");
    String get buttonCancel => text("button.cancel");
    String get buttonConfirm => text("button.confirm");
    String get buttonDonate => text("button.donate");
    String get buttonExplorer => text("button.explorer");
    String buttonFullscreen(bool activated) => text("button.fullscreen.${activated ? "on" : "off"}");
    String get buttonPlay => text("button.play");
    String get buttonPlayer => text("button.player");
    String get buttonPlaylist => text("button.playlist");
    String buttonPower(bool activated) => text("button.power.${activated ? "on" : "off"}");
    String get buttonSave => text("button.save");
    String buttonScreen(int number) => text("button.screen").replaceAll("%%number%%", number.toString());
    String get buttonSubtitleTrack => text("button.subtitle_track");
    String get buttonVideoTrack => text("button.video_track");

    String dialogConnectionTitle(String computer) => text("dialog.connection.title").replaceAll("%%computer%%", computer);
    String dialogConnectionCurrentlyConnected(String computer) => text("dialog.connection.currently_connected").replaceAll("%%computer%%", computer);
    String get dialogConnectionNotConnected => text("dialog.connection.not_connected");
    String get dialogMediaPlotMissing => text("dialog.media.plot_missing");
    String dialogMediaRuntime(int runtime) {
        int hours = runtime ~/ 60;
        int minutes = runtime % 60;
        if(minutes == 0) return text("dialog.media.runtime_only_hours").replaceFirst("%%hours%%", hours.toString());
        if(hours == 0) return text("dialog.media.runtime_only_minutes").replaceFirst("%%minutes%%", minutes.toString());
        return text("dialog.media.runtime").replaceFirst("%%hours%%", hours.toString()).replaceFirst("%%minutes%%", minutes.toString());
    }
    String dialogMediaSeasonEpisode(int season, int episode) => text("dialog.media.season_episode").replaceFirst("%%season%%", season.toString()).replaceFirst("%%episode%%", episode.toString());
    String get dialogReportTitle => text("dialog.report.title");

    String get inputInvalidEmpty => text("input._invalid.empty");
    String get inputInvalidId => text("input._invalid.id");
    String get inputInvalidIp => text("input._invalid.ip");
    String get inputInvalidPort => text("input._invalid.port");

    String get inputCompanionPortLabel => text("input.companion_port.label");
    String get inputIdHint => text("input.id.hint");
    String get inputIdLabel => text("input.id.label");
    String get inputIpHint => text("input.ip.hint");
    String get inputIpLabel => text("input.ip.label");
    String get inputNameHint => text("input.name.hint");
    String get inputNameLabel => text("input.name.label");
    String get inputPasswordHint => text("input.password.hint");
    String get inputPasswordLabel => text("input.password.label");
    String get inputVlcPortHint => text("input.vlc_port.hint");
    String get inputVlcPortLabel => text("input.vlc_port.label");
    
    String get otherNoComputer => text("other.no_computer");
    String get otherNoPoster => text("other.no_poster");

    final Map<SettingsCategory, String> _settingsCategoryTitles = {
        SettingsCategory.MAIN: "settings.title",
        SettingsCategory.COMPUTERS: "settings.computers.title",
        SettingsCategory.EXPLORER: "settings.explorer.title",
        SettingsCategory.MEDIAS: "settings.medias.title",
    };
    String settingsCategoryTitle(SettingsCategory settingsCategory) => text(_settingsCategoryTitles[settingsCategory]);

    String get settingsComputersTitle => text("settings.computers.title");
    String get settingsComputersDesc => text("settings.computers.desc");
    String get settingsExplorerTitle => text("settings.explorer.title");
    String get settingsExplorerDesc => text("settings.explorer.desc");
    String get settingsExplorerDisplayTypeTitle => text("settings.explorer.display_type.title");
    String get settingsExplorerDisplayTypeDesc => text("settings.explorer.display_type.desc");
    String get settingsExplorerDisplayTypeOptionGrid => text("settings.explorer.display_type.option.grid");
    String get settingsExplorerDisplayTypeOptionList => text("settings.explorer.display_type.option.list");
    String get settingsLanguageTitle => text("settings.language.title");
    String get settingsLanguageDesc => text("settings.language.desc");
    String get settingsMediasTitle => text("settings.medias.title");
    String get settingsMediasDesc => text("settings.medias.desc");
    String get settingsMediasReleaseDateTitle => text("settings.medias.release_date.title");
    String get settingsMediasReleaseDateDesc => text("settings.medias.release_date.desc");
    String get settingsMediasRightTimeIndicatorTitle => text("settings.medias.right_time_indicator.title");
    String get settingsMediasRightTimeIndicatorDesc => text("settings.medias.right_time_indicator.desc");
    String get settingsMediasRightTimeIndicatorOptionRuntime => text("settings.medias.right_time_indicator.option.runtime");
    String get settingsMediasRightTimeIndicatorOptionTimeRemaining => text("settings.medias.right_time_indicator.option.time_remaining");
    String get settingsMediasShowAdultPostersTitle => text("settings.medias.show_adult_posters.title");
    String get settingsMediasShowAdultPostersDesc => text("settings.medias.show_adult_posters.desc");
    String get settingsMediasUseOriginalTitleTitle => text("settings.medias.use_original_title.title");
    String get settingsMediasUseOriginalTitleDesc => text("settings.medias.use_original_title.desc");

    String get sheetPlaylist => text("sheet.playlist");

    String get snackbarErrorMediaUpdate => text("snackbar.error.media_update");

    String get switchUseByDefault => text("switch.use_by_default");
}

final AppLocale locale = AppLocale();