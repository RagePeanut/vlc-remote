import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enums/file_type.dart';
import '../../utils/regex.dart';

part 'file.g.dart';

@JsonSerializable()
class File extends Equatable {
    File({ this.type, this.name, this.path, this.uri });

    File.fromNode(dynamic node)
      : this.type = [ "node", "dir" ].contains(node["type"]) ? FileType.DIRECTORY : FileType.FILE,
        // VLC uses the name in file details when not empty, we need the actual file name so we have to derive it from the path or the uri
        this.name = node["type"] == "dir" || extensionRegex.hasMatch(node["name"]) ? node["name"] : fileNameRegex.firstMatch(Uri.decodeFull(node["path"] ?? node["uri"]))?.group(1) ?? node["name"],
        this.path = node["path"] ?? node["uri"].substring(8), // Removing the leading "file:///"
        this.uri = node["uri"].replaceAll("%2F", "/"); // The path is what's shown to the user while the uri is what's used to navigate (different encodings)
        

    final String name, path, uri;
    final FileType type;

    bool get isFile => type == FileType.FILE;
    String get unslashedName => name.replaceAll(firstCharSlashRegex, "");

    @override
    List<Object> get props => [type, name, path, uri];

    factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

    Map<String, dynamic> toJson() => _$FileToJson(this);
}