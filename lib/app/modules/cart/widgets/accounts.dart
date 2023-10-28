import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class Accounts extends StatelessWidget {
  final num subTotal, priceShipping, priceTotal, discount, newPriceTotal;
  const Accounts({
    Key? key,
    required this.subTotal,
    required this.priceShipping,
    required this.priceTotal,
    required this.discount,
    required this.newPriceTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      padding: EdgeInsets.fromLTRB(
        wXD(30, context),
        wXD(30, context),
        wXD(20, context),
        wXD(30, context),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Sub Total',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency(subTotal)}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
          SizedBox(height: wXD(12, context)),
          Row(
            children: [
              Text(
                'Frete',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency(priceShipping)}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
          SizedBox(height: wXD(12, context)),
          Row(
            children: [
              Text(
                'Total',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency(priceTotal)}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
          SizedBox(height: wXD(12, context)),
          discount == 0
              ? Container()
              : Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Desconto',
                          style: textFamily(
                            fontSize: 15,
                            color: darkGrey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '- R\$${formatedCurrency(discount)}',
                          style: textFamily(
                            fontSize: 15,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: wXD(12, context)),
                    Row(
                      children: [
                        Text(
                          'A pagar',
                          style: textFamily(
                            fontSize: 15,
                            color: darkGrey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'R\$${formatedCurrency(newPriceTotal)}',
                          style: textFamily(
                            fontSize: 15,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
