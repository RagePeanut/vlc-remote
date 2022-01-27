// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    parent: json['parent'] == null
        ? null
        : History.fromJson(json['parent'] as Map<String, dynamic>),
    path: json['path'] as String,
    uri: json['uri'] as String,
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'path': instance.path,
      'uri': instance.uri,
      'parent': instance.parent,
    };
