// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  final _$profileEditAtom = Atom(name: '_ProfileStoreBase.profileEdit');

  @override
  ObservableMap<dynamic, dynamic> get profileEdit {
    _$profileEditAtom.reportRead();
    return super.profileEdit;
  }

  @override
  set profileEdit(ObservableMap<dynamic, dynamic> value) {
    _$profileEditAtom.reportWrite(value, super.profileEdit, () {
      super.profileEdit = value;
    });
  }

  final _$birthdayValidateAtom =
      Atom(name: '_ProfileStoreBase.birthdayValidate');

  @override
  bool get birthdayValidate {
    _$birthdayValidateAtom.reportRead();
    return super.birthdayValidate;
  }

  @override
  set birthdayValidate(bool value) {
    _$birthdayValidateAtom.reportWrite(value, super.birthdayValidate, () {
      super.birthdayValidate = value;
    });
  }

  final _$genderValidateAtom = Atom(name: '_ProfileStoreBase.genderValidate');

  @override
  bool get genderValidate {
    _$genderValidateAtom.reportRead();
    return super.genderValidate;
  }

  @override
  set genderValidate(bool value) {
    _$genderValidateAtom.reportWrite(value, super.genderValidate, () {
      super.genderValidate = value;
    });
  }

  final _$avatarValidateAtom = Atom(name: '_ProfileStoreBase.avatarValidate');

  @override
  bool get avatarValidate {
    _$avatarValidateAtom.reportRead();
    return super.avatarValidate;
  }

  @override
  set avatarValidate(bool value) {
    _$avatarValidateAtom.reportWrite(value, super.avatarValidate, () {
      super.avatarValidate = value;
    });
  }

  final _$canBackAtom = Atom(name: '_ProfileStoreBase.canBack');

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

  final _$userVerificationIdAtom =
      Atom(name: '_ProfileStoreBase.userVerificationId');

  @override
  String get userVerificationId {
    _$userVerificationIdAtom.reportRead();
    return super.userVerificationId;
  }

  @override
  set userVerificationId(String value) {
    _$userVerificationIdAtom.reportWrite(value, super.userVerificationId, () {
      super.userVerificationId = value;
    });
  }

  final _$forceResendingTokenAtom =
      Atom(name: '_ProfileStoreBase.forceResendingToken');

  @override
  int get forceResendingToken {
    _$forceResendingTokenAtom.reportRead();
    return super.forceResendingToken;
  }

  @override
  set forceResendingToken(int value) {
    _$forceResendingTokenAtom.reportWrite(value, super.forceResendingToken, () {
      super.forceResendingToken = value;
    });
  }

  final _$confirmCodeOverlayAtom =
      Atom(name: '_ProfileStoreBase.confirmCodeOverlay');

  @override
  OverlayEntry? get confirmCodeOverlay {
    _$confirmCodeOverlayAtom.reportRead();
    return super.confirmCodeOverlay;
  }

  @override
  set confirmCodeOverlay(OverlayEntry? value) {
    _$confirmCodeOverlayAtom.reportWrite(value, super.confirmCodeOverlay, () {
      super.confirmCodeOverlay = value;
    });
  }

  final _$loadCircularCodeAtom =
      Atom(name: '_ProfileStoreBase.loadCircularCode');

  @override
  bool get loadCircularCode {
    _$loadCircularCodeAtom.reportRead();
    return super.loadCircularCode;
  }

  @override
  set loadCircularCode(bool value) {
    _$loadCircularCodeAtom.reportWrite(value, super.loadCircularCode, () {
      super.loadCircularCode = value;
    });
  }

  final _$codeAtom = Atom(name: '_ProfileStoreBase.code');

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$timerSecondsAtom = Atom(name: '_ProfileStoreBase.timerSeconds');

  @override
  int? get timerSeconds {
    _$timerSecondsAtom.reportRead();
    return super.timerSeconds;
  }

  @override
  set timerSeconds(int? value) {
    _$timerSecondsAtom.reportWrite(value, super.timerSeconds, () {
      super.timerSeconds = value;
    });
  }

  final _$timerResendeCodeAtom =
      Atom(name: '_ProfileStoreBase.timerResendeCode');

  @override
  Timer? get timerResendeCode {
    _$timerResendeCodeAtom.reportRead();
    return super.timerResendeCode;
  }

  @override
  set timerResendeCode(Timer? value) {
    _$timerResendeCodeAtom.reportWrite(value, super.timerResendeCode, () {
      super.timerResendeCode = value;
    });
  }

  final _$activeCouponAsyncAction =
      AsyncAction('_ProfileStoreBase.activeCoupon');

  @override
  Future<void> activeCoupon(String couponId) {
    return _$activeCouponAsyncAction.run(() => super.activeCoupon(couponId));
  }

  final _$clearNewNotificationsAsyncAction =
      AsyncAction('_ProfileStoreBase.clearNewNotifications');

  @override
  Future<void> clearNewNotifications() {
    return _$clearNewNotificationsAsyncAction
        .run(() => super.clearNewNotifications());
  }

  final _$shareAsyncAction = AsyncAction('_ProfileStoreBase.share');

  @override
  Future<void> share() {
    return _$shareAsyncAction.run(() => super.share());
  }

  final _$pickAvatarAsyncAction = AsyncAction('_ProfileStoreBase.pickAvatar');

  @override
  Future<void> pickAvatar() {
    return _$pickAvatarAsyncAction.run(() => super.pickAvatar());
  }

  final _$setProfileEditFromDocAsyncAction =
      AsyncAction('_ProfileStoreBase.setProfileEditFromDoc');

  @override
  Future setProfileEditFromDoc() {
    return _$setProfileEditFromDocAsyncAction
        .run(() => super.setProfileEditFromDoc());
  }

  final _$setBirthdayAsyncAction = AsyncAction('_ProfileStoreBase.setBirthday');

  @override
  Future setBirthday(dynamic context, void Function() onConfirm) {
    return _$setBirthdayAsyncAction
        .run(() => super.setBirthday(context, onConfirm));
  }

  final _$saveProfileAsyncAction = AsyncAction('_ProfileStoreBase.saveProfile');

  @override
  Future<Map<dynamic, dynamic>> saveProfile(dynamic context) {
    return _$saveProfileAsyncAction.run(() => super.saveProfile(context));
  }

  final _$updateAuthUserAsyncAction =
      AsyncAction('_ProfileStoreBase.updateAuthUser');

  @override
  Future updateAuthUser(
      {required BuildContext context,
      required bool editEmail,
      required bool editPhone}) {
    return _$updateAuthUserAsyncAction.run(() => super.updateAuthUser(
        context: context, editEmail: editEmail, editPhone: editPhone));
  }

  final _$getNotificationsAsyncAction =
      AsyncAction('_ProfileStoreBase.getNotifications');

  @override
  Future<List<List<dynamic>>> getNotifications() {
    return _$getNotificationsAsyncAction.run(() => super.getNotifications());
  }

  final _$visualizedAllNotificationsAsyncAction =
      AsyncAction('_ProfileStoreBase.visualizedAllNotifications');

  @override
  Future<void> visualizedAllNotifications() {
    return _$visualizedAllNotificationsAsyncAction
        .run(() => super.visualizedAllNotifications());
  }

  final _$changeNotificationEnabledAsyncAction =
      AsyncAction('_ProfileStoreBase.changeNotificationEnabled');

  @override
  Future changeNotificationEnabled(bool change) {
    return _$changeNotificationEnabledAsyncAction
        .run(() => super.changeNotificationEnabled(change));
  }

  final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase');

  @override
  bool getValidate() {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.getValidate');
    try {
      return super.getValidate();
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getTime(Timestamp sendedAt) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.getTime');
    try {
      return super.getTime(sendedAt);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileEdit: ${profileEdit},
birthdayValidate: ${birthdayValidate},
genderValidate: ${genderValidate},
avatarValidate: ${avatarValidate},
canBack: ${canBack},
userVerificationId: ${userVerificationId},
forceResendingToken: ${forceResendingToken},
confirmCodeOverlay: ${confirmCodeOverlay},
loadCircularCode: ${loadCircularCode},
code: ${code},
timerSeconds: ${timerSeconds},
timerResendeCode: ${timerResendeCode}
    ''';
  }
}
