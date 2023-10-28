import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order {
  int? totalAmount;
  num? priceRateDelivery;
  num? priceTotal;
  num? priceTotalWithDiscount;
  double? rating;
  String? status;
  String? agentToken;
  String? customerToken;
  String? id;
  String? customerId;
  String? sellerId;
  String? agentId;
  String? agentStatus;
  String? discontinuedBy;
  String? userIdDiscontinued;
  String? discontinuedReason;
  String? customerAdderessId;
  String? sellerAdderessId;
  bool rated;
  Timestamp? createdAt;
  Timestamp? startDate;
  Timestamp? endDate;
  Timestamp? sendDate;
  String? couponId;
  num? change;
  bool? paid;

  Order({
    this.agentStatus,
    this.agentId,
    this.id,
    this.customerId,
    this.sellerId,
    this.discontinuedBy,
    this.discontinuedReason,
    this.userIdDiscontinued,
    this.rating,
    this.startDate,
    this.endDate,
    this.priceRateDelivery,
    this.totalAmount,
    this.rated = false,
    this.status,
    this.priceTotal,
    this.agentToken,
    this.customerToken,
    this.createdAt,
    this.sendDate,
    this.customerAdderessId,
    this.sellerAdderessId,
    this.couponId,
    this.priceTotalWithDiscount,
    this.change,
    this.paid,
  });

  factory Order.fromDoc(DocumentSnapshot doc) => Order(
    id: doc['id'],
    customerId: doc['customer_id'],
    sellerId: doc['seller_id'],
    discontinuedBy: doc['discontinued_by'],
    discontinuedReason: doc['discontinued_reason'],
    userIdDiscontinued: doc['user_id_discontinued'],
    startDate: doc['start_date'],
    endDate: doc['end_date'],
    priceRateDelivery: doc['price_rate_delivery'],
    totalAmount: doc['total_amount'],
    priceTotal: doc['price_total'],
    rated: doc['rated'],
    status: doc['status'],
    customerToken: doc['customer_token'],
    agentToken: doc['agent_token'],
    customerAdderessId: doc['customer_address_id'],
    sellerAdderessId: doc['seller_address_id'],
    createdAt: doc['created_at'],
    sendDate: doc['send_date'],
    rating: doc['rating'] != null ? doc['rating'].toDouble() : null,
    agentId: doc["agent_id"],
    agentStatus: doc["agent_status"],
    couponId: doc["coupon_id"],
    priceTotalWithDiscount: doc['price_total_with_discount'],
    change: doc['change'],
    paid: doc['paid'],
  );

  Map<String, dynamic> toJson({Order? order}) => order == null
      ? {
          'id': id,
          'customer_id': customerId,
          'seller_id': sellerId,
          'discontinued_by': discontinuedBy,
          'discontinued_reason': discontinuedReason,
          'start_date': startDate,
          'end_date': endDate,
          'price_rate_delivery': priceRateDelivery,
          'total_amount': totalAmount,
          'rated': rated,
          'status': status,
          'customer_token': customerToken,
          'agent_token': agentToken,
          'created_at': createdAt,
          'price_total': priceTotal,
          'price_total_with_discount': priceTotalWithDiscount,
          'user_id_discontinued': userIdDiscontinued,
          'send_date': sendDate,
          'rating': rating,
          'agent_id': agentId,
          'agent_status': agentStatus,
          'customer_address_id': customerAdderessId,
          'seller_address_id': sellerAdderessId,
          'coupon_id': couponId,
          'change': change,
          'paid': paid,
        }
      : {
          'id': order.id,
          'customer_id': order.customerId,
          'seller_id': order.sellerId,
          'discontinued_by': order.discontinuedBy,
          'discontinued_reason': order.discontinuedReason,
          'start_date': order.startDate,
          'end_date': order.endDate,
          'price_rate_delivery': order.priceRateDelivery,
          'total_amount': order.totalAmount,
          'rated': order.rated,
          'status': order.status,
          'customer_token': order.customerToken,
          'agent_token': order.agentToken,
          'created_at': order.createdAt,
          'price_total': order.priceTotal,
          'price_total_with_discount': order.priceTotalWithDiscount,
          'user_id_discontinued': order.userIdDiscontinued,
          'send_date': order.sendDate,
          'rating': order.rating,
          'agent_id': order.agentId,
          'agent_status': order.agentStatus,
          'customer_address_id': order.customerAdderessId,
          'seller_address_id': order.sellerAdderessId,
          'coupon_id': order.couponId,
          'change': order.change,
          'paid': order.paid,
        };

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getAds() async {    
    QuerySnapshot<Map<String, dynamic>> orderAds = await FirebaseFirestore
        .instance
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc(id)
        .collection("ads")
        .get();

    print('getAds: $id - ${orderAds.docs.length}');
    return orderAds.docs;
  }
}
