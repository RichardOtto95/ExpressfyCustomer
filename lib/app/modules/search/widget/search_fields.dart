import 'package:delivery_customer/app/modules/search/search_store.dart';
import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchField extends StatelessWidget {
  final FocusNode? focus;
  SearchField({Key? key, this.focus}) : super(key: key);

  final SearchStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(52, context),
        width: wXD(352, context),
        padding:
            EdgeInsets.only(left: wXD(15, context), right: wXD(5, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(19)),
          border: Border.all(color: Color(0xffe8e8e8), width: 2),
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Color(0x20000000),
              offset: Offset(0, 7),
            )
          ],
        ),
        child: Row(
          children: [
            InkWell(
              child: Icon(
                Icons.search_rounded,
                size: wXD(40, context),
                color: veryDarkGrey.withOpacity(.25),
              ),
            ),
            SizedBox(width: 9),
            Expanded(
              child: TextField(
                focusNode: focus,
                style: textFamily(
                  fontSize: 16,
                  color: textBlack,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Procure por itens ou lojas',
                  hintStyle: textFamily(
                    fontSize: 16,
                    color: darkGrey.withOpacity(.56),
                  ),
                ),
                onChanged: (val) => store.searching(val),
                onEditingComplete: () => store.confirmSearch(),
                controller: store.textEditingController,
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(90),
              child: Observer(builder: (context) {
                return IconButton(
                  onPressed: () {
                    if (store.searchedItems != null &&
                        store.searchedItems!.isNotEmpty) {
                      store.searchedText = '';
                      store.searchedItems!.clear();
                      store.searchedItems = null;
                      store.textEditingController.clear();
                    } else {
                      store.confirmSearch();
                    }
                  },
                  icon: Icon(
                    store.searchedItems != null &&
                            store.searchedItems!.isNotEmpty
                        ? Icons.close_rounded
                        : Icons.arrow_forward_rounded,
                    size: wXD(25, context),
                    color: primary,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
