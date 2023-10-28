import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressModel {
  String? addressComplement;
  String? addressName;
  String? addressNumber;
  String? cep;
  String? city;
  Timestamp? createdAt;
  String? formatedAddress;
  String? id;
  double? latitude;
  double? longitude;
  bool? main;
  String? neighborhood;
  String? state;
  String? status;
  bool? withoutComplement;

  AddressModel({
    this.addressComplement,
    this.addressName,
    this.addressNumber,
    this.cep,
    this.city,
    this.createdAt,
    this.formatedAddress,
    this.id,
    this.latitude,
    this.longitude,
    this.main,
    this.neighborhood,
    this.state,
    this.status,
    this.withoutComplement,
  });

  factory AddressModel.fromDoc(DocumentSnapshot doc) {
    // print(doc.data());
    return AddressModel(
      addressComplement: doc["address_complement"],
      addressName: doc["address_name"],
      addressNumber: doc["address_number"],
      cep: doc["cep"],
      city: doc["city"],
      createdAt: doc["created_at"],
      formatedAddress: doc["formated_address"],
      id: doc["id"],
      latitude: doc["latitude"],
      longitude: doc["longitude"],
      main: doc["main"],
      neighborhood: doc["neighborhood"],
      state: doc["state"],
      status: doc["status"],
      withoutComplement: doc["without_complement"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address_complement": addressComplement,
        "address_name": addressName,
        "address_number": addressNumber,
        "cep": cep,
        "city": city,
        "created_at": createdAt,
        "formated_address": formatedAddress,
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "main": main,
        "neighborhood": neighborhood,
        "state": state,
        "status": status,
        "without_complement": withoutComplement,
      };

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAddressSnap() =>
      FirebaseFirestore.instance
          .collection("customers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("addresses")
          .doc(id)
          .snapshots();
}
