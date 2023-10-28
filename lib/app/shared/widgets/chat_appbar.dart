import 'package:delivery_customer/app/modules/cart/cart_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:flutter_modular/flutter_modular.dart';

class CartAppbar extends StatelessWidget {
  final CartStore store = Modular.get();
  SystemUiOverlayStyle _systemOverlayStyleForBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light)
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle overlayStyle = _systemOverlayStyleForBrightness(
        ThemeData.estimateBrightnessForColor(Color(0xffffffff)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        height: wXD(85, context),
        width: maxWidth(context),
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(48),
          ),
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x30000000),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: wXD(30, context)),
                alignment: Alignment.centerLeft,
                child: Transform.rotate(
                  angle: math.pi * -.5,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: wXD(25, context),
                    color: primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Carrinho',
                  style: TextStyle(
                    color: textBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: wXD(16, context)),
                child: InkWell(
                  onTap: () => store.cleanItems(),
                  child: Text(
                    'Limpar',
                    style: TextStyle(
                      color: primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
