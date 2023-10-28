import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/cart_model.dart';
import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/load_circular_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/models/customer_model.dart';
part 'main_store.g.dart';

class MainStore = _MainStoreBase with _$MainStore;

abstract class _MainStoreBase with Store implements Disposable {
  final AuthStore authStore = Modular.get();

  _MainStoreBase() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        customerSubscription?.cancel();
        customer = null;
      } else {
        customerSubscription = FirebaseFirestore.instance
            .collection("customers")
            .doc(user.uid)
            .snapshots()
            .listen((event) {
          print("Stream do customer");
          if (event.exists) {
            customer = Customer.fromDoc(event);
          }
        });
      }
    });
  }

  @observable
  PageController pageController = PageController(initialPage: 0);
  @observable
  int page = 0;
  @observable
  bool visibleNav = true;
  @observable
  String adsId = '';
  @observable
  ObservableList<String> cartObjId = ObservableList<String>();
  @observable
  ObservableList<CartModel> cartObj = ObservableList<CartModel>();
  @observable
  String cartSellerId = '';
  @observable
  OverlayEntry? loadOverlay;
  @observable
  OverlayEntry? globalOverlay;
  @observable
  StreamSubscription? customerSubscription;
  @observable
  Customer? customer;

  @action
  setAdsId(_adsId) => adsId = _adsId;
  @action
  setVisibleNav(_visibleNav) => visibleNav = _visibleNav;

  @override
  void dispose() {
    pageController.removeListener(() {});
    pageController.dispose();
    if (customerSubscription != null) customerSubscription!.cancel();
  }

  @action
  Future<bool> addItemToCart(String adsId, BuildContext context) async {
    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(loadOverlay!);

    DocumentSnapshot adsDoc =
        await FirebaseFirestore.instance.collection('ads').doc(adsId).get();
    if (cartSellerId != '') {
      if (cartSellerId != adsDoc['seller_id']) {
        cartObj.clear();
        cartObjId.clear();
        cartSellerId = adsDoc['seller_id'];
      }
    } else {
      cartSellerId = adsDoc['seller_id'];
    }

    String message = '';
    if (cartObjId.contains(adsId)) {
      message = 'Você já adicionou este produto ao carrinho';
    } else {
      cartObjId.add(adsId);
      cartObj.add(CartModel(
          adsId: adsId,
          amount: 1,
          value: adsDoc['total_price'],
          rating: 0,
          rated: false,
          sellerId: adsDoc["seller_id"]));
      message = 'Produto adicionado ao carrinho';
    }

    showToast(message);
    loadOverlay!.remove();
    return !cartObjId.contains(adsId);
  }

  createCoupon() async {
    User? _user = FirebaseAuth.instance.currentUser;
    QuerySnapshot<Map<String, dynamic>> qq = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user!.uid)
        .collection('active_coupons')
        .get();
    DocumentSnapshot<Map<String, dynamic>> ds = qq.docs.first;
    DocumentReference dr = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user.uid)
        .collection('active_coupons')
        .add(ds.data()!);

    await dr.update({
      'id': dr.id,
      'type': 'PRICE_OFF',
      'discount': 10,
      'percent_off': 0,
      'user_id': null,
      'actived': false,
      'code': dr.id.substring(0, 8)
    });
  }

  @action
  setPage(_page) async {
    await pageController.animateToPage(
      _page,
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    page = _page;
  }

  @action
  Future<void> saveTokenToDatabase(String token) async {
    User? _user = FirebaseAuth.instance.currentUser;
    print('saveTokenToDatabase: $_user');

    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(_user.uid)
          .update({
        'token_id': FieldValue.arrayUnion([token]),
      });
    }
  }
}
