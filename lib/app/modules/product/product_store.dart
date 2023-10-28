import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  final MainStore mainStore = Modular.get();
  @observable
  String reportReason = '';
  @observable
  int imageIndex = 1;
  @observable
  bool canBack = true;
  @observable
  PageController reportPageController = PageController();
  @observable
  ObservableList<DocumentSnapshot> ratings =
      <DocumentSnapshot>[].asObservable();

  @action
  void setImageIndex(_imageIndex) => imageIndex = _imageIndex;

  @action
  Future<Map<String, num>> getAverageEvaluation(String adsId) async {
    QuerySnapshot ratingsQuery = await FirebaseFirestore.instance
        .collection('ads')
        .doc(adsId)
        .collection('ratings')
        .where("status", isEqualTo: "VISIBLE")
        .get();

    num average = 0;
    // print("r atingsQuery.docs.isNotEmpty: ${ratingsQuery.docs.isNotEmpty}");
    if (ratingsQuery.docs.isNotEmpty) {
      for (var i = 0; i < ratingsQuery.docs.length; i++) {
        DocumentSnapshot ratingDoc = ratingsQuery.docs[i];
        average += ratingDoc['rating'];
      }
      average = average / ratingsQuery.docs.length;
    }
    // print("average: $average");
    return {
      "average-rating": average,
      "length-rating": ratingsQuery.docs.length,
    };
  }

  void getRatings(int ratingView, List<DocumentSnapshot> ratingDocs) {
    if (ratingView == 0) {
      ratings = ratingDocs.asObservable();
    } else {
      List<DocumentSnapshot> opnionsDocs = [];
      for (DocumentSnapshot ratingDoc in ratingDocs) {
        print("product_ratings: ${ratingDoc["rating"]} ");
        if (ratingView == 1 && ratingDoc["rating"] >= 3) {
          opnionsDocs.add(ratingDoc);
        } else if (ratingView == 2 && ratingDoc["rating"] < 3) {
          opnionsDocs.add(ratingDoc);
        }
      }
      ratings = opnionsDocs.asObservable();
    }
  }

  @action
  Future likeAds(String adsId, bool value) async {
    await cloudFunction(function: "likeAds", object: {
      "like": value,
      "adsId": adsId,
      "userId": mainStore.authStore.user!.uid,
    });
  }

  Future<bool> toAsk(String? question, String adsId, context) async {
    OverlayEntry loadOverlay;
    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(loadOverlay);
    canBack = false;

    if (question == null || question == '') {
      loadOverlay.remove();
      showToast("Escreva uma pergunta antes de enviar");
      return false;
    }

    await cloudFunction(function: "toAsk", object: {
      "question": question,
      "adsId": adsId,
      "userId": mainStore.authStore.user!.uid,
    }).then((value) => showToast("Pergunta enviada com sucesso!"));
    canBack = true;

    loadOverlay.remove();
    return true;
  }

  Future reportProduct(String justify, String adsId, context) async {
    OverlayEntry loadOverlay;
    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(loadOverlay);
    canBack = false;

    await FirebaseFirestore.instance.collection("reporteds").add({
      "created_at": FieldValue.serverTimestamp(),
      "collection": "ads",
      "justify": justify,
      "reason": reportReason,
      "reported": adsId,
      "user_id": mainStore.authStore.user!.uid,
    }).then((value) => value.update({"id": value.id}));

    showToast("Anúncio reportado com sucesso");

    canBack = true;
    loadOverlay.remove();

    reportReason = '';
    Modular.to.pop();
  }

  @action
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Se liga!!',
        text: 'Se liga nesse aplicativo Mercado Expresso',
        linkUrl: 'https://mercadoexpresso.com.br/',
        chooserTitle: 'Compartilhar usando');
  }
}
