import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/messages/widgets/message_bar.dart';
import 'package:delivery_customer/app/modules/profile/profile_store.dart';
import 'package:delivery_customer/app/modules/support/support_store.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/models/message_model.dart';
import '../../shared/color_theme.dart';
import '../messages/widgets/message.dart';

class SupportChat extends StatefulWidget {
  @override
  State<SupportChat> createState() => _SupportChatState();
}

class _SupportChatState extends ModularState<SupportChat, SupportStore> {
  final MainStore mainStore = Modular.get();
  final ProfileStore profileStore = Modular.get();
  final User? _user = FirebaseAuth.instance.currentUser;
  FocusNode focusNode = FocusNode();

  @override
  void initState(){
    store.clearNewSupportMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (store.imagesBool || store.cameraImage != null) {
          store.images!.clear();
          store.imagesBool = false;
          store.cameraImage = null;
          return false;
        }
        return true;
      },
      child: Listener(
        onPointerDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: Observer(builder: (context) {
            print("store.cameraImage: ${store.cameraImage}");
            return Stack(
              children: [
                SizedBox(
                  height: maxHeight(context),
                  width: maxWidth(context),
                  child: SingleChildScrollView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: wXD(80, context)),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("supports")
                          .where("user_id", isEqualTo: _user!.uid)
                          .where("user_collection", isEqualTo: "CUSTOMERS")
                          .snapshots(),
                      builder: (context, supportSnap) {
                        if (!supportSnap.hasData) {
                          return CenterLoadCircular();
                        }

                        if (supportSnap.data!.docs.isEmpty) {
                          return Container();
                        }

                        final supportDoc = supportSnap.data!.docs.first;

                        return StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("supports")
                              .doc(supportDoc.id)
                              .collection("messages")
                              .orderBy("created_at")
                              .snapshots(),
                          builder: (context, messagesSnap) {
                            if (!messagesSnap.hasData) {
                              return CenterLoadCircular();
                            }
                            List<Message> messages = [];
                            messagesSnap.data!.docs.forEach((messageDoc) {
                              messages.add(Message.fromDoc(messageDoc));
                            });

                            return Column(
                              children: List.generate(messages.length, (index) {
                                Message _message = messages[index];
                                Message? _previousMessage;
                                if (index > 0) {
                                  _previousMessage = messages[index - 1];
                                }

                                print('_message: ${_message.createdAt}');

                                return MessageWidget(
                                  isAuthor: _message.author == _user!.uid,
                                  rightName: mainStore.customer!.username!,
                                  leftName: "Suporte",
                                  rightAvatar: mainStore.customer!.avatar,
                                  leftAvatar: null,
                                  messageData: _message,
                                  showUserData: index == 0
                                      ? true
                                      : _message.author !=
                                          _previousMessage!.author,
                                  messageBold: false,
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                DefaultAppBar('Suporte'),
                Positioned(
                  bottom: 0,
                  child: MessageBar(
                    focus: focusNode,
                    controller: store.textController,
                    onSend: () => store.sendSupportMessage(),
                    onEditingComplete: () => store.sendSupportMessage(),
                    // takePicture: () => store.sendSupportMessage(isImage: true),
                    takePictures: () async {
                      List? response = await pickMultiImageWithName();
                      if (response != null) {
                        print('response: ${response[0]}');
                        print('response: ${response[1]}');
                        // List<File> images = response[0];
                        store.images = response[0];
                        store.imagesName = response[1];
                        store.imagesBool = response[0].isNotEmpty;
                      }
                    },
                    getCameraImage: () async {
                      List? response = await pickCameraImageWithName();
                      if (response != null) {
                        store.cameraImage = response[0];
                        store.imagesName = response[1];
                        store.sendImage(context);
                      }
                    },
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top: store.imagesBool ? 0 : maxHeight(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          store.imagesBool = false;
                          Future.delayed(Duration(milliseconds: 500),
                              () => store.images = []);
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: maxHeight(context),
                          width: maxWidth(context),
                        ),
                      ),
                      Container(
                        height: hXD(550, context),
                        width: wXD(300, context),
                        margin:
                            EdgeInsets.symmetric(vertical: wXD(58, context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                store.images!.length,
                                (index) => Image.file(
                                  store.images![index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: wXD(10, context),
                        right: wXD(10, context),
                        child: GestureDetector(
                          onTap: () => store.sendImage(context),
                          child: Container(
                            height: wXD(50, context),
                            width: wXD(50, context),
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.send_outlined,
                              color: white,
                              size: wXD(23, context),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: wXD(10, context) +
                            MediaQuery.of(context).viewPadding.top,
                        left: wXD(45, context),
                        child: InkWell(
                          onTap: () {
                            store.imagesBool = false;
                            Future.delayed(
                              Duration(milliseconds: 500),
                              () => store.images!.clear(),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.close_rounded,
                                size: wXD(35, context),
                                color: white,
                              ),
                              Icon(Icons.close_rounded, size: wXD(30, context)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
