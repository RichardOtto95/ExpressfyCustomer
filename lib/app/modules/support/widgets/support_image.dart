import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupportImage extends StatefulWidget {
  final String downloadUrl;

  SupportImage({Key? key, required this.downloadUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SupportImageState();
}

class _SupportImageState extends State<SupportImage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop(widget.downloadUrl);
        return false;
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: maxHeight(context),
          width: maxWidth(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: wXD(350, context),
                height: wXD(500, context),
                color: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
