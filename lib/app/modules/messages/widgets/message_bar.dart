import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';

import 'package:flutter/material.dart';

class MessageBar extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onSend;
  final void Function()? getCameraImage;
  final void Function()? takePictures;

  MessageBar({
    Key? key,
    this.controller,
    this.focus,
    this.onChanged,
    this.onEditingComplete,
    this.onSend,
    this.getCameraImage,
    this.takePictures,
  }) : super(key: key);

  @override
  _MessageBarState createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(375, context),
      decoration: BoxDecoration(color: Color(0xfffafafa), boxShadow: [
        BoxShadow(
            offset: Offset(0, -3), color: Color(0x15000000), blurRadius: 3)
      ]),
      child: Row(
        children: [
          SizedBox(width: wXD(20, context)),
          Container(
            width: wXD(258, context),
            margin: EdgeInsets.symmetric(vertical: wXD(7, context)),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff9A9EA4).withOpacity(.7)),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: wXD(15, context),
                    top: wXD(10, context),
                    bottom: wXD(10, context),
                  ),
                  width: wXD(215, context),
                  alignment: Alignment.centerLeft,
                  child:
                      // EditableText(
                      //   cursorColor: primary,
                      //   backgroundCursorColor: totalBlack,
                      //   controller: widget.controller,
                      //   focusNode: focus,
                      //   style: textFamily(),
                      //   minLines: 1,
                      //   maxLines: 10,
                      // )
                      TextField(
                    controller: widget.controller,
                    focusNode: widget.focus,
                    scrollPadding: EdgeInsets.only(),
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditingComplete,
                    cursorColor: Color(0xff707070),
                    minLines: 1,
                    maxLines: 20,
                    style: textFamily(
                      fontSize: 15,
                      color: textBlack,
                    ),
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'Digite uma mensagem...',
                      hintStyle: textFamily(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7C8085),
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: widget.onSend,
                  child: Icon(Icons.send_outlined,
                      color: primary, size: wXD(23, context)),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(width: wXD(5, context)),
          InkWell(
            onTap: widget.getCameraImage,
            child: Container(
              height: wXD(40, context),
              width: wXD(40, context),
              child: Icon(
                Icons.camera_alt_outlined,
                color: primary,
                size: wXD(25, context),
              ),
            ),
          ),
          InkWell(
            onTap: widget.takePictures,
            child: Container(
              height: wXD(40, context),
              width: wXD(40, context),
              child: Icon(
                Icons.attachment_outlined,
                color: primary,
                size: wXD(25, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
