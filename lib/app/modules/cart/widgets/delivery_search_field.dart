import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class DeliverySearchField extends StatelessWidget {
  final void Function()? onTap;
  const DeliverySearchField({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: wXD(52, context),
          width: wXD(352, context),
          padding: EdgeInsets.symmetric(horizontal: wXD(15, context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            border: Border.all(color: Color(0xffe8e8e8), width: 2),
            color: white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x20000000),
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: wXD(25, context),
                color: primary,
              ),
              SizedBox(width: wXD(9, context)),
              Expanded(
                child: Text(
                  'Adicionar endereço',
                  style: textFamily(
                    fontSize: 14,
                    color: darkGrey.withOpacity(.56),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
