import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/orders/widgets/orders_app_bar.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_customer/app/modules/orders/orders_store.dart';
import 'package:flutter/material.dart';

import 'widgets/order_widget.dart';

class OrdersPage extends StatefulWidget {
  final String title;
  const OrdersPage({Key? key, this.title = 'OrdersPage'}) : super(key: key);
  @override
  OrdersPageState createState() => OrdersPageState();
}

class OrdersPageState extends ModularState<OrdersPage, OrdersStore> {
  final MainStore mainStore = Modular.get();
  ScrollController scrollController = ScrollController();
  // List<String> viewableOrderStatus = ["REQUESTED", "PROCESSING", "SENDED"];

  int limit = 10;
  double lastExtent = 0;

  @override
  void initState() {
    // scrollController = ScrollController();
    addListener();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  addListener() {
    scrollController.addListener(() {
      if (scrollController.offset >
              (scrollController.position.maxScrollExtent - 200) &&
          lastExtent < scrollController.position.maxScrollExtent) {
        setState(() {
          limit += 6;
          lastExtent = scrollController.position.maxScrollExtent;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        mainStore.setVisibleNav(false);
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainStore.setVisibleNav(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
        children: [
          Observer(builder: (context) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("customers")
                    .doc(mainStore.authStore.user!.uid)
                    .collection("orders")
                    .orderBy("created_at", descending: true)
                    .where("status", whereIn: store.viewableOrderStatus)
                    .limit(limit)
                    .snapshots(),
                builder: (context, snapshot) {
                  print('stream builder');
                  if (!snapshot.hasData) {
                    return CenterLoadCircular();
                  }
                  print("docs: ${snapshot.data!.docs.length}");

                  // WidgetsBinding.instance!.addPostFrameCallback((_) {
                  //   store.mountList(snapshot.data!);
                  // });

                  return SingleChildScrollView(
                    controller: scrollController,
                    child: snapshot.data!.docs.isEmpty
                        ? Container(
                            width: maxWidth(context),
                            height: maxHeight(context),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  size: wXD(90, context),
                                ),
                                Text("Sem pedidos ainda!", style: textFamily()),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(height: wXD(104, context)),
                              ...snapshot.data!.docs.map(
                                (order) => OrderWidget(
                                  orderDoc: order,
                                ),
                              ),
                              SizedBox(height: wXD(120, context))
                            ],
                          ),
                  );
                });
          }),
          OrdersAppBar(
            inProgress: () {
              setState(() {});
            },
            previous: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
