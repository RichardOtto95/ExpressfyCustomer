import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/orders/orders_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrdersAppBar extends StatelessWidget {
  OrdersAppBar({
    Key? key,
    required this.inProgress,
    required this.previous,
  }) : super(key: key);

  final OrdersStore store = Modular.get();
  final Function inProgress;
  final Function previous;

  @override
  Widget build(BuildContext context) {
    final MainStore mainStore = Modular.get();
    return Container(
      height: wXD(104, context),
      width: maxWidth(context),
      padding: EdgeInsets.symmetric(horizontal: wXD(35, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
        color: white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 3),
            color: Color(0x30000000),
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Meus pedidos',
            style: textFamily(
              fontSize: 20,
              color: darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: wXD(10, context)),
          DefaultTabController(
            length: 2,
            child: TabBar(
              indicatorColor: primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(vertical: 8),
              labelColor: primary,
              labelStyle: textFamily(fontWeight: FontWeight.bold),
              unselectedLabelColor: darkGrey,
              indicatorWeight: 3,
              onTap: (value) {
                mainStore.setVisibleNav(true);
                if (value == 0) {
                  store.viewableOrderStatus = [
                    "REQUESTED",
                    "PROCESSING",
                    "SENDED",
                    "DELIVERY_ACCEPTED",
                    "DELIVERY_REQUESTED",
                    "DELIVERY_REFUSED",
                    "TIMEOUT"
                  ];
                  inProgress();
                } else {
                  store.viewableOrderStatus = [
                    "CANCELED",
                    "REFUSED",
                    "CONCLUDED",
                    "PAYMENT_FAILED"
                  ];
                  previous();
                }
              },
              tabs: [Text('Em andamento'), Text('Anteriores')],
            ),
          ),
        ],
      ),
    );
  }
}
