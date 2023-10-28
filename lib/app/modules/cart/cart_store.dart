import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/cart_model.dart';
import 'package:delivery_customer/app/core/models/order_model.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/load_circular_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mobx/mobx.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../core/models/address_model.dart';
import '../../core/models/email.dart';
import 'widgets/delivery_address.dart';
import 'package:url_launcher/url_launcher.dart';
part 'cart_store.g.dart';

class CartStore = _CartStoreBase with _$CartStore;

abstract class _CartStoreBase with Store {
  final MainStore mainStore = Modular.get();
  // @observable
  // double freight = 54.0;
  @observable
  int seconstToFinalize = 0;
  @observable
  String? addressId;
  @observable
  bool canBack = true;
  @observable
  ObservableList cartList = [].asObservable();
  @observable
  OverlayEntry? loadOverlay;
  @observable
  String deliveryType = 'express';
  @observable
  int val = 1;
  @observable
  num totalPrice = 0;
  @observable
  num deliveryPrice = 0;
  @observable
  String promotionalCode = '';
  @observable
  num totalPriceWithDiscount = 0;
  @observable
  TextEditingController textEditingController = TextEditingController();
  @observable
  OverlayEntry? redirectOverlay;
  @observable
  num change = 0;
  @observable
  String paymentMethod = 'Saldo em conta';
  // @observable
  // int cardIndex = 0;
  // @observable
  // String cardId = '';
  // @observable
  // String finalNumberCard = '';
  // @observable
  // String flagCard = '';
  // @observable
  // Marker? marker;

  // @observable
  // int installmentCount = 1;
  // @observable
  // List<dynamic> availablePlansList = ["Nenhum"];

  @observable
  late OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => AddressPopUp(
      onCancel: () => overlayEntry.remove(),
      onEdit: () {},
      onDelete: () {},
    ),
  );

  @action
  setOverlayEntry(_overlayEntry) => overlayEntry = _overlayEntry;

  @action
  String foreCast() {
    if (deliveryType == 'express') {
      DateTime dateTimeNow = DateTime.now().toUtc();

      int hourInt = dateTimeNow.hour;
      int twoHoursLater = hourInt + 2;

      if (hourInt == 22) {
        twoHoursLater = 0;
      }

      if (hourInt == 23) {
        twoHoursLater = 1;
      }

      if (hourInt == 24) {
        twoHoursLater = 2;
      }

      String hour = hourInt.toString().padLeft(2, '0');
      String minute = dateTimeNow.minute.toString().padLeft(2, '0');
      String twoHoursLaterString = twoHoursLater.toString().padLeft(2, '0');
      return hour + ':' + minute + ' - ' + twoHoursLaterString + ':' + minute;
    } else {
      return 'Em até 8 dias úteis';
    }
  }

  @action
  assembleList() {
    mainStore.cartObj.forEach((CartModel element) {
      print('assembleList: ${element.toJson(element)}');
      cartList.add(element.adsId);
    });
  }

  @action
  void cleanItems() {
    mainStore.cartSellerId = '';
    mainStore.cartObj.clear();
    mainStore.cartObjId.clear();
    cartList.clear();
    totalPrice = 0;
    deliveryPrice = 0;
    change = 0;
    // cardId = '';
    // finalNumberCard = '';
    // flagCard = '';
  }

  @action
  void cleanItem(String id) {
    CartModel? removeElement;
    mainStore.cartObj.forEach((element) {
      print('cleanItem: ${element.toJson(element)} - $id');
      if (id == element.adsId) {
        removeElement = element;
      }
    });

    mainStore.cartObj.remove(removeElement);
    mainStore.cartObjId.remove(id);
    cartList.remove(id);
    if (cartList.length == 0) {
      mainStore.cartSellerId = '';
    }
  }

  @action
  void addItem(String id) {
    for (var i = 0; i < cartList.length; i++) {
      CartModel cartModel = mainStore.cartObj[i];

      if (cartModel.adsId == id) {
        CartModel newCartModel = CartModel(
          adsId: id,
          amount: cartModel.amount + 1,
          value: cartModel.value,
          rating: 0,
          rated: false,
          sellerId: cartModel.sellerId,
        );

        mainStore.cartObj[i] = newCartModel;
      }
    }
  }

  @action
  void removeItem(String id) {
    for (var i = 0; i < cartList.length; i++) {
      CartModel cartModel = mainStore.cartObj[i];

      if (cartModel.adsId == id) {
        int itemAmount = cartModel.amount;

        if (itemAmount == 1) {
          cleanItem(id);
        } else {
          CartModel newCartModel = CartModel(
            adsId: id,
            amount: cartModel.amount - 1,
            value: cartModel.value,
            rating: 0,
            rated: false,
            sellerId: cartModel.sellerId,
          );

          mainStore.cartObj[i] = newCartModel;
        }
      }
    }
  }

  @action
  Future<List<num>> getSubTotal() async {
    final User? _user = FirebaseAuth.instance.currentUser;
    num subTotal = 0;
    // num priceShipping = deliveryType == 'express' ? 54 : 48;
    num priceShipping = 0;
    num priceTotal = 0;
    num newPriceTotal = 0;
    num discount = 0;

    for (CartModel cartModel in mainStore.cartObj) {
      subTotal += cartModel.value * cartModel.amount;
    }

    priceTotal = subTotal + priceShipping;

    QuerySnapshot activedCoupons = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user!.uid)
        .collection('active_coupons')
        .where('actived', isEqualTo: true)
        .where('used', isEqualTo: false)
        .where('status', isEqualTo: "VALID")
        .orderBy('created_at', descending: true)
        .get();

    if (activedCoupons.docs.isNotEmpty) {
      DocumentSnapshot couponDoc = activedCoupons.docs.first;
      bool hasValueMinimum = couponDoc['value_minimum'] != null && couponDoc['value_minimum'] != 0;
      print("hasValueMinimum: $hasValueMinimum");
      print("couponDoc['value_minimum']: ${couponDoc['value_minimum']} - priceTotal: $priceTotal");

      if(!hasValueMinimum || (hasValueMinimum && couponDoc['value_minimum'] < priceTotal)){
        if (couponDoc['percent_off'] != null) {
          num percentOff = couponDoc['percent_off'];
          discount = priceTotal * percentOff;
          newPriceTotal = priceTotal - discount;
          newPriceTotal = num.parse(newPriceTotal.toStringAsFixed(2));
          print('percentOff: $percentOff');
          print('subTotal: $subTotal');
          print('priceTotal: $priceTotal');
          print('discount: ${priceTotal * percentOff}');
          print('newPriceTotal: $newPriceTotal');
        } else {
          discount = couponDoc['discount'];
          newPriceTotal = priceTotal - couponDoc['discount'];
          if(newPriceTotal < 0){
            newPriceTotal = 0;
          }
          print('priceTotal: $priceTotal');
          print('discount and newPriceTotal: $discount - $newPriceTotal');
        }
      }
    } else {
      newPriceTotal = priceTotal;
    }

    totalPrice = priceTotal;
    deliveryPrice = priceShipping;
    totalPriceWithDiscount = newPriceTotal;

    return [subTotal, priceShipping, priceTotal, discount, newPriceTotal];
  }

  @action
  Future<void> validations(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    canBack = false;
    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(loadOverlay!);

    final sellerId = mainStore.cartObj.first.sellerId;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('customers')
        .doc(currentUser!.uid)
        .get();

    if (!(await FirebaseFirestore.instance
            .collection("sellers")
            .doc(sellerId)
            .get())
        .get("online")) {
      showToast("Este vendedor não está online");
      loadOverlay!.remove();
      canBack = true;
      return;
    }

    if (userDoc.get("main_address") == null) {
      showToast("Você precisa de um endereço para continuar");
      loadOverlay!.remove();
      canBack = true;
      return;
    }

    print('paymentMethod: $paymentMethod');
    if (paymentMethod == 'Saldo em conta') {
      List<num> listPrice = await getSubTotal();
      num price = listPrice.last;
      if (price > userDoc['account_balance']) {
        showToast("Saldo em conta insuficiente");
        loadOverlay!.remove();
        canBack = true;
        return;
      }
    }

    // QuerySnapshot cards = await userDoc
    //     .collection('cards')
    //     .where('status', isEqualTo: 'ACTIVE')
    //     .get();

    // if (cards.docs.length > 0 || paymentMethod == 'Dinheiro') {
    loadOverlay!.remove();
    loadOverlay = null;
    await Modular.to.pushNamed('/cart/finalizing');
    // } else {
    //   loadOverlay!.remove();
    //   loadOverlay = null;
    //   redirectOverlay = OverlayEntry(
    //     builder: (context) => RedirectPopup(
    //       height: wXD(140, context),
    //       text: 'Você ainda não tem cartão, deseja adicionar um?',
    //       onConfirm: () async {
    //         redirectOverlay!.remove();

    //         await Modular.to.pushNamed("/add-card");
    //       },
    //       onCancel: () {
    //         redirectOverlay!.remove();
    //       },
    //     ),
    //   );

    //   Overlay.of(context)?.insert(redirectOverlay!);
    // }
    canBack = true;
  }

  @action
  Future finalizeOrder(context) async {
    canBack = false;
    print('finalizeOrder: $change');
    final User? _user = FirebaseAuth.instance.currentUser;

    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());

    Overlay.of(context)!.insert(loadOverlay!);

    List<Object> newList = [];
    int totalAmount = 0;

    for (CartModel cartModel in mainStore.cartObj) {
      newList.add(cartModel.toJson(cartModel));
      totalAmount += cartModel.amount;
    }

    String sellerAddressId = (await FirebaseFirestore.instance
            .collection("sellers")
            .doc(mainStore.cartSellerId)
            .get())
        .get("main_address");

    QuerySnapshot activedCoupons = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user!.uid)
        .collection('active_coupons')
        .where('actived', isEqualTo: true)
        .where('used', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .get();

    String? couponId;
    if (activedCoupons.docs.isNotEmpty) {
      DocumentSnapshot couponDoc = activedCoupons.docs.first;
      couponId = couponDoc.id;
    }

    // print('finalize order card id: $cardId');

    var response = await cloudFunction(function: "finalizeOrder", object: {
      "deliveryType": deliveryType,
      "sellerId": mainStore.cartSellerId,
      "items": newList,
      "price": {
        "deliveryPrice": deliveryPrice,
        "totalPrice": totalPrice,
        "totalPriceWithDiscount": totalPriceWithDiscount,
      },
      "userId": mainStore.authStore.user!.uid,
      "paymentMethod": getPaymentMethod(),
      "cardId": null,
      "order": Order(
        sellerAdderessId: sellerAddressId,
        customerAdderessId: addressId,
        customerId: mainStore.authStore.user!.uid,
        discontinuedBy: null,
        discontinuedReason: null,
        endDate: null,
        startDate: null,
        customerToken: getRandomString(6),
        agentToken: getRandomString(6),
        couponId: couponId,
        change: change,
        totalAmount: totalAmount,
        sellerId: mainStore.cartSellerId,
        priceTotal: totalPrice,
        priceRateDelivery: deliveryPrice,
        priceTotalWithDiscount: totalPriceWithDiscount,
        paid: getPaymentMethod() == "ACCOUNT-BALANCE",
      ).toJson()
    });

    print('xxxxxxxxxxxxx response $response');

    if (response['code'] != 'success') {
      if (response['code'] == 'account-balance-insuficient') {
        showToast('Saldo em conta insuficiente', Colors.red);
      } else {
        showToast('Falha ao tentar realizar o pagamento', Colors.red);
      }
      loadOverlay!.remove();
      loadOverlay = null;
      Modular.to.pop();
    } else {
      print('paymentMethod: $paymentMethod');
      if (paymentMethod == 'Pix') {
        await sendEmail(response['orderId']);
      }
      await setUseCoupon();
      // await Future.delayed(Duration(milliseconds: 1000));
      cleanItems();
      if (loadOverlay != null && loadOverlay!.mounted) {
        loadOverlay!.remove();
        loadOverlay = null;
      }
      Modular.to.pop();
      await mainStore.setPage(3);
    }

    canBack = true;
  }

  @action
  Future<void> sendEmail(String orderId) async {
    print('sendEmail');
    final User? _user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("customers")
        .doc(_user!.uid)
        .get();
    print('userDoc[email]: ${userDoc['email']}');
    print('userDoc[phone]: ${userDoc['phone']}');
    print('orderID: $orderId');
    DocumentSnapshot orderDoc = await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get();
    QuerySnapshot adsQuery = await orderDoc.reference.collection('ads').get();
    print('adsQuery.docs.length: ${adsQuery.docs.length}');
    QuerySnapshot infoQuery =
        await FirebaseFirestore.instance.collection("info").get();
    DocumentSnapshot infoDoc = infoQuery.docs.first;
    Email email = Email('scorefyteste@gmail.com', '1Waxzsq2!');
    // Email email = Email('mercadoexpresso@scorefy.com', '1Waxzsq2!#');

    String itens = "<h1>Itens do pedido:</h1> <ol>";
    for (var i = 0; i < adsQuery.docs.length; i++) {
      DocumentSnapshot ads = adsQuery.docs[i];
      DocumentSnapshot adsDoc =
          await FirebaseFirestore.instance.collection('ads').doc(ads.id).get();
      itens += "<li>${adsDoc['title']}</li>";
    }
    itens += "</ol>";
    print('itens: $itens');

    if (userDoc['email'] != null) {
      bool result = await email.sendMessage(
        assunto: 'Pedido pendente',
        destinatario: userDoc['email'],
        html:
            '$itens <br/> <p>${userDoc['username']} você solicitou o pedido(${orderDoc.id}) com a forma de pagamento pix.</p> <br/> <p>Para finalizar o pedido só falta o pix no valor de ${formatedCurrency(totalPriceWithDiscount)} R\$.</p> <br/> <p>Chave pix: cnpj 29.412.420/0001-67</p> <br/> <img src="${infoDoc['qrcode_pix_image']}" alt= "Qr code para o pix"/>',
      );

      print("email customer ${result ? 'Enviado.' : 'Não enviado.'}");
    } else {
      try {
        // WhatsAppUnilink link = WhatsAppUnilink(
        //   phoneNumber: userDoc['phone'],
        //   text: "Pedido pendente, efetue o pix de ${formatedCurrency(totalPriceWithDiscount)} R\$ para cnpj 29.412.420/0001-67",
        // );
        // await launch('$link');
        // await launch(infoDoc['qrcode_pix_image']);
        Fluttertoast.showToast(
          msg: "Pedido pendente, efetue o pix de ${formatedCurrency(totalPriceWithDiscount)} R\$ para o cnpj 29.412.420/0001-67",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        print('error');
        print(e);
      }
    }

    bool result2 = await email.sendMessage(
      assunto: 'Novo pedido',
      destinatario: "scorefyteste@gmail.com",
      html:
          '$itens <br/> <p>${userDoc['username']} solicitou o pedido(${orderDoc.id}) com a forma de pagamento pix.</p> <br/> <p>Para finalizar o pedido só falta o pix no valor de ${formatedCurrency(totalPriceWithDiscount)} R\$.</p> <br/> <p>Chave pix: cnpj 29.412.420/0001-67</p>',
    );

    print("email scorefy${result2 ? 'Enviado.' : 'Não enviado.'}");
  }

  @action
  String getPaymentMethod() {
    print('getPaymentMethod: $paymentMethod ');
    switch (paymentMethod) {
      case 'Cartão':
        return 'CARD';

      case 'Saldo em conta':
        return 'ACCOUNT-BALANCE';

      case 'Dinheiro':
        return 'MONEY';

      case 'Pix':
        return 'PIX';

      default:
        return '';
    }
  }

  @action
  findCoupon(BuildContext context) async {
    if (promotionalCode != '') {
      // String? _messageError;
      loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
      Overlay.of(context)!.insert(loadOverlay!);
      canBack = false;
      final User? _user = FirebaseAuth.instance.currentUser;

      QuerySnapshot activedCoupons = await FirebaseFirestore.instance
          .collection('customers')
          .doc(_user!.uid)
          .collection('active_coupons')
          .where('actived', isEqualTo: true)
          .where('used', isEqualTo: false)
          .where('status', isEqualTo: 'VALID')
          .get();

      print('activedCoupons: ${activedCoupons.docs.length}');

      if (activedCoupons.docs.isEmpty) {
        QuerySnapshot findCouponsQuery = await FirebaseFirestore.instance
            .collection('customers')
            .doc(_user.uid)
            .collection('active_coupons')
            .where('code', isEqualTo: promotionalCode)
            .where('used', isEqualTo: false)
            .where('status', isEqualTo: 'VALID')
            .get();

        print('findCouponsQuery: ${findCouponsQuery.docs.length}');

        if (findCouponsQuery.docs.isNotEmpty) {
          DocumentSnapshot findCouponDoc = findCouponsQuery.docs.first;
          await findCouponDoc.reference.update({
            'actived': true,
          });
          promotionalCode = '';
          textEditingController.clear();
        } else {
          Fluttertoast.showToast(
            msg: "Cupom não encontrado",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print('Cupom não encontrado');
          // _messageError = 'Cupom não encontrado';
        }
      } else {
        DocumentSnapshot activeCouponDoc = activedCoupons.docs.first;
        print(
            'activeCouponDoc: ${activeCouponDoc['type']} - ${activeCouponDoc['code']}');

        if (activeCouponDoc['code'] != promotionalCode) {
          if (activeCouponDoc['type'] == "FRIEND_INVITE") {
            Fluttertoast.showToast(
              msg: "Só é possível ter um cupom por pedido",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            print('Só é possível ter um cupom por pedido');
            // _messageError = 'Cupom não encontrado';
          } else {
            QuerySnapshot findCouponsQuery = await FirebaseFirestore.instance
                .collection('customers')
                .doc(_user.uid)
                .collection('active_coupons')
                .where('code', isEqualTo: promotionalCode)
                .where('used', isEqualTo: false)
                .where('status', isEqualTo: 'VALID')
                .get();

            print('findCouponsQuery: ${findCouponsQuery.docs.length}');

            if (findCouponsQuery.docs.isNotEmpty) {
              DocumentSnapshot findCouponDoc = findCouponsQuery.docs.first;

              QuerySnapshot activedCouponQuery = await FirebaseFirestore
                  .instance
                  .collection('customers')
                  .doc(_user.uid)
                  .collection('active_coupons')
                  .where('actived', isEqualTo: true)
                  .where('used', isEqualTo: false)
                  .where('status', isEqualTo: 'VALID')
                  .get();

              print('activedCouponQuery: ${activedCouponQuery.docs.length}');

              if (activedCouponQuery.docs.isNotEmpty) {
                await activedCouponQuery.docs.first.reference.update({
                  'actived': false,
                });
              }
              await findCouponDoc.reference.update({
                'actived': true,
              });
              promotionalCode = '';
              textEditingController.clear();
            } else {
              Fluttertoast.showToast(
                msg: "Cupom não encontrado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              print('Cupom não encontrado');
              // _messageError = 'Cupom não encontrado';
            }
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Este cupom já está sendo utilizado',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print('Este cupom já está sendo utilizado');
        }
      }
      canBack = true;
      loadOverlay!.remove();
      loadOverlay = null;
    }
  }

  setUseCoupon() async {
    final User? _user = FirebaseAuth.instance.currentUser;

    QuerySnapshot activedCoupons = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user!.uid)
        .collection('active_coupons')
        .where('actived', isEqualTo: true)
        .where('used', isEqualTo: false)
        .where('status', isEqualTo: 'VALID')
        .get();

    if (activedCoupons.docs.isNotEmpty) {
      await activedCoupons.docs.first.reference
          .update({'actived': false, 'used': true});
      FirebaseFirestore.instance
          .collection('orders')
          .doc(activedCoupons.docs.first.id)
          .update({'actived': false, 'used': true});
    }
  }

  @action
  Future<QuerySnapshot> getAvailableCards() async {
    final User? _user = FirebaseAuth.instance.currentUser;
    QuerySnapshot cards = await FirebaseFirestore.instance
        .collection('customers')
        .doc(_user!.uid)
        .collection('cards')
        .orderBy('created_at', descending: true)
        .where('status', isEqualTo: 'ACTIVE')
        .get();

    return cards;
  }

  // @action
  // Future<void> setMarker(AddressModel address, context) async {
  //   marker = Marker(
  //     markerId: MarkerId("main_address"),
  //     position: LatLng(
  //       address.latitude!,
  //       address.longitude!,
  //     ),
  //     icon: await bitmapDescriptorFromSvgAsset(
  //         context, "./assets/svg/location.svg"),
  //   );
  // }
}
