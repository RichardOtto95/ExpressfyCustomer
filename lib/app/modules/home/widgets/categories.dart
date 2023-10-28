import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/home/home_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48)),
      child: SizedBox(
        height: wXD(40, context),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("categories")
                .orderBy("created_at")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primary),
                );
              }
              final catQue = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  wXD(24, context),
                  0,
                  wXD(10, context),
                  wXD(6, context),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: catQue!.docs.length,
                itemBuilder: (context, index) {
                  return Observer(builder: (context) {
                    return Categorie(
                      title: catQue.docs[index]["label"],
                      onTap: () {
                        if(store.categorySelected != catQue.docs[index]["label"]){
                          store.categorySelected = catQue.docs[index]["label"];
                        } else {
                          store.categorySelected = null;
                        }
                      },
                      selected: store.categorySelected ==
                          catQue.docs[index]["label"],
                    );
                  });
                },
              );
            }),
      ),
    );
  }
}

class Categorie extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final bool selected;
  Categorie(
      {Key? key,
      required this.title,
      required this.onTap,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: wXD(90, context),
        height: wXD(10, context),
        margin: EdgeInsets.symmetric(horizontal: wXD(4, context)),
        padding: EdgeInsets.symmetric(horizontal: wXD(4, context)),
        decoration: BoxDecoration(
          color: selected ? white : totalBlack,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightGrey),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: textFamily(color: selected ? textBlack : white),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }
}
