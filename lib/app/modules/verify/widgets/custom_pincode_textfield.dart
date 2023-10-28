import 'package:delivery_customer/app/constants/themes/pincodetheme.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatefulWidget {
  final TextEditingController? controller;
  const CustomPinCodeTextField({Key? key, this.controller}) : super(key: key);

  @override
  _CustomPinCodeTextFieldState createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      pinTheme: customPinTheme,
      boxShadows: [
        BoxShadow(
          offset: Offset(0.5, 3),
          color: Color(0x30000000),
          blurRadius: 4,
        )
      ],
      enableActiveFill: true,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      onChanged: (value) {
        print(value);
      },
    );
  }
}
