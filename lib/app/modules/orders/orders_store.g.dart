// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on _OrdersStoreBase, Store {
  final _$viewableOrderStatusAtom =
      Atom(name: '_OrdersStoreBase.viewableOrderStatus');

  @override
  List<String> get viewableOrderStatus {
    _$viewableOrderStatusAtom.reportRead();
    return super.viewableOrderStatus;
  }

  @override
  set viewableOrderStatus(List<String> value) {
    _$viewableOrderStatusAtom.reportWrite(value, super.viewableOrderStatus, () {
      super.viewableOrderStatus = value;
    });
  }

  final _$canBackAtom = Atom(name: '_OrdersStoreBase.canBack');

  @override
  bool get canBack {
    _$canBackAtom.reportRead();
    return super.canBack;
  }

  @override
  set canBack(bool value) {
    _$canBackAtom.reportWrite(value, super.canBack, () {
      super.canBack = value;
    });
  }

  final _$adsIdAtom = Atom(name: '_OrdersStoreBase.adsId');

  @override
  String? get adsId {
    _$adsIdAtom.reportRead();
    return super.adsId;
  }

  @override
  set adsId(String? value) {
    _$adsIdAtom.reportWrite(value, super.adsId, () {
      super.adsId = value;
    });
  }

  final _$deliveryForecastAtom =
      Atom(name: '_OrdersStoreBase.deliveryForecast');

  @override
  String? get deliveryForecast {
    _$deliveryForecastAtom.reportRead();
    return super.deliveryForecast;
  }

  @override
  set deliveryForecast(String? value) {
    _$deliveryForecastAtom.reportWrite(value, super.deliveryForecast, () {
      super.deliveryForecast = value;
    });
  }

  final _$deliveryForecastLabelAtom =
      Atom(name: '_OrdersStoreBase.deliveryForecastLabel');

  @override
  String get deliveryForecastLabel {
    _$deliveryForecastLabelAtom.reportRead();
    return super.deliveryForecastLabel;
  }

  @override
  set deliveryForecastLabel(String value) {
    _$deliveryForecastLabelAtom.reportWrite(value, super.deliveryForecastLabel,
        () {
      super.deliveryForecastLabel = value;
    });
  }

  final _$loadOverlayEvaluationAtom =
      Atom(name: '_OrdersStoreBase.loadOverlayEvaluation');

  @override
  OverlayEntry? get loadOverlayEvaluation {
    _$loadOverlayEvaluationAtom.reportRead();
    return super.loadOverlayEvaluation;
  }

  @override
  set loadOverlayEvaluation(OverlayEntry? value) {
    _$loadOverlayEvaluationAtom.reportWrite(value, super.loadOverlayEvaluation,
        () {
      super.loadOverlayEvaluation = value;
    });
  }

  final _$polyPointsAtom = Atom(name: '_OrdersStoreBase.polyPoints');

  @override
  List<MapLatLng> get polyPoints {
    _$polyPointsAtom.reportRead();
    return super.polyPoints;
  }

  @override
  set polyPoints(List<MapLatLng> value) {
    _$polyPointsAtom.reportWrite(value, super.polyPoints, () {
      super.polyPoints = value;
    });
  }

  final _$mapTileLayerControllerAtom =
      Atom(name: '_OrdersStoreBase.mapTileLayerController');

  @override
  MapTileLayerController? get mapTileLayerController {
    _$mapTileLayerControllerAtom.reportRead();
    return super.mapTileLayerController;
  }

  @override
  set mapTileLayerController(MapTileLayerController? value) {
    _$mapTileLayerControllerAtom
        .reportWrite(value, super.mapTileLayerController, () {
      super.mapTileLayerController = value;
    });
  }

  final _$zoomPanBehaviorAtom = Atom(name: '_OrdersStoreBase.zoomPanBehavior');

  @override
  MapZoomPanBehavior? get zoomPanBehavior {
    _$zoomPanBehaviorAtom.reportRead();
    return super.zoomPanBehavior;
  }

  @override
  set zoomPanBehavior(MapZoomPanBehavior? value) {
    _$zoomPanBehaviorAtom.reportWrite(value, super.zoomPanBehavior, () {
      super.zoomPanBehavior = value;
    });
  }

  final _$mapMarkersListAtom = Atom(name: '_OrdersStoreBase.mapMarkersList');

  @override
  ObservableList<MapMarker> get mapMarkersList {
    _$mapMarkersListAtom.reportRead();
    return super.mapMarkersList;
  }

  @override
  set mapMarkersList(ObservableList<MapMarker> value) {
    _$mapMarkersListAtom.reportWrite(value, super.mapMarkersList, () {
      super.mapMarkersList = value;
    });
  }

  final _$destinationAddressAtom =
      Atom(name: '_OrdersStoreBase.destinationAddress');

  @override
  AddressModel? get destinationAddress {
    _$destinationAddressAtom.reportRead();
    return super.destinationAddress;
  }

  @override
  set destinationAddress(AddressModel? value) {
    _$destinationAddressAtom.reportWrite(value, super.destinationAddress, () {
      super.destinationAddress = value;
    });
  }

  final _$infoAtom = Atom(name: '_OrdersStoreBase.info');

  @override
  Directions? get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(Directions? value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  final _$agentListenAtom = Atom(name: '_OrdersStoreBase.agentListen');

  @override
  StreamSubscription<DocumentSnapshot<Object?>>? get agentListen {
    _$agentListenAtom.reportRead();
    return super.agentListen;
  }

  @override
  set agentListen(StreamSubscription<DocumentSnapshot<Object?>>? value) {
    _$agentListenAtom.reportWrite(value, super.agentListen, () {
      super.agentListen = value;
    });
  }

  final _$stepsAtom = Atom(name: '_OrdersStoreBase.steps');

  @override
  ObservableList<dynamic> get steps {
    _$stepsAtom.reportRead();
    return super.steps;
  }

  @override
  set steps(ObservableList<dynamic> value) {
    _$stepsAtom.reportWrite(value, super.steps, () {
      super.steps = value;
    });
  }

  final _$overlayCancelAtom = Atom(name: '_OrdersStoreBase.overlayCancel');

  @override
  OverlayEntry? get overlayCancel {
    _$overlayCancelAtom.reportRead();
    return super.overlayCancel;
  }

  @override
  set overlayCancel(OverlayEntry? value) {
    _$overlayCancelAtom.reportWrite(value, super.overlayCancel, () {
      super.overlayCancel = value;
    });
  }

  final _$getRouteAsyncAction = AsyncAction('_OrdersStoreBase.getRoute');

  @override
  Future<Map<String, dynamic>> getRoute(String orderId, dynamic context) {
    return _$getRouteAsyncAction.run(() => super.getRoute(orderId, context));
  }

  final _$evaluateAsyncAction = AsyncAction('_OrdersStoreBase.evaluate');

  @override
  Future<dynamic> evaluate(Map<String, dynamic> ratings, BuildContext context) {
    return _$evaluateAsyncAction.run(() => super.evaluate(ratings, context));
  }

  final _$cancelOrderAsyncAction = AsyncAction('_OrdersStoreBase.cancelOrder');

  @override
  Future<void> cancelOrder(
      dynamic context, DocumentSnapshot<Object?> orderDoc) {
    return _$cancelOrderAsyncAction
        .run(() => super.cancelOrder(context, orderDoc));
  }

  final _$_OrdersStoreBaseActionController =
      ActionController(name: '_OrdersStoreBase');

  @override
  void sendMessage(DocumentSnapshot<Object?> orderDoc) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.sendMessage');
    try {
      return super.sendMessage(orderDoc);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearShippingDetails() {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.clearShippingDetails');
    try {
      return super.clearShippingDetails();
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewableOrderStatus: ${viewableOrderStatus},
canBack: ${canBack},
adsId: ${adsId},
deliveryForecast: ${deliveryForecast},
deliveryForecastLabel: ${deliveryForecastLabel},
loadOverlayEvaluation: ${loadOverlayEvaluation},
polyPoints: ${polyPoints},
mapTileLayerController: ${mapTileLayerController},
zoomPanBehavior: ${zoomPanBehavior},
mapMarkersList: ${mapMarkersList},
destinationAddress: ${destinationAddress},
info: ${info},
agentListen: ${agentListen},
steps: ${steps},
overlayCancel: ${overlayCancel}
    ''';
  }
}
