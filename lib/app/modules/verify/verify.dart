import 'dart:async';
import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/modules/sign_phone/sign_phone_store.dart';
import 'package:delivery_customer/app/modules/verify/widgets/custom_pincode_textfield.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Verify extends StatefulWidget {
  final String phoneNumber;
  const Verify({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final SignPhoneStore store = Modular.get();
  final AuthStore authStore = Modular.get();
  bool isCodeSent = false;
  bool secondResend = false;
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _onVerifyCode();
  }

  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          store.phone = widget.phoneNumber;
          setState(() {
            timer.cancel();
            print('*************8 reenviou');
            print(
                '*************authStore.phoneMobile ${authStore.phoneMobile}');
            print('*************authStore.mobile ${authStore.mobile}');
            store.phone = authStore.mobile;
            store.verifyNumber(context);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void startTimereNumber() {
    const oneSec = const Duration(seconds: 1);
    store.start = 59;
    store.timer = new Timer.periodic(oneSec, (Timer timer) {
      if (store.start == 0) {
        store.timer!.cancel();

        print('##################### reenviou');
        print(
            '#####################3 authStore.phoneMobile ${authStore.phoneMobile}');
        print('#####################authStore.mobile ${authStore.mobile}');
      } else {
        store.start = store.start - 1;
        print('store.start: ${store.start}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (authStore.canBack) {
          if (_timer != null) {
            if (_timer!.isActive) {
              _timer!.cancel();
              _timer = null;
            }
          }
          setState(() {
            startTimereNumber();
          });
          print('onWillPop /sign');
          Modular.to.pop();
          // Modular.to.pushNamedAndRemoveUntil(
          //     "/sign", ModalRoute.withName('/sign-phone'));

          // Modular.to.popUntil(ModalRoute.withName('/sign-phone'));
          // Modular.to.popAndPushNamed('/sign-phone');
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 6),
                Text(
                  'Insira o código enviado para o \n número ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
                Spacer(flex: 2),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: wXD(30, context)),
                  width: maxWidth(context),
                  child: CustomPinCodeTextField(controller: _pinCodeController),
                ),
                Spacer(
                  flex: 2,
                ),
                TextButton(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: blue, width: 2)),
                    ),
                    padding: EdgeInsets.only(bottom: wXD(3, context)),
                    child: Text(
                      'Reenviar o código',
                      style: textFamily(
                        color: textTotalBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onPressed: () {
                    startTimer();
                    setState(() {
                      secondResend = true;
                    });
                  },
                ),
                Spacer(flex: 1),
                secondResend
                    ? Text(
                        "Reenviando código em $_start segundos",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      )
                    : Container(),
                Spacer(flex: 2),
                SideButton(
                  onTap: () async {
                    if (_pinCodeController.text.length == 6 &&
                        _pinCodeController.text.isNotEmpty) {
                      await store.signinPhone(
                        _pinCodeController.text,
                        // authStore.userVerifyId!,
                        context,
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "Código incompleto!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  title: 'Validar',
                  height: wXD(52, context),
                  width: wXD(142, context),
                ),
                Spacer(),
              ],
            ),
            DefaultAppBar(
              'Código enviado',
              onPop: () {
                if (_timer != null) {
                  if (_timer!.isActive) {
                    _timer!.cancel();
                    _timer = null;
                  }
                }
                setState(() {
                  startTimereNumber();
                });
                Modular.to.pushNamedAndRemoveUntil(
                    "/sign", ModalRoute.withName('/sign-phone'));
              },
            ),
          ],
        ),
      ),
    );
  }

  showToast(message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
    );
  }
}
