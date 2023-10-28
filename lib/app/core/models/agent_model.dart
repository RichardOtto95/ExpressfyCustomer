import 'package:cloud_firestore/cloud_firestore.dart';

class Agent {
  String? avatar;
  String? fullname;
  String? username;
  String? birthday;
  String? cpf;
  String? rg;
  String? issuingAgency;
  String? gender;
  String? id;
  String? phone;
  String? status;
  String? bank;
  String? agency;
  String? operation;
  String? cep;
  String? city;
  String? state;
  String? country;
  String? neighborhood;
  String? address;
  String? number;
  String? addressComplement;
  String? digit;
  String? mainAddress;
  Timestamp? createdAt;
  int? newNotifications;
  List? tokenId;
  bool? connected;
  bool? notificationEnabled;
  bool? savingsAccount;
  bool? linkedToCnpj;
  Map? position;

  Agent({
    this.digit,
    this.createdAt,
    this.avatar,
    this.fullname,
    this.username,
    this.birthday,
    this.cpf,
    this.rg,
    this.issuingAgency,
    this.gender,
    this.id,
    this.phone,
    this.status,
    this.newNotifications,
    this.tokenId,
    this.connected,
    this.bank,
    this.agency,
    this.operation,
    this.savingsAccount,
    this.notificationEnabled,
    this.linkedToCnpj,
    this.cep,
    this.city,
    this.state,
    this.country,
    this.neighborhood,
    this.address,
    this.number,
    this.addressComplement,
    this.mainAddress,
    this.position,
  });

  factory Agent.fromDoc(DocumentSnapshot doc) {
    return Agent(
      createdAt: doc['created_at'],
      avatar: doc['avatar'],
      fullname: doc['fullname'],
      username: doc['username'],
      birthday: doc['birthday'],
      cpf: doc['cpf'],
      rg: doc['rg'],
      issuingAgency: doc['issuing_agency'],
      gender: doc['gender'],
      id: doc['id'],
      phone: doc['phone'],
      status: doc['status'],
      newNotifications: doc['new_notifications'],
      tokenId: doc['token_id'],
      connected: doc['connected'],
      bank: doc['bank'],
      agency: doc['agency'],
      operation: doc['operation'],
      savingsAccount: doc['savings_account'],
      linkedToCnpj: doc['linked_to_cnpj'],
      cep: doc['cep'],
      city: doc['city'],
      state: doc['state'],
      country: doc['country'],
      neighborhood: doc['neighborhood'],
      address: doc['address'],
      number: doc['number'],
      addressComplement: doc['address_complement'],
      notificationEnabled: doc['notification_enabled'],
      digit: doc['digit'],
      mainAddress: doc['main_address'],
      position: doc['position'],
    );
  }

  Map<String, dynamic> toJson(Agent? model) => model == null
      ? {
          'created_at': createdAt,
          'avatar': avatar,
          'fullname': fullname,
          'username': username,
          'birthday': birthday,
          'cpf': cpf,
          'rg': rg,
          'issuing_agency': issuingAgency,
          'gender': gender,
          'id': id,
          'phone': phone,
          'status': status,
          'new_notifications': newNotifications,
          'token_id': tokenId,
          'connected': connected,
          'bank': bank,
          'agency': agency,
          'operation': operation,
          'savings_account': savingsAccount,
          'linked_to_cnpj': linkedToCnpj,
          'cep': cep,
          'city': city,
          'state': state,
          'country': country,
          'neighborhood': neighborhood,
          'address': address,
          'number': number,
          'address_complement': addressComplement,
          'notification_enabled': notificationEnabled,
          'digit': digit,
          'main_address': mainAddress,
          'position': position,
        }
      : {
          'created_at': model.createdAt,
          'avatar': model.avatar,
          'fullname': model.fullname,
          'username': model.username,
          'birthday': model.birthday,
          'cpf': model.cpf,
          'rg': model.rg,
          'issuing_agency': model.issuingAgency,
          'gender': model.gender,
          'id': model.id,
          'phone': model.phone,
          'status': model.status,
          'new_notifications': model.newNotifications,
          'token_id': model.tokenId,
          'connected': model.connected,
          'bank': model.bank,
          'agency': model.agency,
          'operation': model.operation,
          'savings_account': model.savingsAccount,
          'linked_to_cnpj': model.linkedToCnpj,
          'cep': model.cep,
          'city': model.city,
          'state': model.state,
          'country': model.country,
          'neighborhood': model.neighborhood,
          'address': model.address,
          'number': model.number,
          'address_complement': model.addressComplement,
          'notification_enabled': model.notificationEnabled,
          'digit': model.digit,
          'main_address': model.mainAddress,
          'position': model.position,
        };
}
