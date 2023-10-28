import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class StatusForecast extends StatelessWidget {
  final String status;
  final String? deliveryForecast;
  final String deliveryForecastLabel;
  // final bool paid;
  const StatusForecast({
    Key? key,
    required this.deliveryForecastLabel,
    required this.status,
    required this.deliveryForecast,
    // required this.paid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color color = paid ? primary : Colors.red;
    Color color = primary;
    return Center(
      child: Container(
        height: wXD(56, context),
        width: wXD(343, context),
        padding: EdgeInsets.symmetric(
            vertical: wXD(13, context), horizontal: wXD(16, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x30000000),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status atual',
                  style: textFamily(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  // getPortugueseStatus(status, paid),
                  getPortugueseStatus(status),
                  style: textFamily(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  deliveryForecastLabel,
                  style: textFamily(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                deliveryForecast == null
                    ? Container(
                        height: wXD(12, context),
                        width: wXD(80, context),
                        child: LinearProgressIndicator(
                          color: color.withOpacity(.4),
                          backgroundColor: color.withOpacity(.4),
                          valueColor: AlwaysStoppedAnimation(color),
                        ),
                      )
                    : Text(
                        deliveryForecast!,
                        style: textFamily(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
