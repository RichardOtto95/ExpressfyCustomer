import 'dart:ui';

import 'package:delivery_customer/app/modules/cart/widgets/delivery_search_field.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cart_store.dart';

class DeliveryAddress extends StatelessWidget {
  final CartStore cartStore = Modular.get();

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async {
        if (cartStore.overlayEntry.mounted) {
          cartStore.overlayEntry.remove();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: backgroundGrey,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: wXD(101, context)),
                  DeliverySearchField(),
                  UseCurrentLocalization(),
                  // Address(),
                  // RecentAddress(
                  //   iconTap: () {
                  //     Overlay.of(context)?.insert(cartStore.overlayEntry);
                  //   },
                  // ),
                ],
              ),
            ),
            DefaultAppBar('Endereço de entrega'),
          ],
        ),
      ),
    );
  }
}

class UseCurrentLocalization extends StatelessWidget {
  const UseCurrentLocalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      padding: EdgeInsets.only(
          left: wXD(27, context),
          top: wXD(34, context),
          bottom: wXD(24, context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.my_location,
            size: wXD(20, context),
            color: grey.withOpacity(.5),
          ),
          SizedBox(width: wXD(12, context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usar localização atual',
                style: textFamily(
                  fontSize: 15,
                  color: textDarkBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: wXD(225, context),
                child: Text(
                  'St. Hab. Vicente Pires Chácara 26 - Taguatinga, Brasília - DF ',
                  style: textFamily(
                    fontSize: 13,
                    color: grey.withOpacity(.55),
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

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

class AddressPopUp extends StatelessWidget {
  final void Function() onCancel, onEdit, onDelete;
  const AddressPopUp(
      {Key? key,
      required this.onCancel,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: GestureDetector(
        onTap: onCancel,
        child: Container(
          height: maxHeight(context),
          width: maxWidth(context),
          color: totalBlack.withOpacity(.51),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: wXD(164, context),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(56)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, -5),
                  color: Color(0x70000000),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Material(
              borderRadius: BorderRadius.vertical(top: Radius.circular(56)),
              color: white,
              child: Column(
                children: [
                  SizedBox(height: wXD(16, context)),
                  Text(
                    'St. Hab. Vicente Pires, 25',
                    style: textFamily(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: textTotalBlack,
                    ),
                  ),
                  Text(
                    'Brasília, Brasília - DF',
                    style: textFamily(
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: wXD(16, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WhiteButton(text: 'Excluir', icon: Icons.delete_outline),
                      SizedBox(width: wXD(21, context)),
                      WhiteButton(text: 'Editar', icon: Icons.edit_outlined),
                    ],
                  ),
                  SizedBox(height: wXD(13, context)),
                  Text(
                    'Cancelar',
                    style: textFamily(
                      fontWeight: FontWeight.w500,
                      color: red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final IconData icon;
  final String text;
  WhiteButton({required this.icon, required this.text});
  @override
  Widget build(context) {
    return Container(
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
    );
  }
}
