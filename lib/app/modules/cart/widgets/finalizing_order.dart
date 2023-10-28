import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/address_model.dart';
import 'package:delivery_customer/app/modules/cart/cart_store.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'accounts.dart';

class FinalizingOrder extends StatefulWidget {
  @override
  _FinalizingOrderState createState() => _FinalizingOrderState();
}

class _FinalizingOrderState extends State<FinalizingOrder> {
  final CartStore store = Modular.get();

  final MainStore mainStore = Modular.get();

  late Timer timer;

  @override
  void initState() {
    setTimer();
    // timer = Timer(
    //     Duration(seconds: 4), () async => await store.finalizeOrder(context));
    super.initState();
  }

  setTimer() {
    store.seconstToFinalize = 5;
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (_timer.tick == 6) {
        store.finalizeOrder(context);
        timer.cancel();
      }
      store.seconstToFinalize = 6 - _timer.tick;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (store.loadOverlay != null && store.loadOverlay!.mounted) {
          return false;
        } else {
          timer.cancel();
          return false;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  wXD(19, context),
                  wXD(40, context),
                  wXD(15, context),
                  wXD(32, context),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Observer(builder: (context) {
                      return Text(
                        'Finalizando pedido em: ${store.seconstToFinalize}',
                        style: textFamily(
                          fontSize: 20,
                          color: Color(0xff241332),
                        ),
                      );
                    }),

                    // Container(
                    //   height: wXD(25, context),
                    //   width: wXD(25, context),
                    //   child: CircularProgressIndicator(
                    //     strokeWidth: 3,
                    //     backgroundColor:
                    //         primary.withOpacity(.24),
                    //     valueColor:
                    //         AlwaysStoppedAnimation(primary),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
                padding: EdgeInsets.fromLTRB(
                  wXD(19, context),
                  0,
                  wXD(25, context),
                  wXD(26, context),
                ),
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection("customers")
                      .doc(mainStore.authStore.user!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return StreamBuilder<
                        DocumentSnapshot<Map<String, dynamic>>>(
                      stream: snapshot.data!.reference
                          .collection("addresses")
                          .doc(snapshot.data!.get("main_address"))
                          .snapshots(),
                      builder: (context, addressSnap) {
                        if (!addressSnap.hasData) {
                          return getAddressEmpty(context);
                        }
                        AddressModel address = AddressModel.fromDoc(addressSnap.data!);
                        WidgetsBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          store.addressId = address.id!;
                        });
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              size: wXD(24, context),
                              color: primary,
                            ),
                            SizedBox(width: wXD(15, context)),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: wXD(62, context),
                                height: wXD(47, context),
                                color: Colors.grey,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      zoom: 5,
                                      target: LatLng(
                                        address.latitude!,
                                        address.longitude!,
                                      )),
                                  scrollGesturesEnabled: false,
                                  mapToolbarEnabled: false,
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: false,
                                  compassEnabled: false,
                                ),
                              ),
                            ),
                            SizedBox(width: wXD(14, context)),
                            Container(
                              width: wXD(215, context),
                              child: Text(
                                address.formatedAddress!,
                                style: textFamily(height: 1.4),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Column(
                children: mainStore.cartObj
                    .map(
                      (cartItem) => StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("ads")
                              .doc(cartItem.adsId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: wXD(100, context),
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(primary),
                                ),
                              );
                            }
                            DocumentSnapshot item = snapshot.data!;
                            return Container(
                              width: maxWidth(context),
                              padding: EdgeInsets.only(
                                left: wXD(19, context),
                                bottom: wXD(12, context),
                              ),
                              margin: EdgeInsets.only(top: wXD(15, context)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: wXD(24, context),
                                    color: primary,
                                  ),
                                  SizedBox(width: wXD(15, context)),
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: item['images'].first,
                                      width: wXD(62, context),
                                      height: wXD(65, context),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: wXD(8, context)),
                                    width: wXD(250, context),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: textFamily(color: totalBlack),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: wXD(3, context)),
                                        Text(
                                          item['description'],
                                          style: textFamily(color: lightGrey),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: wXD(3, context)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                    .toList(),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: darkGrey.withOpacity(.2)),
                    top: BorderSide(color: darkGrey.withOpacity(.2)),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  wXD(19, context),
                  wXD(18, context),
                  wXD(0, context),
                  wXD(16, context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          size: wXD(24, context),
                          color: primary,
                        ),
                        SizedBox(width: wXD(15, context)),
                        SizedBox(width: wXD(14, context)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.foreCast(),
                              style: textFamily(color: totalBlack),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: wXD(3, context)),
                            Text(
                              'Previsão de chegada',
                              style: textFamily(color: Color(0xffbdbdbd)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: wXD(3, context)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              FutureBuilder<List<num>>(
                future: store.getSubTotal(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: wXD(120, context),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(primary),
                      ),
                    );
                  }
                  print("snapshot: ${snapshot.data}");
                  return Column(
                    children: [
                      Accounts(
                        subTotal: snapshot.data![0],
                        priceShipping: snapshot.data![1],
                        priceTotal: snapshot.data![2],
                        discount: snapshot.data![3],
                        newPriceTotal: snapshot.data![4],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: wXD(20, context),
                          left: wXD(30, context),
                          bottom: store.change == 0 ? wXD(15, context) : 0,
                        ),
                        decoration: store.change == 0
                            ? BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: darkGrey.withOpacity(.2)),
                                ),
                              )
                            : null,
                        child: Row(
                          children: [
                            Text(
                              'Método de pagamento',
                              style: textFamily(
                                fontSize: 15,
                                color: darkGrey,
                              ),
                            ),
                            Spacer(),
                            Text(
                              // store.paymentMethod == "Dinheiro"
                              //     ? 'Dinheiro'
                              //     : 'Cartão: ${store.finalNumberCard}',
                              store.paymentMethod,
                              style: textFamily(
                                fontSize: 15,
                                color: primary,
                              ),
                            ),
                            // store.paymentMethod != "Dinheiro"
                            //     ? SizedBox(
                            //         width: wXD(20, context),
                            //         child: Image.asset(
                            //           './assets/images/${store.flagCard}.png',
                            //           fit: BoxFit.contain,
                            //         ),
                            //       )
                            //     : SizedBox(),
                          ],
                        ),
                      ),
                      store.change == 0
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(
                                right: wXD(20, context),
                                left: wXD(30, context),
                                bottom: wXD(15, context),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: darkGrey.withOpacity(.2)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Troco',
                                    style: textFamily(
                                      fontSize: 15,
                                      color: darkGrey,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'R\$ ${formatedCurrency(store.change)}',
                                    style: textFamily(
                                      fontSize: 15,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: wXD(50, context)),
                width: maxWidth(context),
                alignment: Alignment.centerRight,
                child: SideButton(
                  onTap: () {
                    if (store.loadOverlay == null ||
                        !store.loadOverlay!.mounted) {
                      timer.cancel();
                      Modular.to.pop();
                    }
                  },
                  title: 'Desfazer',
                  width: wXD(122, context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAddressEmpty(context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: wXD(62, context),
            height: wXD(47, context),
            color: Colors.grey,
          ),
        ),
        SizedBox(width: wXD(14, context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: wXD(12, context),
              width: wXD(130, context),
              child: LinearProgressIndicator(
                backgroundColor: primary.withOpacity(.3),
                color: primary.withOpacity(.8),
              ),
            ),
            SizedBox(height: wXD(5, context)),
            Container(
              height: wXD(12, context),
              width: wXD(150, context),
              child: LinearProgressIndicator(
                backgroundColor: primary.withOpacity(.3),
                color: primary.withOpacity(.8),
              ),
            ),
            SizedBox(height: wXD(5, context)),
            Container(
              height: wXD(12, context),
              width: wXD(140, context),
              child: LinearProgressIndicator(
                backgroundColor: primary.withOpacity(.3),
                color: primary.withOpacity(.8),
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward,
            size: wXD(20, context),
            color: primary,
          ),
        )
      ],
    );
  }
}
