import 'dart:ui';

import 'package:delivery_customer/app/core/models/address_model.dart';
import 'package:delivery_customer/app/modules/address/address_page.dart';
import 'package:flutter/material.dart';

import '../color_theme.dart';
import '../utilities.dart';

class AddressPopUp extends StatelessWidget {
  final void Function() onCancel, onEdit, onDelete;
  final AddressModel model;
  const AddressPopUp(
      {Key? key,
      required this.onCancel,
      required this.onEdit,
      required this.onDelete,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: onCancel,
            child: Container(
              height: maxHeight(context),
              width: maxWidth(context),
              color: totalBlack.withOpacity(.51),
            ),
          ),
          Container(
            width: maxWidth(context),
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
                  Container(
                    width: wXD(300, context),
                    alignment: Alignment.center,
                    child: Text(
                      model.formatedAddress!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textFamily(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: textTotalBlack,
                      ),
                    ),
                  ),
                  Text(
                    '${model.neighborhood}, ${model.city} - ${model.state}',
                    style: textFamily(
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: wXD(16, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WhiteButton(
                        text: 'Excluir',
                        icon: Icons.delete_outline,
                        onTap: onDelete,
                      ),
                      SizedBox(width: wXD(21, context)),
                      WhiteButton(
                        text: 'Editar',
                        icon: Icons.edit_outlined,
                        onTap: onEdit,
                      ),
                    ],
                  ),
                  SizedBox(height: wXD(13, context)),
                  InkWell(
                    onTap: onCancel,
                    child: Text(
                      'Cancelar',
                      style: textFamily(
                        fontWeight: FontWeight.w500,
                        color: red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
