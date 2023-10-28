import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/modules/address/address_Page.dart';
import 'package:delivery_customer/app/modules/address/address_store.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:place_picker/place_picker.dart';
import 'widgets/address_map.dart';
import 'package:delivery_customer/app/constants/.env.dart';

class AddressModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddressStore()),
    Bind.lazySingleton((i) => MainStore()),
    Bind.lazySingleton((i) => AuthStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AddressPage(signRoot: args.data)),
    ChildRoute('/address-map', child: (_, args) => AddressMap()),
    // ChildRoute('/set-address', child: (_, args) => SetAddress()),
    ChildRoute(
      '/place-picker',
      child: (_, args) => PlacePicker(
        googleAPIKey,
        displayLocation: args.data,
      ),
    ),
  ];

  @override
  Widget get view => AddressPage();
}
