import 'package:delivery_customer/app/core/services/auth/auth_store.dart';
import 'package:delivery_customer/app/modules/sign_phone/sign_phone_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignPagePhone extends StatefulWidget {
  const SignPagePhone({Key? key}) : super(key: key);

  @override
  _SignPagePhoneState createState() => _SignPagePhoneState();
}

class _SignPagePhoneState extends State<SignPagePhone> {
  final SignPhoneStore store = Modular.get();
  final AuthStore authStore = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  MaskTextInputFormatter maskFormatterPhone = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  String phone = '';
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(white),
      child: Listener(
        onPointerDown: (a) =>
            FocusScope.of(context).requestFocus(new FocusNode()),
        child: WillPopScope(
          onWillPop: () async {
            return authStore.getCanBack();
          },
          child: Scaffold(
            body: Observer(builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  height: maxHeight(context),
                  width: maxWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset(
                        './assets/images/mercado_expresso.png',
                        width: wXD(173, context),
                        height: wXD(153, context),
                      ),
                      Spacer(),
                      Text(
                        'Bem vindo',
                        textAlign: TextAlign.center,
                        style: textFamily(
                          fontSize: 28,
                          color: textTotalBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Cadastre-se para entrar',
                        textAlign: TextAlign.center,
                        style: textFamily(
                          fontSize: 20,
                          color: textTotalBlack.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(flex: 2),
                      Container(
                        width: wXD(235, context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => focusNode.requestFocus(),
                              child: Text(
                                'Telefone',
                                style: textFamily(
                                  fontSize: 20,
                                  color: textTotalBlack.withOpacity(.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                focusNode: focusNode,
                                inputFormatters: [maskFormatterPhone],
                                keyboardType: TextInputType.phone,
                                style: textFamily(fontSize: 20),
                                decoration: InputDecoration.collapsed(
                                  hintText: '',
                                ),
                                onChanged: (val) {
                                  print(
                                      'val: ${maskFormatterPhone.unmaskText(val)} - ${maskFormatterPhone.unmaskText(val).length}');
                                  phone = maskFormatterPhone.unmaskText(val);
                                  store.setPhone(phone);
                                },
                                validator: (value) {
                                  print('value validator: $value');
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  if (value.length < 11) {
                                    return 'Campo incompleto';
                                  }

                                  return null;
                                },
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (_formKey.currentState!.validate()) {
                                    if (store.phone == null) {
                                      store.phone = phone;
                                    }
                                    print('store.start: ${store.start}');
                                    if (store.start != 60 && store.start != 0) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Aguarde ${store.start} segundos para reenviar um novo código",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      store.verifyNumber(context);
                                    }
                                  }
                                },
                                controller: _phoneNumberController,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: primary),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: wXD(20, context),
                            // ),
                            // Center(
                            //   child: GestureDetector(
                            //     onTap: () async {
                            //       _phoneNumberController.clear();
                            //       store.setPhone(null);
                            //       phone = '';
                            //       await Modular.to.pushNamed('/sign-email');
                            //     },
                            //     child: Stack(
                            //       alignment: Alignment.center,
                            //       children: [
                            //         Positioned(
                            //           left: 0,
                            //           child: Icon(Icons.email_outlined),
                            //         ),
                            //         Container(
                            //           width: wXD(160, context),
                            //           alignment: Alignment.center,
                            //           child: Text("Logar com email",
                            //               style: textFamily()),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Spacer(flex: 1),
                      store.start != 60 && store.start != 0
                          ? Text(
                              "Aguarde ${store.start} segundos para reenviar um novo código",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.normal),
                            )
                          : Container(),
                      Spacer(flex: 1),
                      SideButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (phone.length < 11) {
                              showToast("Preencha o campo corretamente");
                              return;
                            }
                            if (store.phone == null) {
                              store.phone = phone;
                            }
                            print('store.start: ${store.start}');

                            if (store.start != 60 && store.start != 0) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Aguarde ${store.start} segundos para reenviar um novo código",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              store.verifyNumber(context);
                            }
                          }
                        },
                        title: 'Entrar',
                        height: wXD(52, context),
                        width: wXD(142, context),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
