import 'package:delivery_customer/app/core/models/address_model.dart';
import 'package:delivery_customer/app/modules/address/address_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color_theme.dart';
import '../utilities.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel model;
  final void Function()? iconTap;

  AddressWidget({Key? key, this.iconTap, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddressStore store = Modular.get();
    return GestureDetector(
      onTap: () {
        if (!model.main!) store.setMainAddress(model.id!);
      },
      child: Container(
        // height: wXD(162, context),
        width: maxWidth(context),

        padding: EdgeInsets.fromLTRB(
          0,
          wXD(11, context),
          wXD(17, context),
          wXD(11, context),
        ),
        margin: EdgeInsets.only(
          top: wXD(24, context),
          right: wXD(9, context),
          left: wXD(9, context),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color:
                  model.main! ? primary.withOpacity(.32) : grey.withOpacity(.1),
              width: wXD(2, context)),
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(0, 2),
              color: Color(0x20000000),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Column(
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
                          model.addressName!,
                          style: textFamily(fontSize: 15),
                        ),
                      ),
                      Spacer(),
                      model.main!
                          ? Padding(
                              padding: EdgeInsets.only(right: wXD(8, context)),
                              child: Icon(
                                Icons.check_circle,
                                color: primary,
                                size: wXD(20, context),
                              ),
                            )
                          : Container(),
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
                    SizedBox(
                      width: wXD(52, context),
                      // child: Padding(
                      //   padding: EdgeInsets.only(
                      //       left: wXD(15, context),
                      //       right: wXD(13, context),
                      //       bottom: wXD(15, context)),
                      //   child: Icon(
                      //     Icons.home_outlined,
                      //     color: grey.withOpacity(.5),
                      //     size: wXD(24, context),
                      //   ),
                      // ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: wXD(200, context),
                          child: Text(
                            model.formatedAddress!,
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
                            model.addressComplement ?? "",
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
            Positioned(
              left: wXD(15, context),
              child: model.main!
                  ? Icon(
                      Icons.home_outlined,
                      color: grey.withOpacity(.5),
                      size: wXD(24, context),
                    )
                  : SvgPicture.asset(
                      "./assets/svg/recent.svg",
                      height: wXD(18, context),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
