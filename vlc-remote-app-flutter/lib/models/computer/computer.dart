import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../utils/regex.dart';
import '../history/history.dart';

part 'computer.g.dart';

@JsonSerializable()
class Computer extends _Computer with _$Computer {
    Computer({
        @required String ipAddress,
        @required String name,
        @required String password,
        @required String vlcPort,
        History startHistory,
        String companionPort,
        int id, // DON'T USE, ONLY USED BY THE SERIALIZE FUNCTIONS
    }) : super(
        ipAddress: ipAddress,
        name: name,
        password: password,
        vlcPort: vlcPort,
        startHistory: startHistory,
        companionPort: companionPort,
        id: id,
    );

    factory Computer.fromQRData(String data) {
        List<String> lines = data.split("\n");
        if(lines.length < 4 || lines.length > 5) throw FormatException();
        String ipAddress, password, vlcPort, companionPort, name;
        for(String line in data.split("\n")) {
            int firstEqualIndex = line.indexOf("=");
            if(firstEqualIndex == -1) throw FormatException();
            String key = line.substring(0, firstEqualIndex).trim();
            String value = line.substring(firstEqualIndex + 1).trim();
            if(value.length == 0) throw Exception("Empty value");
            switch(key) {
                case "ip":
                    if(!ipRegex.hasMatch(value)) throw FormatException();
                    ipAddress = value;
                    break;
                case "pw":
                    password = value;
                    break;
                case "vp":
                    if(!portRegex.hasMatch(value)) throw FormatException();
                    vlcPort = value;
                    break;
                case "cp":
                    if(value != null && !portRegex.hasMatch(value)) throw FormatException();
                    companionPort = value;
                    break;
                case "nm":
                    name = value;
                    break;
                default:
                    throw Exception("Unknown key in QR data: '$key'");
            }

        }
        return Computer(
            ipAddress: ipAddress,
            name: name,
            password: password,
            vlcPort: vlcPort,
            companionPort: companionPort,
        );
    }

    factory Computer.fromJson(Map<String, dynamic> json) => _$ComputerFromJson(json);

    Map<String, dynamic> toJson() => _$ComputerToJson(this);

    @override
    String toString() {
        return '''{
    id: $id,
    ipAddress: $ipAddress,
    name: $name,
    password: $password,
    vlcPort: $vlcPort,
    companionPort: $companionPort,
    startHistory: $startHistory,
    history: $history
}''';
    }
}

abstract class _Computer with Store {
    _Computer({
        this.ipAddress,
        this.name,
        this.password,
        this.vlcPort,
        this.startHistory,
        String companionPort,
        int id,
    }) : assert(ipAddress != null && name != null && password != null && vlcPort != null),
         this.companionPort = companionPort ?? "27797",
         this.id = id ?? DateTime.now().millisecondsSinceEpoch,
         this.history = startHistory ?? History.defaultStart();

    final int id;
    History startHistory;
    String companionPort, password, vlcPort;

    @JsonKey(ignore: true)
    History history;

    @observable
    String ipAddress;

    @observable
    String name;

    bool get isOnStartHistory => history.uri == startHistory?.uri;

    @action
    void updateData(String ipAddress, String name, String password, String vlcPort, String companionPort) {
        this.ipAddress = ipAddress;
        this.name = name;
        this.password = password;
        this.vlcPort = vlcPort;
        this.companionPort = companionPort;
    }

    void addHistoryEntry(String path, String uri) {
        this.history = History(
            parent: this.history,
            path: path,
            uri: uri,
        );
    }

    void updateStartHistory() {
        this.startHistory = this.history;
    }

    void resetHistory() {
        this.history = this.startHistory ?? History.defaultStart();
    }

    void removeLastHistoryEntry() {
        this.history = this.history.parent ?? History.defaultStart();
    }
}