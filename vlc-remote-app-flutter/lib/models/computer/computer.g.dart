// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'computer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Computer _$ComputerFromJson(Map<String, dynamic> json) {
  return Computer(
    ipAddress: json['ipAddress'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
    vlcPort: json['vlcPort'] as String,
    startHistory: json['startHistory'] == null
        ? null
        : History.fromJson(json['startHistory'] as Map<String, dynamic>),
    companionPort: json['companionPort'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$ComputerToJson(Computer instance) => <String, dynamic>{
      'id': instance.id,
      'startHistory': instance.startHistory,
      'companionPort': instance.companionPort,
      'password': instance.password,
      'vlcPort': instance.vlcPort,
      'ipAddress': instance.ipAddress,
      'name': instance.name,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Computer on _Computer, Store {
  final _$ipAddressAtom = Atom(name: '_Computer.ipAddress');

  @override
  String get ipAddress {
    _$ipAddressAtom.reportRead();
    return super.ipAddress;
  }

  @override
  set ipAddress(String value) {
    _$ipAddressAtom.reportWrite(value, super.ipAddress, () {
      super.ipAddress = value;
    });
  }

  final _$nameAtom = Atom(name: '_Computer.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$_ComputerActionController = ActionController(name: '_Computer');

  @override
  void updateData(String ipAddress, String name, String password,
      String vlcPort, String companionPort) {
    final _$actionInfo =
        _$_ComputerActionController.startAction(name: '_Computer.updateData');
    try {
      return super
          .updateData(ipAddress, name, password, vlcPort, companionPort);
    } finally {
      _$_ComputerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ipAddress: ${ipAddress},
name: ${name}
    ''';
  }
}
