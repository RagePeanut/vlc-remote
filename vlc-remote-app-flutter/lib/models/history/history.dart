import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../file/file.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
    const History({ this.parent, this.path, this.uri });

    History.entry({
        @required this.parent,
        @required File directory,
    }) : this.path = directory.path,
         this.uri = directory.uri;
    
    const History.defaultStart()
        : this.parent = null,
          this.path = "",
          this.uri = "file:///";

    final String path, uri;
    final History parent;

    factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

    Map<String, dynamic> toJson() => _$HistoryToJson(this);

    @override
    String toString() {
        return '''{
    path: $path,
    uri: $uri,
    parent: $parent
}''';
    }
}