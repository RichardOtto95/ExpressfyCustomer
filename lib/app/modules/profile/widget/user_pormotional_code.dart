import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/home/home_store.dart';
import 'package:delivery_customer/app/modules/profile/profile_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/color_theme.dart';
import '../../../shared/utilities.dart';
import 'user_promotional_code_appbar.dart';

class UserPromotionalCode extends StatefulWidget {
  const UserPromotionalCode({
    Key? key,
  }) : super(key: key);
  @override
  _UserPromotionalCodeState createState() => _UserPromotionalCodeState();
}

class _UserPromotionalCodeState
    extends ModularState<UserPromotionalCode, ProfileStore> {
  // final _formKey = GlobalKey<FormState>();
  final User? _user = FirebaseAuth.instance.currentUser;

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
    return Scaffold(
      body: WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Listener(
        onPointerDown: (a) =>
            FocusScope.of(context).requestFocus(new FocusNode()),
        child: Material(
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: wXD(80, context) + statusBarHeight),
                width: maxWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      './assets/images/mercado_expresso.png',
                      width: wXD(193, context),
                      height: wXD(173, context),
                    ),
                    SizedBox(
                      height: wXD(20, context),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance.collection("info").get(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return LinearProgressIndicator(
                            color: primary,
                            backgroundColor: primary.withOpacity(0.4),
                          ); 
                        }
                        QuerySnapshot infoQuery = snapshot.data!;
                        DocumentSnapshot infoDoc = infoQuery.docs.first;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: wXD(45, context)),
                          child: Column(
                            children: [
                              Text(
                                infoDoc['invite_friend_page_title'],
                                textAlign: TextAlign.center,
                                style: textFamily(
                                  fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: wXD(30, context),
                              ),
                              Text(
                                infoDoc['invite_friend_page_description'],
                                textAlign: TextAlign.justify,
                                style: textFamily(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: wXD(40, context),
                              ),
                            ],
                          ),
                        );
                      }
                    ),                    
                    Container(
                      width: maxWidth(context),
                      margin:
                          EdgeInsets.symmetric(horizontal: wXD(75, context)),
                      padding: EdgeInsets.symmetric(
                          horizontal: wXD(8, context),
                          vertical: wXD(5, context)),
                      // height: wXD(200, context),
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                      child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('customers')
                              .doc(_user!.uid)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return LinearProgressIndicator(
                                color: primary,
                                backgroundColor: primary.withOpacity(0.5),                                
                              );
                            }
                            DocumentSnapshot _userDoc = snapshot.data!;
                            return Text(
                              _userDoc['user_promotional_code'],
                              textAlign: TextAlign.center,
                              style: textFamily(
                                fontSize: 20,
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              UserPromotionalCodeAppBar(),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: primary,
      onPressed: (){
        store.share();
      },
      child: Icon(Icons.share_rounded),
    ),
  );

    // return WillPopScope(
    //   onWillPop: () async {
    //     return true;
    //   },
    //   child: Listener(
    //     onPointerDown: (a) =>
    //         FocusScope.of(context).requestFocus(new FocusNode()),
    //     child: Material(
    //       child: Stack(
    //         children: [
    //           Container(
    //             padding:
    //                 EdgeInsets.only(top: wXD(53, context) + statusBarHeight),
    //             width: maxWidth(context),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Image.asset(
    //                   './assets/images/mercado_expresso.png',
    //                   width: wXD(173, context),
    //                   height: wXD(153, context),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 FutureBuilder<QuerySnapshot>(
    //                   future: FirebaseFirestore.instance.collection("info").get(),
    //                   builder: (context, snapshot) {
    //                     if(!snapshot.hasData){
    //                       return LinearProgressIndicator(
    //                         color: primary,
    //                         backgroundColor: primary.withOpacity(0.4),
    //                       ); 
    //                     }
    //                     QuerySnapshot infoQuery = snapshot.data!;
    //                     DocumentSnapshot infoDoc = infoQuery.docs.first;

    //                     return Column(
    //                       children: [
    //                         Text(
    //                           infoDoc['invite_friend_page_title'],
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 20,
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 15,
    //                         ),
    //                         Text(
    //                           infoDoc['invite_friend_page_description'],
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 18,
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 15,
    //                         ),
    //                       ],
    //                     );
    //                   }
    //                 ),                    
    //                 Container(
    //                   width: maxWidth(context),
    //                   margin:
    //                       EdgeInsets.symmetric(horizontal: wXD(75, context)),
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: wXD(8, context),
    //                       vertical: wXD(5, context)),
    //                   // height: wXD(200, context),
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: primary),
    //                     borderRadius: BorderRadius.all(Radius.circular(90)),
    //                   ),
    //                   child: FutureBuilder<DocumentSnapshot>(
    //                       future: FirebaseFirestore.instance
    //                           .collection('customers')
    //                           .doc(_user!.uid)
    //                           .get(),
    //                       builder: (context, snapshot) {
    //                         if (snapshot.connectionState ==
    //                             ConnectionState.waiting) {
    //                           return LinearProgressIndicator(
    //                             color: primary,
    //                             backgroundColor: primary.withOpacity(0.5),                                
    //                           );
    //                         }
    //                         DocumentSnapshot _userDoc = snapshot.data!;
    //                         return Text(
    //                           _userDoc['user_promotional_code'],
    //                           textAlign: TextAlign.center,
    //                         );
    //                       }),
    //                 ),
    //                 SizedBox(
    //                   height: 15,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           UserPromotionalCodeAppBar(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
