import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final Widget? child;
  final bool isWhite;
  final bool isRight;
  final void Function() onTap;
  final String title;
  final Color? color;

  const SideButton({
    Key? key,
    this.width,
    required this.onTap,
    this.title = '',
    this.height,
    this.child,
    this.isWhite = false,
    this.fontSize,
    this.color,
    this.isRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isWhite ? Alignment.centerLeft : Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width ?? wXD(81, context),
          height: height ?? wXD(44, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(isWhite
                  ? isRight
                      ? 50
                      : 0
                  : 50),
              right: Radius.circular(isWhite
                  ? isRight
                      ? 0
                      : 50
                  : 0),
            ),
            border: Border.all(
              color: color ?? primary,
            ),
            color: color ?? primary,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 3),
                color: isWhite ? Color(0x80000000) : Color(0x30000000),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: child == null
              ? Text(
                  title,
                  style: textFamily(
                    color: !isWhite ? white : darkBlue,
                    fontSize: fontSize ?? 18,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
