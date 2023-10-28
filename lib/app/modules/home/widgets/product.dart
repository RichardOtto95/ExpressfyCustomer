import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_customer/app/core/models/ads_model.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Product extends StatelessWidget {
  final MainStore mainStore = Modular.get();
  final Ads ads;
  Product({required this.ads});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mainStore.setAdsId(ads.id);
        Modular.to.pushNamed('/product');
      },
      child: Container(
        width: wXD(175, context),
        height: wXD(235, context),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: wXD(175, context),
              width: wXD(175, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: ads.images.first,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wXD(7, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: wXD(3, context)),
                  Text(
                    ads.title,
                    style: textFamily(
                      fontSize: 15,
                      color: textBlack,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "R\$ ${formatedCurrency(ads.totalPrice)}",
                    style:
                        textFamily(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
