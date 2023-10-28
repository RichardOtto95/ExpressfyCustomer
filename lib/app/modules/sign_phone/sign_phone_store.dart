import 'package:delivery_customer/app/core/services/auth/auth_service_interface.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/load_circular_overlay.dart';
import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/core/models/customer_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
part 'sign_phone_store.g.dart';

class SignPhoneStore = _SignPhoneStoreBase with _$SignPhoneStore;

abstract class _SignPhoneStoreBase with Store {
  final AuthStore authStore = Modular.get();
  final Customer customer;
  final AuthServiceInterface authService = Modular.get();
  @observable
  User? valueUser;
  @observable
  String? phone;
  @observable
  int start = 60;
  @observable
  Timer? timer;
  @observable
  String updateEmail = '';

  @observable
  _SignPhoneStoreBase(this.customer);

  @action
  void setPhone(_phone) => phone = _phone;

  @action
  int getStart() => start;

  @action
  verifyNumber(BuildContext context) async {
    authStore.overlayEntry =
        OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(authStore.overlayEntry!);
    authStore.canBack = false;

    print('##### phone $phone');
    String userPhone = '+55' + phone!;
    print('##### userPhone $userPhone');
    await authStore.verifyNumber(phone!, (String errorCode){
      Fluttertoast.showToast(
          msg: "error: $errorCode",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,        
          backgroundColor: Colors.red[700],
          textColor: Colors.white,
          fontSize: 16.0,
      );            
    });
  }

  @action
  signinPhone(String _code, context) async {
    print('%%%%%%%% signinPhone %%%%%%%%');
    print('$_code, ${authStore.getUserVerifyId()}');
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);
    authStore.canBack = false;

    await authStore
        .handleSmsSignin(_code, authStore.getUserVerifyId())
        .then((value) async {
      print("Dentro do then");
      print('%%%%%%%% signinPhone2 $value %%%%%%%%');
      if (value != null) {
        valueUser = value;
        DocumentSnapshot _user = await FirebaseFirestore.instance
            .collection('customers')
            .doc(value.uid)
            .get();
        if (_user.exists) {
          print('%%%%%%%% signinPhone _user.exists == true  %%%%%%%%');

          String? tokenString = await FirebaseMessaging.instance.getToken();
          print('tokenId: $tokenString');

          await _user.reference.update({
            'token_id': [tokenString]
          });

          // Modular.to.pushNamed("/main");
          Modular.to.pushReplacementNamed('/main');
        } else {
          await authService.handleSignup(customer);
          print('%%%%%%%% signinPhone _user.exists == false  %%%%%%%%');

          // Modular.to.pushNamed("/main");
          Modular.to.pushReplacementNamed('/main');
        }
      } else {}
    });

    print("Fora do then");
    overlayEntry.remove();

    authStore.canBack = true;
  }

  @action
  updateUserEmail(context) async {
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);
    authStore.canBack = false;

    print('updateUserPhone');
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.currentUser!.updateEmail(updateEmail);
      await authService.handleSignup(customer);
      Modular.to.pushNamed('/address', arguments: true);
      print('email atualizado!!!');
    } on FirebaseAuthException catch (error) {
      print('erro ao atualizar!!!');
      print(error);
      print(error.code);

      if (error.code == 'email-already-in-use') {
        showToast('O e-mail digitado já está em uso!');
      }
      if (error.code == 'invalid-email') {
        showToast('E-mail inválido!');
      }
    }
    authStore.canBack = true;

    overlayEntry.remove();
  }
}
