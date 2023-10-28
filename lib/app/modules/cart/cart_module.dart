import 'package:delivery_customer/app/modules/cart/cart_Page.dart';
import 'package:delivery_customer/app/modules/cart/cart_store.dart';
import 'package:delivery_customer/app/modules/cart/widgets/finalizing_order.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/delivery_address.dart';

class CartModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CartPage()),
    ChildRoute('/finalizing', child: (_, args) => FinalizingOrder()),
    ChildRoute('/delivery-address', child: (_, args) => DeliveryAddress()),
  ];

  @override
  Widget get view => CartPage();
}
