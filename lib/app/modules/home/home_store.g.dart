// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$_userStreamSubscriptionAtom =
      Atom(name: '_HomeStoreBase._userStreamSubscription');

  @override
  StreamSubscription<dynamic>? get _userStreamSubscription {
    _$_userStreamSubscriptionAtom.reportRead();
    return super._userStreamSubscription;
  }

  @override
  set _userStreamSubscription(StreamSubscription<dynamic>? value) {
    _$_userStreamSubscriptionAtom
        .reportWrite(value, super._userStreamSubscription, () {
      super._userStreamSubscription = value;
    });
  }

  final _$categorySelectedAtom = Atom(name: '_HomeStoreBase.categorySelected');

  @override
  String? get categorySelected {
    _$categorySelectedAtom.reportRead();
    return super.categorySelected;
  }

  @override
  set categorySelected(String? value) {
    _$categorySelectedAtom.reportWrite(value, super.categorySelected, () {
      super.categorySelected = value;
    });
  }

  final _$promotionalCodeAtom = Atom(name: '_HomeStoreBase.promotionalCode');

  @override
  String get promotionalCode {
    _$promotionalCodeAtom.reportRead();
    return super.promotionalCode;
  }

  @override
  set promotionalCode(String value) {
    _$promotionalCodeAtom.reportWrite(value, super.promotionalCode, () {
      super.promotionalCode = value;
    });
  }

  final _$canBackAtom = Atom(name: '_HomeStoreBase.canBack');

  @override
  bool get canBack {
    _$canBackAtom.reportRead();
    return super.canBack;
  }

  @override
  set canBack(bool value) {
    _$canBackAtom.reportWrite(value, super.canBack, () {
      super.canBack = value;
    });
  }

  @override
  String toString() {
    return '''
categorySelected: ${categorySelected},
promotionalCode: ${promotionalCode},
canBack: ${canBack}
    ''';
  }
}
