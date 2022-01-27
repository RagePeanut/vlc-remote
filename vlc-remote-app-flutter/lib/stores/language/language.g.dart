// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Language on _Language, Store {
  Computed<String> _$longComputed;

  @override
  String get long => (_$longComputed ??=
          Computed<String>(() => super.long, name: '_Language.long'))
      .value;

  final _$shortAtom = Atom(name: '_Language.short');

  @override
  String get short {
    _$shortAtom.reportRead();
    return super.short;
  }

  @override
  set short(String value) {
    _$shortAtom.reportWrite(value, super.short, () {
      super.short = value;
    });
  }

  final _$setLocaleAsyncAction = AsyncAction('_Language.setLocale');

  @override
  Future<void> setLocale(Locale newLocale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(newLocale));
  }

  @override
  String toString() {
    return '''
short: ${short},
long: ${long}
    ''';
  }
}
