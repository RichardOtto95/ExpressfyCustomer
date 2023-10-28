import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/ads_model.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/product/product_store.dart';
import 'package:delivery_customer/app/modules/product/widgets/characteristics.dart';
import 'package:delivery_customer/app/modules/product/widgets/store_informations.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/color_theme.dart';
import 'widgets/item_data.dart';
import 'widgets/opinions.dart';

class ProductPage extends StatelessWidget {
  final MainStore mainStore = Modular.get();
  final ProductStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (mainStore.loadOverlay != null) {
          return !mainStore.loadOverlay!.mounted;
        } else {
          return store.canBack;
        }
      },
      child: Listener(
        onPointerDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: Stack(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('ads')
                    .doc(mainStore.adsId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CenterLoadCircular();
                  } else {
                    Ads model = Ads.fromDoc(snapshot.data!);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: wXD(97, context)),
                          ItemData(model: model),
                          Container(
                            margin: EdgeInsets.only(
                              top: wXD(32, context),
                              bottom: wXD(23, context),
                            ),
                            width: maxWidth(context),
                            alignment: Alignment.centerRight,
                            child: SideButton(
                              height: wXD(56, context),
                              width: wXD(208, context),
                              title: 'Adicionar ao carrinho',
                              fontSize: 16,
                              onTap: () async {
                                if (!(await mainStore.addItemToCart(
                                    model.id, context))) {
                                  // Modular.to.pop();
                                  print('Modular.to.path: ${Modular.to.path}');
                                  mainStore.setPage(1);
                                  Modular.to.pop();
                                }
                              },
                            ),
                          ),
                          Characteristics(model: model),
                          StoreInformations(
                              sellerId: model.sellerId, adsId: model.id),
                          Opinions(model: model),
                          Padding(
                            padding: EdgeInsets.only(
                                left: wXD(12, context), bottom: wXD(17, context)),
                            child: Row(
                              children: [
                                Text(
                                  'Anúncio #${model.id.substring(0, 10).toUpperCase()}',
                                  style: textFamily(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: grey,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: wXD(18, context)),
                                  height: wXD(12, context),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right:
                                              BorderSide(color: darkGrey.withOpacity(.2)))),
                                ),
                                InkWell(
                                  onTap: () => Modular.to.pushNamed("/product/report-product",
                                      arguments: model.id),
                                  child: Text(
                                    'Denunciar',
                                    style: textFamily(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              DefaultAppBar('Detalhes')
            ],
          ),
        ),
      ),
    );
  }
}
