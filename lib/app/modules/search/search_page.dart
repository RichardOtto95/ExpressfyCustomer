import 'package:delivery_customer/app/modules/home/widgets/product.dart';
import 'package:delivery_customer/app/modules/main/main_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:delivery_customer/app/shared/widgets/center_load_circular.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_customer/app/modules/search/search_store.dart';
import 'package:flutter/material.dart';

import 'widget/recent_search.dart';
import 'widget/search_fields.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'SearchPage'}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final SearchStore store = Modular.get();
  final MainStore mainStore = Modular.get();

  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    scrollController = ScrollController();
    addListener();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    focusNode.dispose();
  }

  addListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        mainStore.setVisibleNav(false);
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainStore.setVisibleNav(true);
      }
    });
    focusNode.addListener(() {
      mainStore.setVisibleNav(!focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: wXD(MediaQuery.of(context).viewPadding.top, context)),
          SearchField(focus: focusNode),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.only(top: wXD(20, context)),
              controller: scrollController,
              child: Observer(builder: (context) {
                print("store.history == null ${store.history == null}");
                print("store.searchedText != '' ${store.searchedText != ""}");
                print(
                    "store.searchedItems == null ${store.searchedItems == null}");
                print("");
                if (store.history == null ||
                    (store.searchedText != "" && store.searchedItems == null)) {
                  return CenterLoadCircular();
                }
                if (store.history != null && store.history!.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: hXD(200, context)),
                    child: Text("Sem histórico de busca"),
                  ));
                }
                if (store.searchedItems != null &&
                    store.searchedItems!.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: hXD(200, context)),
                    child: Text("Sem produtos de que satisfaçam com a busca"),
                  ));
                }
                if (store.searchedItems != null &&
                    store.searchedItems!.isNotEmpty) {
                  return Center(
                    child: Wrap(
                      runSpacing: wXD(4, context),
                      spacing: wXD(4, context),
                      children: List.generate(
                        store.searchedItems!.length,
                        (index) => Product(ads: store.searchedItems![index]),
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: maxWidth(context),
                      padding: EdgeInsets.only(
                          left: wXD(19, context), right: wXD(19, context)),
                      child: Row(
                        children: [
                          Text(
                            'Buscas recentes',
                            style: textFamily(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: darkGrey,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () => store.cleanHistory(),
                              child: Text(
                                "Limpar",
                                style: textFamily(fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                    ...List.generate(
                      store.history!.length,
                      (index) =>
                          RecentSearch(text: store.history![index]['label']),
                    ),
                    SizedBox(height: wXD(120, context)),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
