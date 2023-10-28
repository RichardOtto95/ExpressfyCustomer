import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key, required this.title})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
        ThemeData.estimateBrightnessForColor(Color.fromRGBO(255, 244, 228, 1)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48))),
      ),
    );
  }
}
