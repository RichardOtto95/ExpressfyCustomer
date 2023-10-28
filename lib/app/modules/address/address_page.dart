import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/address_model.dart';
import 'package:delivery_customer/app/modules/cart/widgets/delivery_search_field.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/address.dart';
import 'package:delivery_customer/app/shared/widgets/address_edition.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_customer/app/shared/widgets/overlays.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_customer/app/modules/address/address_store.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/address_popup.dart';

class AddressPage extends StatefulWidget {
  final bool signRoot;

  AddressPage({Key? key, this.signRoot = false}) : super(key: key);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends ModularState<AddressPage, AddressStore> {
  final MainStore mainStore = Modular.get();
  final AddressStore addressStore = Modular.get();

  @override
  void initState() {
    // print("SignRoot address page: ${widget.signRoot}");
    if (widget.signRoot) {
      showToast("Defina um endereço para continuar");
    }
    super.initState();
  }

  OverlayEntry? _overlay;

  getAdressPopUpOverlay(AddressModel addressModel, context) {
    mainStore.globalOverlay = OverlayEntry(
      builder: (ovContext) => AddressPopUp(
        model: addressModel,
        onCancel: () {
          mainStore.globalOverlay!.remove();
          mainStore.globalOverlay = null;
        },
        onEdit: () {
          // print("onEdit");
          mainStore.globalOverlay!.remove();
          mainStore.globalOverlay = null;
          _overlay = OverlayEntry(
            builder: (oContext) => EditAddress(
              context,
              address: addressModel,
              editing: true,
              onBack: () {
                _overlay!.remove();
                _overlay = null;
              },
            ),
          );
          Overlay.of(context)!.insert(_overlay!);
          // mainStore.globalOverlay!.remove();
          // mainStore.globalOverlay = null;
          // Overlays(context)
          //     .insertAddAddress(editing: true, model: addressModel);
        },
        onDelete: () async {
          store.deleteAddress(context, addressModel.id!);
        },
      ),
    );
    Overlay.of(context)!.insert(mainStore.globalOverlay!);
  }

  @override
  Widget build(context) {
    store.addressPageContext = context;
    return WillPopScope(
      onWillPop: () async {
        print("la vai mais um");
        if (_overlay != null) {
          print("_overlay $_overlay");
          _overlay!.remove();
          _overlay = null;
          return false;
        }
        print("la vai mais um");
        if (mainStore.globalOverlay != null) {
          mainStore.globalOverlay!.remove();
          mainStore.globalOverlay = null;
          return false;
        }
        print("la vai mais um");
        if (store.editAddressOverlay != null) {
          store.editAddressOverlay!.remove();
          store.editAddressOverlay = null;
          return false;
        }
        print("la vai mais um");
        return true;
        // if (!store.getCanBack()) {
        //   return false;
        // }
        // if (_overlay != null) {
        //   _overlay!.remove();
        //   _overlay = null;
        //   return false;
        // } else if (mainStore.globalOverlay != null) {
        //   mainStore.globalOverlay!.remove();
        //   mainStore.globalOverlay = null;
        //   return false;
        // } else if (store.editAddressOverlay != null) {
        //   store.editAddressOverlay!.remove();
        //   store.editAddressOverlay = null;
        //   return false;
        // }
        // return true;
      },
      child: Scaffold(
        backgroundColor: backgroundGrey,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: maxHeight(context),
              width: maxWidth(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: wXD(101, context)),
                    DeliverySearchField(
                      onTap: () async {
                        // await Modular.to.pushNamed("/address/set-address");
                        store.locationResult =
                            await Modular.to.pushNamed("/address/place-picker");
                        if (store.locationResult != null) {
                          Overlays(context).insertAddAddress();
                        }
                      },
                    ),
                    // UseCurrentLocalization(),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("customers")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("addresses")
                          .where("status", isEqualTo: "ACTIVE")
                          .orderBy("created_at", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CenterLoadCircular();
                        }
                        List<DocumentSnapshot> addresses = snapshot.data!.docs;
                        if (addresses.isEmpty) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            store.hasAddress = false;
                          });
                          return Container(
                            height: maxHeight(context) - wXD(300, context),
                            width: maxWidth(context),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: wXD(150, context),
                                ),
                                Text(
                                  "Sem endereços cadastrados",
                                  style: textFamily(fontSize: 15),
                                )
                              ],
                            ),
                          );
                        }
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          setState(() => store.hasAddress = true);
                        });
                        List<DocumentSnapshot> addressesList = [];
                        for (var _address in addresses) {
                          if (_address.get("main")) {
                            addressesList.insert(0, _address);
                          } else {
                            addressesList.add(_address);
                          }
                        }
                        return Column(
                          children: addressesList
                              .map((address) => AddressWidget(
                                    model: AddressModel.fromDoc(address),
                                    iconTap: () {
                                      getAdressPopUpOverlay(
                                          AddressModel.fromDoc(address),
                                          context);
                                    },
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: DefaultAppBar('Endereço de entrega',
                    noPop: widget.signRoot)),
            Visibility(
              visible: widget.signRoot && store.hasAddress,
              child: Positioned(
                bottom: wXD(50, context),
                right: 0,
                child: SideButton(
                  title: "Continuar",
                  height: wXD(52, context),
                  width: wXD(120, context),
                  onTap: () => Modular.to.pushNamed("/main"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditAddress extends StatefulWidget {
  final AddressModel address;
  final bool homeRoot;
  final bool editing;
  final BuildContext context;
  final void Function()? onBack;

  EditAddress(
    this.context, {
    Key? key,
    required this.address,
    this.homeRoot = false,
    this.editing = false,
    this.onBack,
  }) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  // late AnimationController _controller;

  bool animate = false;

  @override
  void initState() {
    super.initState();
    // _controller =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    WidgetsBinding.instance!
        .addPostFrameCallback((timeStamp) => setState(() => animate = true));
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() => animate = false);
              if (widget.onBack != null) {
                await Future.delayed(Duration(milliseconds: 300));
                widget.onBack!();
              }
            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              curve: Curves.decelerate,
              opacity: animate ? .4 : 0,
              child: Container(
                height: maxHeight(context),
                width: maxWidth(context),
                color: totalBlack,
              ),
            ),
          ),
          AnimatedPositioned(
            top: animate ? 0 : maxHeight(context),
            child: AddressEdition(
              context: context,
              editing: widget.editing,
              homeRoot: widget.homeRoot,
              model: widget.address,
              onBack: () async {
                setState(() => animate = false);
                if (widget.onBack != null) {
                  await Future.delayed(Duration(milliseconds: 300));
                  widget.onBack!();
                }
              },
            ),
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

// class UseCurrentLocalization extends StatelessWidget {
//   const UseCurrentLocalization({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth(context),
//       padding: EdgeInsets.only(
//           left: wXD(27, context),
//           top: wXD(34, context),
//           bottom: wXD(24, context)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.my_location,
//             size: wXD(20, context),
//             color: grey.withOpacity(.5),
//           ),
//           SizedBox(width: wXD(12, context)),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Usar localização atual',
//                 style: textFamily(
//                   fontSize: 15,
//                   color: textDarkBlue,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Container(
//                 width: wXD(225, context),
//                 child: Text(
//                   'St. Hab. Vicente Pires Chácara 26 - Taguatinga, Brasília - DF ',
//                   style: textFamily(
//                     fontSize: 13,
//                     color: grey.withOpacity(.55),
//                     fontWeight: FontWeight.w400,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 3,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class RecentAddress extends StatelessWidget {
  final void Function() iconTap;
  const RecentAddress({Key? key, required this.iconTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: wXD(162, context),
      width: wXD(352, context),
      margin: EdgeInsets.only(bottom: wXD(13, context)),
      padding: EdgeInsets.fromLTRB(
        0,
        wXD(11, context),
        wXD(17, context),
        wXD(11, context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Color(0xfff1f1f1), width: wXD(2, context)),
        color: white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 3),
            color: Color(0x20000000),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: wXD(335, context),
            padding: EdgeInsets.only(left: wXD(53, context)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: wXD(5, context)),
                  child: Text(
                    'St. Hab. Vicente Pires, 25',
                    style: textFamily(fontSize: 15),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: iconTap,
                  child: Icon(
                    Icons.more_vert,
                    color: primary,
                    size: wXD(24, context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: wXD(15, context),
                    right: wXD(13, context),
                    bottom: wXD(15, context)),
                child: Icon(
                  Icons.av_timer,
                  color: grey.withOpacity(.5),
                  size: wXD(24, context),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: wXD(200, context),
                    child: Text(
                      'Brasília, Brasília - DF',
                      style: textFamily(
                        color: grey.withOpacity(.55),
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Container(
                    width: wXD(250, context),
                    child: Text(
                      'Condomínio Hawai - O Condomínio fica de frente para o último balão da via marginal com a estrutural',
                      style: textFamily(
                        color: grey.withOpacity(.55),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onTap;
  WhiteButton({required this.icon, required this.text, required this.onTap});
  @override
  Widget build(context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(11)),
      child: Container(
        height: wXD(47, context),
        width: wXD(116, context),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(11)),
          border: Border.all(color: grey.withOpacity(.33)),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(0, 3),
              color: Color(0x10000000),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: darkGrey,
              size: wXD(22, context),
            ),
            Text(
              text,
              style: textFamily(
                color: darkGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
