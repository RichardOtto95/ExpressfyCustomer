import 'package:flutter/material.dart';

import '../color_theme.dart';
import '../utilities.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final double top;
  final IconData icon;
  const EmptyState(
      {Key? key, required this.text, this.top = 20, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: wXD(top, context)),
          Icon(
            icon,
            size: wXD(130, context),
            color: lightGrey,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: wXD(20, context)),
            child: Text(
              text,
              style: textFamily(),
            ),
          ),
        ],
      ),
    );
  }
}
