import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/transaction_model.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_customer/app/shared/widgets/empty_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_customer/app/modules/payment/payment_store.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String title;
  const PaymentPage({Key? key, this.title = 'PaymentPage'}) : super(key: key);
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  User? _user = FirebaseAuth.instance.currentUser;

  bool montantVisible = false;

  final PaymentStore store = Modular.get();

  ScrollController scrollController = ScrollController();

  int limit = 20;

  double lastExtent = 0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >
              (scrollController.position.maxScrollExtent - 200) &&
          lastExtent < scrollController.position.maxScrollExtent) {
        setState(() {
          limit += 100;
          lastExtent = scrollController.position.maxScrollExtent;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => store.canBack,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: wXD(97, context)),
                  Padding(
                    padding: EdgeInsets.only(
                      left: wXD(22, context),
                      bottom: wXD(17, context),
                    ),
                    child: Text(
                      'Saldo em conta',
                      style: textFamily(
                        fontSize: 17,
                        color: darkGrey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        montantVisible = !montantVisible;
                      });
                    },
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('customers')
                            .doc(_user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          print(
                              'snapshot: ${snapshot.hasError} - ${snapshot.hasData}');
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          if (!snapshot.hasData) {
                            return Container(
                              height: wXD(17, context),
                              width: wXD(98, context),
                              padding: EdgeInsets.only(
                                left: wXD(22, context),
                                bottom: wXD(17, context),
                              ),
                              margin: EdgeInsets.only(left: wXD(3, context)),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: grey.withOpacity(.3),
                              ),
                              child: LinearProgressIndicator(
                                backgroundColor: primary.withOpacity(0.7),
                                color: primary,
                              ),
                            );
                          }

                          DocumentSnapshot customerDoc = snapshot.data!;

                          num totalAmount = customerDoc['account_balance'];

                          return montantVisible
                              ? Container(
                                  padding: EdgeInsets.only(
                                    left: wXD(22, context),
                                    bottom: wXD(17, context),
                                  ),
                                  child: Text(
                                    ' R\$ ${formatedCurrency(totalAmount)}',
                                    style: textFamily(
                                      fontSize: 16,
                                      color: textTotalBlack,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: wXD(17, context),
                                  width: wXD(98, context),
                                  // margin: EdgeInsets.only(left: wXD(3, context)),
                                  margin: EdgeInsets.only(
                                    left: wXD(22, context),
                                    bottom: wXD(17, context),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: grey.withOpacity(.3),
                                  ),
                                );
                        }),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: wXD(29, context),
                  //     bottom: wXD(17, context),
                  //   ),
                  //   child: Text(
                  //     'Meus cartões',
                  //     style: textFamily(
                  //       fontSize: 17,
                  //       color: darkGrey,
                  //     ),
                  //   ),
                  // ),
                  // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('customers')
                  //         .doc(FirebaseAuth.instance.currentUser!.uid)
                  //         .collection('cards')
                  //         .where('status', isEqualTo: 'ACTIVE')
                  //         .snapshots(),
                  //     builder: (context, snapshotCards) {
                  //       if (snapshotCards.hasData) {
                  //         store.cardsListMount(snapshotCards.data);
                  //       }
                  //       return Container(
                  //         width: maxWidth(context),
                  //         alignment: Alignment.center,
                  //         child: SingleChildScrollView(
                  //           padding: EdgeInsets.only(
                  //             left: wXD(6, context),
                  //             right: wXD(6, context),
                  //             bottom: wXD(22, context),
                  //           ),
                  //           scrollDirection: Axis.horizontal,
                  //           child: Observer(builder: (context) {
                  //             if (store.cardList == null) {
                  //               return Container(
                  //                 alignment: Alignment.center,
                  //                 height: wXD(144, context),
                  //                 width: wXD(212, context),
                  //                 child: CircularProgressIndicator(
                  //                   color: Colors.orange,
                  //                 ),
                  //               );
                  //             }

                  //             if (store.cardList!.isEmpty) {
                  //               return Container(
                  //                 alignment: Alignment.center,
                  //                 height: wXD(144, context),
                  //                 width: wXD(212, context),
                  //                 child: Text('Sem cartões cadastrados'),
                  //               );
                  //             }

                  //             return Row(
                  //               children: [
                  //                 ...store.cardList!.cast().map(
                  //                       (cardModel) => CreditCard(
                  //                         cardModel: cardModel,
                  //                         onTap: () => Modular.to.pushNamed(
                  //                             '/payment/card-details',
                  //                             arguments: cardModel),
                  //                       ),
                  //                     ),
                  //               ],
                  //             );
                  //           }),
                  //         ),
                  //       );
                  //     }),
                  // SideButton(
                  //   width: wXD(81, context),
                  //   onTap: () {
                  //     Modular.to.pushNamed('/payment/add-card');
                  //   },
                  //   child: Icon(
                  //     Icons.add_rounded,
                  //     size: wXD(30, context),
                  //     color: white,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: wXD(22, context),
                      top: wXD(16, context),
                      bottom: wXD(8, context),
                    ),
                    child: Text(
                      'Histórico',
                      style: textFamily(
                        fontSize: 17,
                        color: darkGrey,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('customers')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('transactions')
                        .where('payment_method',
                            whereIn: ['RECHARGE', 'ACCOUNT-BALANCE'])
                        .orderBy('created_at', descending: true)
                        .limit(limit)
                        .snapshots(),
                    builder: (context, snapshotTransactions) {
                      if (snapshotTransactions.hasData) {
                        store.transactionsListMount(snapshotTransactions.data);
                      }
                      return Observer(
                        builder: (context) {
                          if (store.transactionList == null) {
                            return LinearProgressIndicator(
                              color: Colors.orange,
                            );
                          }

                          if (store.transactionList!.isEmpty) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EmptyState(
                                  text: "Não há transações",
                                  icon: Icons.monetization_on_outlined,
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              ...store.transactionList!.cast().map(
                                    (transactionModel) => Transaction(
                                      transactionModel: transactionModel,
                                    ),
                                  ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            DefaultAppBar('Pagamento'),
          ],
        ),
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  final TransactionModel transactionModel;
  const Transaction({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(56, context),
      width: maxWidth(context),
      padding: EdgeInsets.only(
          top: wXD(13, context),
          bottom: wXD(8, context),
          right: wXD(22, context),
          left: wXD(22, context)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getText(),
            style: textFamily(
              fontSize: 15,
              color: grey,
            ),
          ),
          Column(
            children: [
              Text(
                getValue(),
                style: textFamily(
                  fontSize: 14,
                  color: grey,
                ),
              ),
              Text(
                formatedDate(),
                style: textFamily(
                  fontSize: 12,
                  color: darkGrey.withOpacity(.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getText() {
    switch (transactionModel.paymentMethod) {
      // case "CARD":
      //   return "Cobrança realizada";

      // case "MONEY":
      //   return "No dinheiro";

      case "ACCOUNT-BALANCE":
        return "Saldo em conta";

      case "RECHARGE":
        return "Recarga";

      default:
        return "";
    }
  }

  String getValue() {
    String value = formatedCurrency(transactionModel.value) + 'R\$';
    switch (transactionModel.paymentMethod) {
      // case "CARD":
      //   return "Cobrança realizada";

      // case "MONEY":
      //   return "No dinheiro";

      case "ACCOUNT-BALANCE":
        return "- " + value;

      case "RECHARGE":
        return value;

      default:
        return "";
    }
  }

  String formatedDate() {
    List<String> months = [
      '',
      'Janeiro',
      'Feverreiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    DateTime dateTime = transactionModel.updatedAt!.toDate();
    String day = dateTime.day.toString();
    return day + ' de ' + months[dateTime.month];
  }
}
