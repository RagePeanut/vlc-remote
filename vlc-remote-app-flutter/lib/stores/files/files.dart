import 'package:localstorage/localstorage.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/computer/computer.dart';
import '../../models/file/file.dart';
import '../../models/history/history.dart';
import '../../models/media/media.dart';
import '../../models/playlist_file.dart';
import '../../services/vlc.dart';
import '../../utils/regex.dart';

part 'files.g.dart';

// The state of the playlist and the browser
class Files = _Files with _$Files;

abstract class _Files with Store {
    void init(int defaultComputerId) {
        this.store = LocalStorage("storage");
        this.medias = ObservableMap<String, Media>.of(
            store.getItem("medias")?.map<String, Media>(
                (String fileName, dynamic value) => MapEntry<String, Media>(fileName, Media.fromJson(value))
            ) ?? {}
        );
        this.defaultComputerId = defaultComputerId;
        this.computers = ObservableList<Computer>.of(
            store.getItem("computers")?.map<Computer>((dynamic value) {
                Computer computer = Computer.fromJson(value);
                if(computer.id == defaultComputerId) connectToComputer(computer);
                return computer;
            }) ?? []
        );
    }

    int defaultComputerId;
    LocalStorage store;

    @observable
    int currentlyPlayingIndex;

    @observable
    Computer currentComputer;

    @observable
    ObservableList<Computer> computers;

    @observable
    String directory;

    @observable
    ObservableList<File> files = ObservableList<File>();

    @observable
    ObservableMap<String, Media> medias = ObservableMap<String, Media>();

    @observable
    ObservableList<PlaylistFile> playlist = ObservableList<PlaylistFile>();

    @observable
    int screenNumber = 1;

    @computed
    ObservableList<Media> get filesAsMedias => ObservableList.of(files.where((File file) => file.isFile).map((File file) => medias[file.name]));

    @computed
    ObservableList<Media> get playlistAsMedias => ObservableList.of(playlist.map((File file) => medias[file.name]));

    @action
    void reset() {
        this.playlist.clear();
        this.files.clear();
        this.directory = null;
        this.currentlyPlayingIndex = null;
    }

    @action
    void updateDirectory(String path, Map<String, dynamic> data) {
        this.directory = path;
        data["element"].sort((dynamic n1, dynamic n2) {
            int typeComparison = n1["type"].compareTo(n2["type"]);
            return typeComparison != 0
                ? typeComparison
                : n1["name"].toUpperCase().compareTo(n2["name"].toUpperCase()) as int;
        });
        bool updatedMedias = false;
        this.files = ObservableList.of(
            data["element"]
                .where((dynamic node) => node["type"] == "dir" && node["name"] != ".." || node["name"].contains(fileExtensions))
                .map<File>((dynamic node) {
                    File file = File.fromNode(node);
                    if(file.isFile) {
                        this.medias.putIfAbsent(file.name, () {
                            updatedMedias = true;
                            return Media(file: file);
                        });
                    }
                    return file;
                })
        );
        if(updatedMedias) store.setItem("medias", medias.map((String fileName, Media media) => MapEntry<String, Map>(fileName, media.toJson())));
    }

    @action
    void updatePlaylist(Map<String, dynamic> data) {
        List<dynamic> entries = Map.from(data["children"].singleWhere((dynamic node) => node["id"] == "1"))["children"];
        bool sameLength = entries.length == this.playlist.length;
        bool isDifferent = !sameLength;
        bool updatedMedias = false;
        List<PlaylistFile> pfiles = [];
        for(int i = 0; i < entries.length; i++) {
            PlaylistFile pfile = PlaylistFile.fromNode(entries[i]);
            isDifferent = isDifferent || (sameLength && pfile != this.playlist[i]);
            if(pfile.currentlyPlaying && (isDifferent || i != currentlyPlayingIndex)) {
                this.currentlyPlayingIndex = i;
            }
            pfiles.add(pfile);
            this.medias.putIfAbsent(pfile.name, () {
                updatedMedias = true;
                return Media(file: pfile);
            });
        }
        if(isDifferent) this.playlist = ObservableList.of(pfiles);
        if(updatedMedias) store.setItem("medias", medias.map((String fileName, Media media) => MapEntry<String, Map>(fileName, media.toJson())));
    }

    @action
    void updateMedia(File file, Map<String, dynamic> data) {
        if(this.medias[file.name] == null) this.medias[file.name] = Media(file: file);
        this.medias[file.name].update(data);
        store.setItem("medias", medias.map((String fileName, Media media) => MapEntry<String, Map>(fileName, media.toJson())));
    }

    @action
    void setMediaAsNonMedia(File file) {
        this.medias[file.name].setAsNonMedia();
        store.setItem("medias", medias.map((String fileName, Media media) => MapEntry<String, Map>(fileName, media.toJson())));
    }

    @action
    void updateScreenNumber(int screenNumber) {
        this.screenNumber = screenNumber;
    }

    @action
    void addComputer(Computer computer, bool isDefault) {
        this.computers.add(computer);
        store.setItem("computers", this.computers.map((Computer computer) => computer.toJson()).toList());
        if(this.computers.length == 1) connectToComputer(computer);
        if(isDefault) setDefaultComputer(computer.id);
    }

    @action
    void removeComputer(Computer computer) {
        this.computers.remove(computer);
        store.setItem("computers", this.computers.map((Computer computer) => computer.toJson()).toList());
        if(this.currentComputer == computer) {
            this.currentComputer = null;
            reset();
        }
        if(this.defaultComputerId == computer.id) setDefaultComputer(null);
    }

    @action
    void updateComputer(int id, String ipAddress, String name, String password, String vlcPort, String companionPort, bool isDefault) {
        Computer computer = this.computers.firstWhere((computer) => computer.id == id, orElse: () => null);
        if(computer != null) {
            computer.updateData(ipAddress, name, password, vlcPort, companionPort);
            store.setItem("computers", this.computers.map((Computer computer) => computer.toJson()).toList());
            if(isDefault) setDefaultComputer(id);
        }
    }

    @action
    void connectToComputer(Computer computer) {
        this.currentComputer = computer..resetHistory();
        History history = this.currentComputer.history;
        VLC.browse(history.path, history.uri, true);
    }

    Future<void> setDefaultComputer(int id) async {
        this.defaultComputerId = id;
        (await SharedPreferences.getInstance()).setInt("default_computer", id);
    }

    void saveCurrentHistoryAsDefault() {
        this.currentComputer.updateStartHistory();
        store.setItem("computers", this.computers.map((Computer computer) => computer.toJson()).toList());
    }
}