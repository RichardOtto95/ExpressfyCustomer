import 'package:delivery_customer/app/modules/main/main_module.dart';
import 'package:delivery_customer/app/modules/sign_phone/widgets/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_customer/app/core/modules/root/root_store.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  final RootStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.reload();
      return MainModule();
    } else {
      return OnBoarding();
    }
  }
}
