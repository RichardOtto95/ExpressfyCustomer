import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/color_theme.dart';
import '../../../shared/utilities.dart';
import 'was_invited_appbar.dart';

class WasInvited extends StatefulWidget {
  const WasInvited({
    Key? key,
  }) : super(key: key);
  @override
  _WasInvitedState createState() => _WasInvitedState();
}

class _WasInvitedState extends ModularState<WasInvited, HomeStore> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Listener(
        onPointerDown: (a) =>
            FocusScope.of(context).requestFocus(new FocusNode()),
        child: Material(
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: wXD(53, context) + statusBarHeight),
                width: maxWidth(context),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      './assets/images/mercado_expresso.png',
                      width: wXD(173, context),
                      height: wXD(153, context),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance.collection('info').get(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return LinearProgressIndicator(
                            color: primary,
                            backgroundColor: primary.withOpacity(0.4),
                          );
                        } 
                        QuerySnapshot infoQuery = snapshot.data!;
                        DocumentSnapshot infoDoc = infoQuery.docs.first;
                        return Column(
                          children: [
                            Text(
                              // "Algum amigo que te indicou ao Mercado Expresso?",
                              infoDoc['first_promo_code_screen_title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              // "Se sim, digite o código do seu amigo para ganhar um desconto. Essa é sua única chance de pegar esse desconto inicial.",
                              infoDoc['first_promo_code_screen_description'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),                            
                          ],
                        );
                      }
                    ),        
                    SizedBox(
                      height: 15,
                    ),            
                    Form(
                      key: _formKey,
                      child: Container(
                        width: maxWidth(context),
                        margin:
                            EdgeInsets.symmetric(horizontal: wXD(75, context)),
                        padding: EdgeInsets.symmetric(
                            horizontal: wXD(8, context),
                            vertical: wXD(5, context)),
                        // height: wXD(200, context),
                        decoration: BoxDecoration(
                          border: Border.all(color: primary),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: "Insira o código aqui..."),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            store.promotionalCode = value;
                          },
                          validator: (val) {
                            if (val == null || val == '') {
                              return "Esse campo não pode ser vazio";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('onpressed');
                          store.setWasInvited(true, context);
                        }
                      },
                      icon: Icon(
                        Icons.find_replace_outlined,
                        color: primary,
                      ),
                      label: Text(
                        "Buscar",
                        style: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              WasInvitedAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
