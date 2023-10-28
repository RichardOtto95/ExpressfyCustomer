// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentStore on _PaymentStoreBase, Store {
  final _$canBackAtom = Atom(name: '_PaymentStoreBase.canBack');

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

  final _$cardsAtom = Atom(name: '_PaymentStoreBase.cards');

  @override
  ObservableList<dynamic> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<dynamic> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  final _$randomColor1Atom = Atom(name: '_PaymentStoreBase.randomColor1');

  @override
  int get randomColor1 {
    _$randomColor1Atom.reportRead();
    return super.randomColor1;
  }

  @override
  set randomColor1(int value) {
    _$randomColor1Atom.reportWrite(value, super.randomColor1, () {
      super.randomColor1 = value;
    });
  }

  final _$randomColor2Atom = Atom(name: '_PaymentStoreBase.randomColor2');

  @override
  int get randomColor2 {
    _$randomColor2Atom.reportRead();
    return super.randomColor2;
  }

  @override
  set randomColor2(int value) {
    _$randomColor2Atom.reportWrite(value, super.randomColor2, () {
      super.randomColor2 = value;
    });
  }

  final _$cardMapAtom = Atom(name: '_PaymentStoreBase.cardMap');

  @override
  ObservableMap<dynamic, dynamic> get cardMap {
    _$cardMapAtom.reportRead();
    return super.cardMap;
  }

  @override
  set cardMap(ObservableMap<dynamic, dynamic> value) {
    _$cardMapAtom.reportWrite(value, super.cardMap, () {
      super.cardMap = value;
    });
  }

  final _$emailVerificationOverlayAtom =
      Atom(name: '_PaymentStoreBase.emailVerificationOverlay');

  @override
  OverlayEntry? get emailVerificationOverlay {
    _$emailVerificationOverlayAtom.reportRead();
    return super.emailVerificationOverlay;
  }

  @override
  set emailVerificationOverlay(OverlayEntry? value) {
    _$emailVerificationOverlayAtom
        .reportWrite(value, super.emailVerificationOverlay, () {
      super.emailVerificationOverlay = value;
    });
  }

  final _$loadCircularEmailVerificationAtom =
      Atom(name: '_PaymentStoreBase.loadCircularEmailVerification');

  @override
  bool get loadCircularEmailVerification {
    _$loadCircularEmailVerificationAtom.reportRead();
    return super.loadCircularEmailVerification;
  }

  @override
  set loadCircularEmailVerification(bool value) {
    _$loadCircularEmailVerificationAtom
        .reportWrite(value, super.loadCircularEmailVerification, () {
      super.loadCircularEmailVerification = value;
    });
  }

  final _$cardListAtom = Atom(name: '_PaymentStoreBase.cardList');

  @override
  ObservableList<CardModel>? get cardList {
    _$cardListAtom.reportRead();
    return super.cardList;
  }

  @override
  set cardList(ObservableList<CardModel>? value) {
    _$cardListAtom.reportWrite(value, super.cardList, () {
      super.cardList = value;
    });
  }

  final _$transactionListAtom = Atom(name: '_PaymentStoreBase.transactionList');

  @override
  ObservableList<TransactionModel>? get transactionList {
    _$transactionListAtom.reportRead();
    return super.transactionList;
  }

  @override
  set transactionList(ObservableList<TransactionModel>? value) {
    _$transactionListAtom.reportWrite(value, super.transactionList, () {
      super.transactionList = value;
    });
  }

  final _$confirmDeleteOverlayAtom =
      Atom(name: '_PaymentStoreBase.confirmDeleteOverlay');

  @override
  OverlayEntry? get confirmDeleteOverlay {
    _$confirmDeleteOverlayAtom.reportRead();
    return super.confirmDeleteOverlay;
  }

  @override
  set confirmDeleteOverlay(OverlayEntry? value) {
    _$confirmDeleteOverlayAtom.reportWrite(value, super.confirmDeleteOverlay,
        () {
      super.confirmDeleteOverlay = value;
    });
  }

  final _$noHasEmailOverlayAtom =
      Atom(name: '_PaymentStoreBase.noHasEmailOverlay');

  @override
  OverlayEntry? get noHasEmailOverlay {
    _$noHasEmailOverlayAtom.reportRead();
    return super.noHasEmailOverlay;
  }

  @override
  set noHasEmailOverlay(OverlayEntry? value) {
    _$noHasEmailOverlayAtom.reportWrite(value, super.noHasEmailOverlay, () {
      super.noHasEmailOverlay = value;
    });
  }

  final _$addCardAsyncAction = AsyncAction('_PaymentStoreBase.addCard');

  @override
  Future addCard(BuildContext context) {
    return _$addCardAsyncAction.run(() => super.addCard(context));
  }

  final _$cardsListMountAsyncAction =
      AsyncAction('_PaymentStoreBase.cardsListMount');

  @override
  Future<void> cardsListMount(
      QuerySnapshot<Map<String, dynamic>>? snapshotCards) {
    return _$cardsListMountAsyncAction
        .run(() => super.cardsListMount(snapshotCards));
  }

  final _$_PaymentStoreBaseActionController =
      ActionController(name: '_PaymentStoreBase');

  @override
  void getColors() {
    final _$actionInfo = _$_PaymentStoreBaseActionController.startAction(
        name: '_PaymentStoreBase.getColors');
    try {
      return super.getColors();
    } finally {
      _$_PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeCard(BuildContext context, String cardUid) {
    final _$actionInfo = _$_PaymentStoreBaseActionController.startAction(
        name: '_PaymentStoreBase.removeCard');
    try {
      return super.removeCard(context, cardUid);
    } finally {
      _$_PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic transactionsListMount(
      QuerySnapshot<Map<String, dynamic>>? snapshotTransactions) {
    final _$actionInfo = _$_PaymentStoreBaseActionController.startAction(
        name: '_PaymentStoreBase.transactionsListMount');
    try {
      return super.transactionsListMount(snapshotTransactions);
    } finally {
      _$_PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getFormatedDueDate(String dueDate) {
    final _$actionInfo = _$_PaymentStoreBaseActionController.startAction(
        name: '_PaymentStoreBase.getFormatedDueDate');
    try {
      return super.getFormatedDueDate(dueDate);
    } finally {
      _$_PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
canBack: ${canBack},
cards: ${cards},
randomColor1: ${randomColor1},
randomColor2: ${randomColor2},
cardMap: ${cardMap},
emailVerificationOverlay: ${emailVerificationOverlay},
loadCircularEmailVerification: ${loadCircularEmailVerification},
cardList: ${cardList},
transactionList: ${transactionList},
confirmDeleteOverlay: ${confirmDeleteOverlay},
noHasEmailOverlay: ${noHasEmailOverlay}
    ''';
  }
}
