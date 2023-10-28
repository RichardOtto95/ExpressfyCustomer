import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/address_model.dart';
import 'package:delivery_customer/app/modules/cart/cart_store.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// ignore: must_be_immutable
class DeliveryAddressSelected extends StatelessWidget {
  final void Function() onTap;
  DeliveryAddressSelected({Key? key, required this.onTap}) : super(key: key);
  final MainStore mainStore = Modular.get();
  final CartStore store = Modular.get();
  GoogleMapController? mapController;
  MapZoomPanBehavior zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 5,
      enableDoubleTapZooming: true,
      focalLatLng: MapLatLng(-15.787763, -48.008072),
    );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (mainStore.customer == null) {
          return Container();
        }
        if (mainStore.customer!.mainAddress == null) {
          return Container();
        }
        store.addressId = mainStore.customer!.id;
        print("customer: ${mainStore.customer!.toJson()}");
        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("customers")
              .doc(mainStore.customer!.id)
              .collection("addresses")
              .doc(mainStore.customer!.mainAddress)
              .snapshots(),
          builder: (context, addressSnap) {
            if (!addressSnap.hasData) {
              return getAddressEmpty(context);
            }
            AddressModel address = AddressModel.fromDoc(addressSnap.data!);
            // store.setMarker(address, context);
            zoomPanBehavior.focalLatLng = MapLatLng(address.latitude!, address.longitude!);
            zoomPanBehavior.zoomLevel = 15;

            // WidgetsBinding.instance!.addPostFrameCallback((_) {

            // });
            return InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
                padding: EdgeInsets.fromLTRB(18, 20, 25, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Endereço de entrega',
                      style: textFamily(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textDarkGrey,
                      ),
                    ),
                    SizedBox(height: wXD(10, context)),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       child: SizedBox(
                    //         width: wXD(120, context),
                    //         height: wXD(80, context),
                    //         child: Observer(builder: (context) {
                    //           print("marker: ${store.marker}");
                    //           return GoogleMap(
                    //             initialCameraPosition: CameraPosition(
                    //                 zoom: 15,
                    //                 target: LatLng(
                    //                   address.latitude!,
                    //                   address.longitude!,
                    //                 )),
                    //             onMapCreated: (controller) {
                    //               mapController = controller;
                    //               mapController!.animateCamera(
                    //                   CameraUpdate.newLatLng(LatLng(
                    //                       address.latitude!,
                    //                       address.longitude!)));
                    //             },
                    //             scrollGesturesEnabled: false,
                    //             mapToolbarEnabled: false,
                    //             zoomControlsEnabled: false,
                    //             zoomGesturesEnabled: false,
                    //             compassEnabled: false,
                    //             markers: {
                    //               if (store.marker != null) store.marker!
                    //             },
                    //           );
                    //         }),
                    //       ),
                    //     ),
                    //     SizedBox(width: wXD(10, context)),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Container(
                    //           width: wXD(180, context),
                    //           child: Text(address.formatedAddress!,
                    //               style: textFamily(height: 1.4)),
                    //         ),
                    //       ],
                    //     ),
                    //     Spacer(),
                    //     Icon(
                    //       Icons.arrow_forward,
                    //       size: wXD(20, context),
                    //       color: primary,
                    //     ),
                    //   ],
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            width: wXD(120, context),
                            height: wXD(80, context),
                            child: SfMaps(
                              layers: [
                                MapTileLayer(
                                  // controller: store.mapTileLayerController,
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  zoomPanBehavior: zoomPanBehavior,
                                  markerBuilder: (BuildContext context, int index) {
                                    MapMarker _marker = MapMarker(
                                      latitude: address.latitude!,
                                      longitude: address.longitude!,
                                      child: Icon(                          
                                        Icons.location_on,
                                        color: primary,
                                      ),
                                    );

                                    return _marker;
                                  },                                          
                                  initialMarkersCount: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: wXD(10, context)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: wXD(180, context),
                              child: Text(address.formatedAddress!,
                                  style: textFamily(height: 1.4)),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          size: wXD(20, context),
                          color: primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
          onPressed: onTap,
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
