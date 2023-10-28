import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/profile/profile_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';

import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Coupons extends StatefulWidget {
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  final MainStore mainStore = Modular.get();
  final ProfileStore store = Modular.get();
  ScrollController scrollController = ScrollController();

  int limit = 15;
  double lastExtent = 0;

  @override
  void initState() {
    // store.clearNewCoupons();
    scrollController.addListener(() {
      if (scrollController.offset >
              (scrollController.position.maxScrollExtent - 200) &&
          lastExtent < scrollController.position.maxScrollExtent) {
        setState(() {
          limit += 10;
          lastExtent = scrollController.position.maxScrollExtent;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainStore.setVisibleNav(false);
      } else {
        mainStore.setVisibleNav(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    super.dispose();
    // store.visualizedAllCoupons();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("customers")
                    .doc(mainStore.authStore.user!.uid)
                    .collection("active_coupons")
                    .where("status", isEqualTo: "VALID")
                    .where("used", isEqualTo: false)
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: (context, couponsSnapshot) {
                  if(couponsSnapshot.hasError)
                    print(couponsSnapshot.error);

                  if (!couponsSnapshot.hasData) {
                    return CenterLoadCircular();
                  }
                  List<DocumentSnapshot> couponsDocs = couponsSnapshot.data!.docs;

                  if (couponsDocs.isEmpty) {
                    return Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      alignment: Alignment.center,
                      child: Text("Nenhum cupom, ainda..."),
                    );
                  }

                  List<DocumentSnapshot> activeCoupons = [];
                  List<DocumentSnapshot> unactiveCoupons = [];

                  couponsDocs.forEach((couponDoc) {
                    if (couponDoc["actived"]) {
                      activeCoupons.add(couponDoc);
                    } else {
                      unactiveCoupons.add(couponDoc);
                    }
                  });

                  return Column(
                    children: [
                      if (activeCoupons.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(
                              top: activeCoupons.isEmpty
                                  ? MediaQuery.of(context).viewPadding.top +
                                      wXD(30, context)
                                  : wXD(90, context)),
                          width: maxWidth(context),
                          color: primary.withOpacity(.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: wXD(16, context)),
                                child: Text(
                                  'Ativo',
                                  style: textFamily(
                                    fontSize: 17,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                              ...activeCoupons.map(
                                (couponDoc) => Coupon(
                                  text: couponDoc['text'],
                                  timeAgo:
                                      store.getTime(couponDoc['created_at']), 
                                  promotion: getPromotion(couponDoc),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (unactiveCoupons.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(
                            top: activeCoupons.isEmpty
                                ? MediaQuery.of(context).viewPadding.top +
                                    wXD(14, context)
                                : 0,
                          ),
                          width: maxWidth(context),
                          // color: backgroundGrey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: wXD(16, context)),
                                child: Text(
                                  'Outros',
                                  style: textFamily(
                                    fontSize: 17,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                              ...List.generate(
                                unactiveCoupons.length,
                                (index) {
                                  DocumentSnapshot couponDoc = unactiveCoupons[index];
                                  return Coupon(
                                    onTap: () {
                                      unactiveCoupons.add(activeCoupons.first);
                                      activeCoupons.add(couponDoc);
                                      activeCoupons.removeAt(index);
                                      store.activeCoupon(couponDoc.id);
                                    },
                                    text: couponDoc['text'],
                                    promotion: getPromotion(couponDoc),
                                    timeAgo:
                                        store.getTime(couponDoc['created_at']),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
          ),
          DefaultAppBar('Cupons')
        ],
      ),
    );
  }
  getPromotion(DocumentSnapshot couponDoc){
    String response;
    if(couponDoc['discount'] != null){
      response = "R\$ ${formatedCurrency(couponDoc['discount'])}";
    } else {
      num percentOff  = couponDoc['percent_off'] / 0.01;
      response = "$percentOff %";
    }

    if(couponDoc['value_minimum'] != null && couponDoc['value_minimum'] != 0){
      response += " a cima de R\$ ${formatedCurrency(couponDoc['value_minimum'])}";
    }

    return response;
  }
}

class Coupon extends StatelessWidget {
  final String text, timeAgo, promotion;
  final Function? onTap;
  const Coupon({
    Key? key,
    required this.text,
    required this.timeAgo,
    required this.promotion,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTap != null){
          onTap!();
        }
      },
      child: Container(
        height: wXD(101, context),
        width: maxWidth(context),
        padding: EdgeInsets.fromLTRB(
          wXD(32, context),
          wXD(21, context),
          wXD(30, context),
          wXD(20, context),
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: darkGrey.withOpacity(.2))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: wXD(263, context),
              padding: EdgeInsets.only(left: wXD(15, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cupom: " + text,
                    style: textFamily(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    promotion,
                    style: textFamily(color: Color(0xff8F9AA2)),
                  ),
                  Text(
                    timeAgo,
                    style: textFamily(color: Color(0xff8F9AA2)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
