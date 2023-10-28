import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/modules/profile/profile_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';

import 'package:delivery_customer/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final MainStore mainStore = Modular.get();
  final ProfileStore store = Modular.get();
  ScrollController scrollController = ScrollController();

  int limit = 15;
  double lastExtent = 0;

  @override
  void initState() {
    store.clearNewNotifications();
    scrollController.addListener(() {
      if (scrollController.offset >
              (scrollController.position.maxScrollExtent - 200) &&
          lastExtent < scrollController.position.maxScrollExtent) {
        setState(() {
          limit += 10;
          lastExtent = scrollController.position.maxScrollExtent;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainStore.setVisibleNav(false);
      } else {
        mainStore.setVisibleNav(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    super.dispose();
    store.visualizedAllNotifications();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("customers")
                    .doc(mainStore.authStore.user!.uid)
                    .collection("notifications")
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: (context, notSnap) {
                  if (!notSnap.hasData) {
                    return CenterLoadCircular();
                  }
                  List<DocumentSnapshot> notDocs = notSnap.data!.docs;

                  if (notDocs.isEmpty) {
                    return Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      alignment: Alignment.center,
                      child: Text("Nenhuma notificação, ainda..."),
                    );
                  }

                  List<DocumentSnapshot> newNotifications = [];
                  List<DocumentSnapshot> oldNotifications = [];

                  notDocs.forEach((notDoc) {
                    if (notDoc["viewed"]) {
                      oldNotifications.add(notDoc);
                    } else {
                      newNotifications.add(notDoc);
                    }
                  });

                  return Column(
                    children: [
                      if (newNotifications.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(
                              top: newNotifications.isEmpty
                                  ? MediaQuery.of(context).viewPadding.top +
                                      wXD(30, context)
                                  : wXD(90, context)),
                          width: maxWidth(context),
                          color: primary.withOpacity(.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: wXD(16, context)),
                                child: Text(
                                  'Novas',
                                  style: textFamily(
                                    fontSize: 17,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                              ...newNotifications.map(
                                (notification) => Notification(
                                  avatar: notification['sender_avatar'],
                                  text: notification['text'],
                                  timeAgo:
                                      store.getTime(notification['sended_at']),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (oldNotifications.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(
                            top: newNotifications.isEmpty
                                ? MediaQuery.of(context).viewPadding.top +
                                    wXD(14, context)
                                : 0,
                          ),
                          width: maxWidth(context),
                          // color: backgroundGrey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: wXD(16, context)),
                                child: Text(
                                  'Anteriores',
                                  style: textFamily(
                                    fontSize: 17,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                              ...oldNotifications.map(
                                (notification) => Notification(
                                  avatar: notification['sender_avatar'],
                                  text: notification['text'],
                                  timeAgo:
                                      store.getTime(notification['sended_at']),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
          ),
          DefaultAppBar('Notificações')
        ],
      ),
    );
  }
}

class Notification extends StatelessWidget {
  final String text, timeAgo;
  final String? avatar;
  const Notification({
    Key? key,
    required this.text,
    required this.timeAgo,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(101, context),
      width: maxWidth(context),
      padding: EdgeInsets.fromLTRB(
        wXD(32, context),
        wXD(21, context),
        wXD(30, context),
        wXD(20, context),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: darkGrey.withOpacity(.2))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: avatar == null
                ? Image.asset(
                    './assets/images/defaultUser.png',
                    fit: BoxFit.cover,
                    height: wXD(48, context),
                    width: wXD(48, context),
                  )
                : CachedNetworkImage(
                    imageUrl: avatar.toString(),
                    fit: BoxFit.cover,
                    height: wXD(48, context),
                    width: wXD(48, context),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
          ),
          Container(
            width: wXD(263, context),
            padding: EdgeInsets.only(left: wXD(15, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: textFamily(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeAgo,
                  style: textFamily(color: Color(0xff8F9AA2)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
