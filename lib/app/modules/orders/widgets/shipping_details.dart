import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/order_model.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/orders/widgets/token.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_customer/app/shared/widgets/confirm_popup.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../orders_store.dart';
import 'ads_order_data.dart';
import 'status_forecast.dart';

class ShippingDetails extends StatefulWidget {
  final Map<String, dynamic> adsOrderId;

  ShippingDetails({
    Key? key,
    required this.adsOrderId,
  }) : super(key: key);

  @override
  State<ShippingDetails> createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  final MainStore mainStore = Modular.get();
  final OrdersStore store = Modular.get();

  @override
  void initState() {
    // store.addOrderListener(widget.adsOrderId["id"], context);
    
    store.zoomPanBehavior = MapZoomPanBehavior(
      // zoomLevel: 13,
      zoomLevel: 5,
      enableDoubleTapZooming: true,
      focalLatLng: MapLatLng(-15.787763, -48.008072),
    );

    store.mapTileLayerController = MapTileLayerController();
    super.initState();
  }

  @override
  void dispose() {
    store.clearShippingDetails();
    // if (store.orderSubs != null) store.orderSubs!.cancel();
    // store.orderSubs = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!store.canBack) {
          return false;
        }
        if (store.overlayCancel != null) {
          if (store.overlayCancel!.mounted) {
            store.overlayCancel!.remove();
            store.overlayCancel = null;
          }
        }
        store.adsId = null;
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('orders').doc(widget.adsOrderId["id"]).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return CenterLoadCircular();
                }

                DocumentSnapshot orderDoc = snapshot.data!;

                return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: wXD(101, context)),
                        Observer(
                          builder: (context) {
                            return StatusForecast(
                              status: orderDoc['status'],
                              deliveryForecast: store.deliveryForecast,
                              deliveryForecastLabel:
                                  store.deliveryForecastLabel,
                              // paid: orderDoc['paid'],
                            );
                          }
                        ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(
                        //     wXD(0, context),
                        //     wXD(20, context),
                        //     wXD(0, context),
                        //     wXD(0, context),
                        //   ),
                        //   height: wXD(250, context),
                        //   width: maxWidth(context),
                        //   color: lightGrey.withOpacity(.2),
                        //   child: Observer(builder: (context) {
                        //     return GoogleMap(
                        //       initialCameraPosition: CameraPosition(
                        //           target: LatLng(-15.787763, -48.008072),
                        //           zoom: 11.5),
                        //       myLocationButtonEnabled: true,
                        //       scrollGesturesEnabled: false,
                        //       zoomControlsEnabled: false,
                        //       onMapCreated: (controller) {
                        //         store.googleMapController = controller;
                        //       },
                        //       markers: {
                        //         if (store.origin != null) store.origin!,
                        //         if (store.destination != null)
                        //           store.destination!,
                        //       },
                        //       polylines: {
                        //         if (store.info != null)
                        //           Polyline(
                        //               polylineId:
                        //                   PolylineId("overview_polyline"),
                        //               color: Colors.red,
                        //               width: 5,
                        //               points: store.info!.polylinePoints
                        //                   .map((e) => LatLng(
                        //                       e.latitude, e.longitude))
                        //                   .toList())
                        //       },
                        //     );
                        //   }),
                        // ),
                        // Container(
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     // borderRadius: BorderRadius.all(Radius.circular(20)),
                        //     border: Border(
                        //       bottom: BorderSide(
                        //         color: darkGrey.withOpacity(.2),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: wXD(20, context)),
                          child: FutureBuilder(
                            future: store.getRoute(widget.adsOrderId["id"], context),
                            builder: (context, snapshot) {
                              if(snapshot.hasError){
                                print(snapshot.error);
                              }

                              if(!snapshot.hasData){
                                return Container(
                                  height: wXD(250, context),
                                  width: maxWidth(context),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: primary,
                                    ),
                                  ),
                                );
                              }

                              Map<String, dynamic> response = snapshot.data! as Map<String, dynamic>;

                              if(response['status'] == "FAILED"){
                                return Container(
                                  height: wXD(250, context),
                                  width: maxWidth(context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [                    
                                      Text(
                                        "Ative as permissões para continuar!",
                                        style: textFamily(),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Permission.location.request();
                                        }, 
                                        child: Text(
                                          "Solicitar permissão",
                                          style: textFamily(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              // Position userCurrentPosition = response['user-current-position'];
                              // _zoomPanBehavior.focalLatLng = MapLatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
                              return Observer(
                                builder: (context) {
                                  return Container(
                                    height: wXD(250, context),
                                    width: maxWidth(context),
                                    child: SfMaps(
                                      layers: [
                                        MapTileLayer(
                                          controller: store.mapTileLayerController,
                                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          zoomPanBehavior: store.zoomPanBehavior,
                                          markerBuilder: (BuildContext context, int index) {
                                            MapMarker _marker = store.mapMarkersList[index];
                                            return _marker;
                                          },                                          
                                          initialMarkersCount: store.mapMarkersList.length,                                          
                                          sublayers: 
                                          store.polyPoints != [] ? 
                                          [
                                            MapPolylineLayer(                                              
                                              polylines: {
                                                  MapPolyline(                                                      
                                                    color: Colors.red,
                                                    width: 5,
                                                    points: store.polyPoints
                                                      .map((e) => MapLatLng(
                                                          e.latitude, e.longitude))
                                                      .toList(),
                                                  ),
                                              },
                                            ),
                                          ] : null,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              );
                            }
                          ),
                        ),
                        Container(
                          width: maxWidth(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: wXD(16, context),
                            vertical: wXD(24, context),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: darkGrey.withOpacity(.2)))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: wXD(25, context),
                                    color: primary,
                                  ),
                                  SizedBox(width: wXD(12, context)),
                                  Observer(
                                    builder: (context) {
                                      return Container(
                                        width: wXD(250, context),
                                        child: Text(
                                          store.destinationAddress != null ?
                                          store.destinationAddress!
                                              .formatedAddress! : "",
                                          style: TextStyle(
                                            color: darkGrey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Token(token: orderDoc['customer_token']),
                        InkWell(
                          onTap: () {
                            store.sendMessage(orderDoc);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: wXD(15, context),
                                top: wXD(15, context)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: wXD(30, context),
                                      right: wXD(3, context)),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: primary,
                                    size: wXD(20, context),
                                  ),
                                ),
                                Text(
                                  'Enviar uma mensagem',
                                  style: textFamily(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: wXD(14, context)),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: primary,
                                    size: wXD(20, context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: wXD(32, context),
                                  right: wXD(40, context)),
                              child: Column(
                                children: getBools(4, orderDoc['status']),
                              ),
                            ),
                            Observer(
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...store.steps.map(
                                      (step) => Step(
                                        title: step['title'],
                                        subTitle: step['sub_title'],
                                        orderStatus: orderDoc['status'],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: darkGrey.withOpacity(.2)))),
                        ),
                        ...widget.adsOrderId["itemsQue"]
                            .map((adsDoc) => AdsOrderData(
                                  adsDoc: adsDoc,
                                  totalItems: adsDoc["amount"],
                                ))
                            .toList(),
                        if (orderDoc['status'] == "REQUESTED")
                          InkWell(
                            onTap: () {
                              store.overlayCancel = OverlayEntry(
                                builder: (context) => ConfirmPopup(
                                  text:
                                      "Tem certeza que deseja cancelar este pedido?",
                                  onConfirm: () async {
                                    await store.cancelOrder(context, orderDoc);
                                    store.overlayCancel!.remove();
                                  },
                                  onCancel: () =>
                                      store.overlayCancel!.remove(),
                                ),
                              );
                              Overlay.of(context)!
                                  .insert(store.overlayCancel!);
                            },
                            child: Container(
                              width: maxWidth(context),
                              height: wXD(60, context),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancelar",
                                style: textFamily(
                                  color: red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        !orderDoc['rated'] &&
                                orderDoc['status'] == "CONCLUDED"
                            ? EvaluateOrderCard(
                                rating: orderDoc['rating'],
                                rated: orderDoc['rated'],
                                onTap: () {
                                  print(
                                      "store.order!.rated: ${orderDoc['rated']}");
                                  if (!orderDoc['rated'])
                                    Modular.to.pushNamed(
                                      '/orders/evaluation',
                                      arguments: Order.fromDoc(orderDoc),
                                    );
                                })
                            : Container(),
                      ],
                    ),
                  ); 
              },
            ),
            
            DefaultAppBar(
              'Detalhes do envio',
              onPop: () {
                store.adsId = null;
                Modular.to.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getBools(int steps, String status) {
    int step = 0;
    switch (status) {
      case "REQUESTED":
        step = 0;
        break;
      case "TIMEOUT":
        step = 1;
        break;
      case "PROCESSING":
        step = 1;
        break;
      case "DELIVERY_REFUSED":
        step = 1;
        break;
      case "DELIVERY_ACCEPTED":
        step = 1;
        break;
      case "DELIVERY_CANCELED":
        step = 2;
        break;
      case "SENDED":
        step = 2;
        break;
      case "CANCELED":
        step = 1;
        break;
      case "REFUSED":
        step = 0;
        break;
      case "CONCLUDED":
        step = 3;
        break;
      default:
        step = 0;
        break;
    }
    List<Widget> balls = [];
    for (var i = 0; i <= ((steps - 1) * 6); i++) {
      bool sixMultiple = i % 6 == 0;
      bool lessMultiple = (i + 1) % 6 != 0;
      if (sixMultiple) {
        // print('$i é multiplo de 6');
        (status == "CANCELED" || status == "REFUSED") && i == step * 6
            ? balls.add(RedBall(isRed: i == step * 6))
            : balls.add(Ball(orange: i <= step * 6));
      } else {
        // print('$i não é multiplo de 6');
        balls.add(LittleBall(
          orange: i <= step * 6,
          padding: lessMultiple,
        ));
      }
    }
    return balls;
  }
}

class EvaluateOrderCard extends StatelessWidget {
  final bool rated;
  final double? rating;

  final void Function() onTap;
  EvaluateOrderCard({required this.onTap, required this.rated, this.rating});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: wXD(100, context),
          width: wXD(343, context),
          margin: EdgeInsets.symmetric(vertical: wXD(24, context)),
          padding: EdgeInsets.symmetric(
            horizontal: wXD(16, context),
            vertical: wXD(13, context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 3),
                  color: totalBlack.withOpacity(.2))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rated ? "Pedido avaliado" : 'Avalie o seu pedido',
                style: TextStyle(
                  color: totalBlack,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat',
                ),
              ),
              RatingBar(
                onRatingUpdate: (value) {},
                initialRating: rating ?? 0,
                ignoreGestures: true,
                glowColor: primary.withOpacity(.4),
                unratedColor: primary.withOpacity(.4),
                allowHalfRating: true,
                itemSize: wXD(35, context),
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star_rounded, color: primary),
                  empty: Icon(Icons.star_outline_rounded, color: primary),
                  half: Icon(Icons.star_half_rounded, color: primary),
                ),
              ),
              Text(
                rated
                    ? "Esta é a média da sua avaliação"
                    : 'Escolha de 1 a 5 estrelas para classificar',
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RedBall extends StatelessWidget {
  final bool isRed;

  RedBall({Key? key, required this.isRed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: wXD(7, context)),
      height: wXD(6, context),
      width: wXD(6, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isRed ? red : Color(0xffbdbdbd),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final bool orange;

  const Ball({Key? key, required this.orange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: wXD(7, context)),
      height: wXD(6, context),
      width: wXD(6, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: orange ? primary : Color(0xffbdbdbd),
      ),
    );
  }
}

class LittleBall extends StatelessWidget {
  final bool orange;
  final bool padding;

  const LittleBall({
    Key? key,
    required this.orange,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('padding: $padding');
    return Container(
      margin: EdgeInsets.only(bottom: padding ? wXD(6, context) : 0),
      height: wXD(4, context),
      width: wXD(4, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: orange
            ? primary.withOpacity(.5)
            : Color(0xff78849e).withOpacity(.3),
      ),
    );
  }
}

class Step extends StatelessWidget {
  final String title, subTitle, orderStatus;
  Step({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.orderStatus,
  }) : super(key: key);
  final OrdersStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    Color titleColor = textBlack;
    Color textColor = darkGrey;
    if (title == "Entregue" && orderStatus != "CONCLUDED") {
      titleColor = textBlack.withOpacity(.4);
      textColor = textLightGrey;
    }
    return Container(
      margin: EdgeInsets.only(bottom: wXD(28, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}
