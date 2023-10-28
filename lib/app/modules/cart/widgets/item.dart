import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int amount;
  final String image;
  final void Function() onRemove;
  final void Function() onAdd;
  final void Function() onClean;
  final void Function() onItemTap;

  Item({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.amount,
    required this.image,
    required this.onRemove,
    required this.onAdd,
    required this.onClean,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      padding: EdgeInsets.only(left: wXD(30, context), bottom: wXD(6, context)),
      margin: EdgeInsets.only(top: wXD(15, context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onItemTap,
            child: ClipRRect(
              child: image == ''
                  ? Image.asset(
                      'assets/images/no-image-icon.png',
                      height: wXD(65, context),
                      width: wXD(62, context),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: image,
                      width: wXD(62, context),
                      height: wXD(65, context),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onItemTap,
                    child: Container(
                      padding: EdgeInsets.only(left: wXD(8, context)),
                      width: wXD(220, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: textFamily(color: totalBlack),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: wXD(3, context)),
                          Text(
                            description,
                            style: textFamily(color: lightGrey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: wXD(3, context)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: wXD(20, context)),
                  InkWell(
                    onTap: onClean,
                    child: Container(
                      width: wXD(22, context),
                      height: wXD(22, context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE1E2EB),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        size: wXD(14, context),
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: wXD(270, context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: wXD(8, context)),
                      child: Text(
                        'R\$${formatedCurrency(price)}',
                        style: textFamily(color: primary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: wXD(25, context),
                      width: wXD(88, context),
                      margin: EdgeInsets.only(top: wXD(4, context)),
                      padding:
                          EdgeInsets.symmetric(horizontal: wXD(4, context)),
                      decoration: BoxDecoration(
                        border: Border.all(color: veryLightGrey),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onRemove,
                            child: Icon(
                              Icons.remove,
                              size: wXD(20, context),
                              color: primary,
                            ),
                          ),
                          Container(
                            width: wXD(32, context),
                            height: wXD(25, context),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  color: veryLightGrey,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              amount.toString(),
                              style: textFamily(color: primary),
                            ),
                          ),
                          InkWell(
                            onTap: onAdd,
                            child: Icon(
                              Icons.add,
                              size: wXD(20, context),
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
