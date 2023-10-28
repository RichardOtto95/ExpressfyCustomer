import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final bool noPop;
  final void Function()? onPop;
  DefaultAppBar(this.title, {this.onPop, this.noPop = false});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(white),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: maxWidth(context),
            height: wXD(73, context),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48)),
              color: white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x30000000),
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          noPop
              ? Container()
              : Positioned(
                  bottom: 0,
                  left: wXD(20, context),
                  child: InkWell(
                    onTap: () {
                      if (onPop != null) {
                        onPop!();
                      } else {
                        Modular.to.pop();
                      }
                    },
                    child: Container(
                      height: wXD(36, context),
                      width: wXD(48, context),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "./assets/svg/arrow_backward.svg",
                        height: wXD(11, context),
                        width: wXD(20, context),
                      ),
                    ),
                  ),
                ),
          Positioned(
            bottom: wXD(9, context),
            child: Text(
              title,
              style: TextStyle(
                color: textBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
