import 'package:delivery_customer/app/core/models/customer_model.dart';
import 'package:delivery_customer/app/core/services/auth/auth_service.dart';
import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/modules/sign_phone/sign_phone_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'sign_page_phone.dart';

class SignPhoneModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Customer()),
    Bind.lazySingleton((i) => AuthStore()),
    Bind.lazySingleton((i) => SignPhoneStore(i.get())),
    Bind.lazySingleton((i) => AuthService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/sign-phone', child: (_, args) => SignPagePhone()),
  ];

  @override
  Widget get view => SignPagePhone();
}
