// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

class CartModel {
  final String adsId;
  final int amount;
  final num value;
  final num rating;
  final bool rated;
  final String sellerId;

  CartModel({
    required this.adsId,
    required this.sellerId,
    required this.amount,
    required this.value,
    required this.rating,
    required this.rated,
  });

  // factory CartModel.fromDoc(DocumentSnapshot doc) {
  //   return CartModel(
  //     id: doc['id'],
  //     amount: doc['amount'],
  //     value: doc['value'],
  //   );
  // }

  Map<String, dynamic> toJson(CartModel model) => {
        'ads_id': model.adsId,
        'amount': model.amount,
        'value': model.value,
        'rating': model.rating,
        'rated': model.rated,
        'seller_id': model.sellerId,
      };

  ObservableMap<String, dynamic> toObservableMap(CartModel model) => {
        'ads_id': model.adsId,
        'amount': model.amount,
        'value': model.value,
        'rating': model.rating,
        'rated': model.rated,
        'seller_id': model.sellerId,
      }.asObservable();
}
