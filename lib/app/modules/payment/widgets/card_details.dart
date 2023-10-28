import 'package:delivery_customer/app/core/models/card_model.dart';
import 'package:delivery_customer/app/modules/payment/payment_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'credit_card.dart';

class CardDetails extends StatelessWidget {
  final PaymentStore store = Modular.get();
  final CardModel cardModel;
  CardDetails({
    Key? key,
    required this.cardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (store.confirmDeleteOverlay != null &&
            store.confirmDeleteOverlay!.mounted) {
          store.confirmDeleteOverlay!.remove();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: maxHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: maxWidth(context),
                    padding: EdgeInsets.only(
                      top: wXD(96, context),
                      bottom: wXD(30, context),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(60)),
                        color: totalBlack),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CreditCard(
                          width: wXD(257, context),
                          cardModel: cardModel,
                        ),
                        SizedBox(height: wXD(33, context)),
                        Row(
                          children: [
                            SizedBox(width: wXD(41, context)),
                            Column(
                              children: [
                                CardField(
                                  title: 'Número do cartão',
                                  data: '• • • •  • • • •  • • • • ' +
                                      cardModel.finalNumber,
                                ),
                                SizedBox(height: wXD(23, context)),
                                CardField(
                                  title: 'Nome do titular do cartão',
                                  data: cardModel.nameCardHolder,
                                ),
                              ],
                            ),
                            SizedBox(width: wXD(23, context)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardField(
                                  width: wXD(81, context),
                                  title: 'Data de vencimento',
                                  data: store
                                      .getFormatedDueDate(cardModel.dueDate),
                                ),
                                SizedBox(height: wXD(23, context)),
                                // CardField(
                                //   width: wXD(81, context),
                                //   title: 'CVC',
                                //   data: cardModel.securityCode,
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  SideButton(
                    onTap: () => store.removeCard(context, cardModel.id),
                    title: 'Excluir cartão',
                    width: wXD(144, context),
                    height: wXD(52, context),
                  ),
                  SizedBox(height: wXD(28, context))
                ],
              ),
            ),
            DefaultAppBar('Detalhes do cartão'),
          ],
        ),
      ),
    );
  }
}

class CardField extends StatelessWidget {
  final double? width;
  final String title, data;
  CardField({this.width, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textFamily(fontSize: 12, color: grey)),
        Container(
          width: width ?? wXD(160, context),
          height: wXD(31, context),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xff998FA2).withOpacity(.4),
                      width: wXD(.5, context)))),
          alignment: Alignment.centerLeft,
          child: TextField(
            decoration: InputDecoration.collapsed(
                hintText: data, hintStyle: textFamily(color: white)),
          ),
        )
      ],
    );
  }
}
