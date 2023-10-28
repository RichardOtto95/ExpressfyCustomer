// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_email_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignEmailStore on _SignEmailStoreBase, Store {
  final _$emailControllerAtom =
      Atom(name: '_SignEmailStoreBase.emailController');

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  final _$passwordControllerAtom =
      Atom(name: '_SignEmailStoreBase.passwordController');

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  final _$emailAtom = Atom(name: '_SignEmailStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_SignEmailStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$canBackAtom = Atom(name: '_SignEmailStoreBase.canBack');

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

  final _$verifyEmailAsyncAction =
      AsyncAction('_SignEmailStoreBase.verifyEmail');

  @override
  Future verifyEmail(BuildContext context) {
    return _$verifyEmailAsyncAction.run(() => super.verifyEmail(context));
  }

  final _$_SignEmailStoreBaseActionController =
      ActionController(name: '_SignEmailStoreBase');

  @override
  dynamic back() {
    final _$actionInfo = _$_SignEmailStoreBaseActionController.startAction(
        name: '_SignEmailStoreBase.back');
    try {
      return super.back();
    } finally {
      _$_SignEmailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailController: ${emailController},
passwordController: ${passwordController},
email: ${email},
password: ${password},
canBack: ${canBack}
    ''';
  }
}
