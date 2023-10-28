// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressStore on _AddressStoreBase, Store {
  final _$locationResultAtom = Atom(name: '_AddressStoreBase.locationResult');

  @override
  LocationResult? get locationResult {
    _$locationResultAtom.reportRead();
    return super.locationResult;
  }

  @override
  set locationResult(LocationResult? value) {
    _$locationResultAtom.reportWrite(value, super.locationResult, () {
      super.locationResult = value;
    });
  }

  final _$editAddressOverlayAtom =
      Atom(name: '_AddressStoreBase.editAddressOverlay');

  @override
  OverlayEntry? get editAddressOverlay {
    _$editAddressOverlayAtom.reportRead();
    return super.editAddressOverlay;
  }

  @override
  set editAddressOverlay(OverlayEntry? value) {
    _$editAddressOverlayAtom.reportWrite(value, super.editAddressOverlay, () {
      super.editAddressOverlay = value;
    });
  }

  final _$hasAddressAtom = Atom(name: '_AddressStoreBase.hasAddress');

  @override
  bool get hasAddress {
    _$hasAddressAtom.reportRead();
    return super.hasAddress;
  }

  @override
  set hasAddress(bool value) {
    _$hasAddressAtom.reportWrite(value, super.hasAddress, () {
      super.hasAddress = value;
    });
  }

  final _$addressOverlayAtom = Atom(name: '_AddressStoreBase.addressOverlay');

  @override
  bool get addressOverlay {
    _$addressOverlayAtom.reportRead();
    return super.addressOverlay;
  }

  @override
  set addressOverlay(bool value) {
    _$addressOverlayAtom.reportWrite(value, super.addressOverlay, () {
      super.addressOverlay = value;
    });
  }

  final _$canBackAtom = Atom(name: '_AddressStoreBase.canBack');

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

  final _$addressPageContextAtom =
      Atom(name: '_AddressStoreBase.addressPageContext');

  @override
  BuildContext? get addressPageContext {
    _$addressPageContextAtom.reportRead();
    return super.addressPageContext;
  }

  @override
  set addressPageContext(BuildContext? value) {
    _$addressPageContextAtom.reportWrite(value, super.addressPageContext, () {
      super.addressPageContext = value;
    });
  }

  final _$newAddressAsyncAction = AsyncAction('_AddressStoreBase.newAddress');

  @override
  Future newAddress(
      Map<String, dynamic> addressMap, dynamic context, bool editing) {
    return _$newAddressAsyncAction
        .run(() => super.newAddress(addressMap, context, editing));
  }

  final _$setMainAddressAsyncAction =
      AsyncAction('_AddressStoreBase.setMainAddress');

  @override
  Future setMainAddress(String addressId) {
    return _$setMainAddressAsyncAction
        .run(() => super.setMainAddress(addressId));
  }

  final _$deleteAddressAsyncAction =
      AsyncAction('_AddressStoreBase.deleteAddress');

  @override
  Future deleteAddress(dynamic context, String addressId) {
    return _$deleteAddressAsyncAction
        .run(() => super.deleteAddress(context, addressId));
  }

  final _$_AddressStoreBaseActionController =
      ActionController(name: '_AddressStoreBase');

  @override
  dynamic getLocationResult(dynamic _locationResult) {
    final _$actionInfo = _$_AddressStoreBaseActionController.startAction(
        name: '_AddressStoreBase.getLocationResult');
    try {
      return super.getLocationResult(_locationResult);
    } finally {
      _$_AddressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getCanBack() {
    final _$actionInfo = _$_AddressStoreBaseActionController.startAction(
        name: '_AddressStoreBase.getCanBack');
    try {
      return super.getCanBack();
    } finally {
      _$_AddressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locationResult: ${locationResult},
editAddressOverlay: ${editAddressOverlay},
hasAddress: ${hasAddress},
addressOverlay: ${addressOverlay},
canBack: ${canBack},
addressPageContext: ${addressPageContext}
    ''';
  }
}
