import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/core/models/time_model.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  final Timestamp? answeredAt;
  final String? answer;

  Question({
    Key? key,
    required this.question,
    required this.answeredAt,
    this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: veryLightGrey, width: wXD(.5, context)))),
      padding: EdgeInsets.only(bottom: wXD(8, context), top: wXD(8, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: textFamily(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
          ),
          answer != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: wXD(3, context),
                        top: wXD(7, context),
                      ),
                      height: wXD(12, context),
                      width: wXD(12, context),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: grey),
                          bottom: BorderSide(color: grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: wXD(8, context),
                        left: wXD(3, context),
                      ),
                      width: wXD(310, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            answer!,
                            style: textFamily(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: grey.withOpacity(.5),
                            ),
                          ),
                          Text(
                            Time(answeredAt!.toDate()).dayDate(),
                            style: textFamily(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: grey.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
