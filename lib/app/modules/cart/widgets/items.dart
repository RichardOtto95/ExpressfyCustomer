import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/cart/cart_store.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'item.dart';

class Items extends StatelessWidget {
  final MainStore mainStore = Modular.get();
  final CartStore store = Modular.get();
  Items();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            wXD(23, context),
            wXD(23, context),
            wXD(23, context),
            wXD(8, context),
          ),
          child: Text(
            'Itens adicionados',
            style: textFamily(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: textDarkGrey,
            ),
          ),
        ),
        Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainStore.cartObj.map((cartModel) {
              print('Observer: ${cartModel.toJson(cartModel)}');
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ads")
                      .doc(cartModel.adsId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: wXD(86, context),
                        width: maxWidth(context),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primary),
                        ),
                      );
                    }
                    DocumentSnapshot itemDoc = snapshot.data!;
                    return Item(
                      amount: cartModel.amount,
                      description: itemDoc['description'],
                      image: itemDoc['images'].first,
                      name: itemDoc['title'],
                      price: itemDoc['total_price'].toDouble(),
                      onAdd: () => store.addItem(cartModel.adsId),
                      onClean: () => store.cleanItem(cartModel.adsId),
                      onRemove: () => store.removeItem(cartModel.adsId),
                      onItemTap: () {
                        Modular.to.pushNamed('/product');
                      },
                    );
                  });
            }).toList(),
          );
        }),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: lightGrey.withOpacity(.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
