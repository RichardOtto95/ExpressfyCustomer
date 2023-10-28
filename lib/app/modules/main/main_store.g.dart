// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStoreBase, Store {
  final _$pageControllerAtom = Atom(name: '_MainStoreBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$pageAtom = Atom(name: '_MainStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$visibleNavAtom = Atom(name: '_MainStoreBase.visibleNav');

  @override
  bool get visibleNav {
    _$visibleNavAtom.reportRead();
    return super.visibleNav;
  }

  @override
  set visibleNav(bool value) {
    _$visibleNavAtom.reportWrite(value, super.visibleNav, () {
      super.visibleNav = value;
    });
  }

  final _$adsIdAtom = Atom(name: '_MainStoreBase.adsId');

  @override
  String get adsId {
    _$adsIdAtom.reportRead();
    return super.adsId;
  }

  @override
  set adsId(String value) {
    _$adsIdAtom.reportWrite(value, super.adsId, () {
      super.adsId = value;
    });
  }

  final _$cartObjIdAtom = Atom(name: '_MainStoreBase.cartObjId');

  @override
  ObservableList<String> get cartObjId {
    _$cartObjIdAtom.reportRead();
    return super.cartObjId;
  }

  @override
  set cartObjId(ObservableList<String> value) {
    _$cartObjIdAtom.reportWrite(value, super.cartObjId, () {
      super.cartObjId = value;
    });
  }

  final _$cartObjAtom = Atom(name: '_MainStoreBase.cartObj');

  @override
  ObservableList<CartModel> get cartObj {
    _$cartObjAtom.reportRead();
    return super.cartObj;
  }

  @override
  set cartObj(ObservableList<CartModel> value) {
    _$cartObjAtom.reportWrite(value, super.cartObj, () {
      super.cartObj = value;
    });
  }

  final _$cartSellerIdAtom = Atom(name: '_MainStoreBase.cartSellerId');

  @override
  String get cartSellerId {
    _$cartSellerIdAtom.reportRead();
    return super.cartSellerId;
  }

  @override
  set cartSellerId(String value) {
    _$cartSellerIdAtom.reportWrite(value, super.cartSellerId, () {
      super.cartSellerId = value;
    });
  }

  final _$loadOverlayAtom = Atom(name: '_MainStoreBase.loadOverlay');

  @override
  OverlayEntry? get loadOverlay {
    _$loadOverlayAtom.reportRead();
    return super.loadOverlay;
  }

  @override
  set loadOverlay(OverlayEntry? value) {
    _$loadOverlayAtom.reportWrite(value, super.loadOverlay, () {
      super.loadOverlay = value;
    });
  }

  final _$globalOverlayAtom = Atom(name: '_MainStoreBase.globalOverlay');

  @override
  OverlayEntry? get globalOverlay {
    _$globalOverlayAtom.reportRead();
    return super.globalOverlay;
  }

  @override
  set globalOverlay(OverlayEntry? value) {
    _$globalOverlayAtom.reportWrite(value, super.globalOverlay, () {
      super.globalOverlay = value;
    });
  }

  final _$customerSubscriptionAtom =
      Atom(name: '_MainStoreBase.customerSubscription');

  @override
  StreamSubscription<dynamic>? get customerSubscription {
    _$customerSubscriptionAtom.reportRead();
    return super.customerSubscription;
  }

  @override
  set customerSubscription(StreamSubscription<dynamic>? value) {
    _$customerSubscriptionAtom.reportWrite(value, super.customerSubscription,
        () {
      super.customerSubscription = value;
    });
  }

  final _$customerAtom = Atom(name: '_MainStoreBase.customer');

  @override
  Customer? get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(Customer? value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  final _$addItemToCartAsyncAction =
      AsyncAction('_MainStoreBase.addItemToCart');

  @override
  Future<bool> addItemToCart(String adsId, BuildContext context) {
    return _$addItemToCartAsyncAction
        .run(() => super.addItemToCart(adsId, context));
  }

  final _$setPageAsyncAction = AsyncAction('_MainStoreBase.setPage');

  @override
  Future setPage(dynamic _page) {
    return _$setPageAsyncAction.run(() => super.setPage(_page));
  }

  final _$saveTokenToDatabaseAsyncAction =
      AsyncAction('_MainStoreBase.saveTokenToDatabase');

  @override
  Future<void> saveTokenToDatabase(String token) {
    return _$saveTokenToDatabaseAsyncAction
        .run(() => super.saveTokenToDatabase(token));
  }

  final _$_MainStoreBaseActionController =
      ActionController(name: '_MainStoreBase');

  @override
  dynamic setAdsId(dynamic _adsId) {
    final _$actionInfo = _$_MainStoreBaseActionController.startAction(
        name: '_MainStoreBase.setAdsId');
    try {
      return super.setAdsId(_adsId);
    } finally {
      _$_MainStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVisibleNav(dynamic _visibleNav) {
    final _$actionInfo = _$_MainStoreBaseActionController.startAction(
        name: '_MainStoreBase.setVisibleNav');
    try {
      return super.setVisibleNav(_visibleNav);
    } finally {
      _$_MainStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
page: ${page},
visibleNav: ${visibleNav},
adsId: ${adsId},
cartObjId: ${cartObjId},
cartObj: ${cartObj},
cartSellerId: ${cartSellerId},
loadOverlay: ${loadOverlay},
globalOverlay: ${globalOverlay},
customerSubscription: ${customerSubscription},
customer: ${customer}
    ''';
  }
}
