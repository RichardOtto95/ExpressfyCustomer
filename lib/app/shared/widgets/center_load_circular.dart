import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';

import '../color_theme.dart';

class CenterLoadCircular extends StatelessWidget {
  const CenterLoadCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight(context),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(primary),
      ),
    );
  }
}
