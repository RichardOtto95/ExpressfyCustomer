// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$statusAtom = Atom(name: '_AuthStoreBase.status');

  @override
  AuthStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$userVerifyIdAtom = Atom(name: '_AuthStoreBase.userVerifyId');

  @override
  String? get userVerifyId {
    _$userVerifyIdAtom.reportRead();
    return super.userVerifyId;
  }

  @override
  set userVerifyId(String? value) {
    _$userVerifyIdAtom.reportWrite(value, super.userVerifyId, () {
      super.userVerifyId = value;
    });
  }

  final _$mobileAtom = Atom(name: '_AuthStoreBase.mobile');

  @override
  String get mobile {
    _$mobileAtom.reportRead();
    return super.mobile;
  }

  @override
  set mobile(String value) {
    _$mobileAtom.reportWrite(value, super.mobile, () {
      super.mobile = value;
    });
  }

  final _$phoneMobileAtom = Atom(name: '_AuthStoreBase.phoneMobile');

  @override
  String? get phoneMobile {
    _$phoneMobileAtom.reportRead();
    return super.phoneMobile;
  }

  @override
  set phoneMobile(String? value) {
    _$phoneMobileAtom.reportWrite(value, super.phoneMobile, () {
      super.phoneMobile = value;
    });
  }

  final _$linkedAtom = Atom(name: '_AuthStoreBase.linked');

  @override
  bool get linked {
    _$linkedAtom.reportRead();
    return super.linked;
  }

  @override
  set linked(bool value) {
    _$linkedAtom.reportWrite(value, super.linked, () {
      super.linked = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthStoreBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$codeSentAtom = Atom(name: '_AuthStoreBase.codeSent');

  @override
  bool get codeSent {
    _$codeSentAtom.reportRead();
    return super.codeSent;
  }

  @override
  set codeSent(bool value) {
    _$codeSentAtom.reportWrite(value, super.codeSent, () {
      super.codeSent = value;
    });
  }

  final _$sellerBDAtom = Atom(name: '_AuthStoreBase.sellerBD');

  @override
  Customer? get sellerBD {
    _$sellerBDAtom.reportRead();
    return super.sellerBD;
  }

  @override
  set sellerBD(Customer? value) {
    _$sellerBDAtom.reportWrite(value, super.sellerBD, () {
      super.sellerBD = value;
    });
  }

  final _$overlayEntryAtom = Atom(name: '_AuthStoreBase.overlayEntry');

  @override
  OverlayEntry? get overlayEntry {
    _$overlayEntryAtom.reportRead();
    return super.overlayEntry;
  }

  @override
  set overlayEntry(OverlayEntry? value) {
    _$overlayEntryAtom.reportWrite(value, super.overlayEntry, () {
      super.overlayEntry = value;
    });
  }

  final _$canBackAtom = Atom(name: '_AuthStoreBase.canBack');

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

  final _$signinWithGoogleAsyncAction =
      AsyncAction('_AuthStoreBase.signinWithGoogle');

  @override
  Future<dynamic> signinWithGoogle() {
    return _$signinWithGoogleAsyncAction.run(() => super.signinWithGoogle());
  }

  final _$linkAccountGoogleAsyncAction =
      AsyncAction('_AuthStoreBase.linkAccountGoogle');

  @override
  Future<dynamic> linkAccountGoogle() {
    return _$linkAccountGoogleAsyncAction.run(() => super.linkAccountGoogle());
  }

  final _$getUserAsyncAction = AsyncAction('_AuthStoreBase.getUser');

  @override
  Future<dynamic> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$signupAsyncAction = AsyncAction('_AuthStoreBase.signup');

  @override
  Future<dynamic> signup(Customer customer) {
    return _$signupAsyncAction.run(() => super.signup(customer));
  }

  final _$signoutAsyncAction = AsyncAction('_AuthStoreBase.signout');

  @override
  Future<dynamic> signout() {
    return _$signoutAsyncAction.run(() => super.signout());
  }

  final _$sentSMSAsyncAction = AsyncAction('_AuthStoreBase.sentSMS');

  @override
  Future<dynamic> sentSMS(String userPhone) {
    return _$sentSMSAsyncAction.run(() => super.sentSMS(userPhone));
  }

  final _$verifyNumberAsyncAction = AsyncAction('_AuthStoreBase.verifyNumber');

  @override
  Future<dynamic> verifyNumber(String userPhone, Function callBackError) {
    return _$verifyNumberAsyncAction
        .run(() => super.verifyNumber(userPhone, callBackError));
  }

  final _$handleSmsSigninAsyncAction =
      AsyncAction('_AuthStoreBase.handleSmsSignin');

  @override
  Future handleSmsSignin(String smsCode, String verificationId) {
    return _$handleSmsSigninAsyncAction
        .run(() => super.handleSmsSignin(smsCode, verificationId));
  }

  final _$siginEmailAsyncAction = AsyncAction('_AuthStoreBase.siginEmail');

  @override
  Future<Map<dynamic, dynamic>> siginEmail(String email, String password) {
    return _$siginEmailAsyncAction.run(() => super.siginEmail(email, password));
  }

  final _$createUserWithEmailAsyncAction =
      AsyncAction('_AuthStoreBase.createUserWithEmail');

  @override
  Future createUserWithEmail(String userEmail, String userPassword) {
    return _$createUserWithEmailAsyncAction
        .run(() => super.createUserWithEmail(userEmail, userPassword));
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  bool getCanBack() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.getCanBack');
    try {
      return super.getCanBack();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getUserVerifyId() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.getUserVerifyId');
    try {
      return super.getUserVerifyId();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCodeSent(bool _valc) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setCodeSent');
    try {
      return super.setCodeSent(_valc);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLinked(bool _vald) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setLinked');
    try {
      return super.setLinked(_vald);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUser(User? value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
userVerifyId: ${userVerifyId},
mobile: ${mobile},
phoneMobile: ${phoneMobile},
linked: ${linked},
user: ${user},
codeSent: ${codeSent},
sellerBD: ${sellerBD},
overlayEntry: ${overlayEntry},
canBack: ${canBack}
    ''';
  }
}
