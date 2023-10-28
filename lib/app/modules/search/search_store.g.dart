// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  final _$searchTextAtom = Atom(name: '_SearchStoreBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$searchedTextAtom = Atom(name: '_SearchStoreBase.searchedText');

  @override
  String get searchedText {
    _$searchedTextAtom.reportRead();
    return super.searchedText;
  }

  @override
  set searchedText(String value) {
    _$searchedTextAtom.reportWrite(value, super.searchedText, () {
      super.searchedText = value;
    });
  }

  final _$historyAtom = Atom(name: '_SearchStoreBase.history');

  @override
  List<dynamic>? get history {
    _$historyAtom.reportRead();
    return super.history;
  }

  @override
  set history(List<dynamic>? value) {
    _$historyAtom.reportWrite(value, super.history, () {
      super.history = value;
    });
  }

  final _$searchedItemsAtom = Atom(name: '_SearchStoreBase.searchedItems');

  @override
  List<Ads>? get searchedItems {
    _$searchedItemsAtom.reportRead();
    return super.searchedItems;
  }

  @override
  set searchedItems(List<Ads>? value) {
    _$searchedItemsAtom.reportWrite(value, super.searchedItems, () {
      super.searchedItems = value;
    });
  }

  final _$textEditingControllerAtom =
      Atom(name: '_SearchStoreBase.textEditingController');

  @override
  TextEditingController get textEditingController {
    _$textEditingControllerAtom.reportRead();
    return super.textEditingController;
  }

  @override
  set textEditingController(TextEditingController value) {
    _$textEditingControllerAtom.reportWrite(value, super.textEditingController,
        () {
      super.textEditingController = value;
    });
  }

  final _$getHistoryAsyncAction = AsyncAction('_SearchStoreBase.getHistory');

  @override
  Future<void> getHistory() {
    return _$getHistoryAsyncAction.run(() => super.getHistory());
  }

  final _$searchingAsyncAction = AsyncAction('_SearchStoreBase.searching');

  @override
  Future searching(String _searchText) {
    return _$searchingAsyncAction.run(() => super.searching(_searchText));
  }

  final _$confirmSearchAsyncAction =
      AsyncAction('_SearchStoreBase.confirmSearch');

  @override
  Future<void> confirmSearch() {
    return _$confirmSearchAsyncAction.run(() => super.confirmSearch());
  }

  final _$getSearchedItemsAsyncAction =
      AsyncAction('_SearchStoreBase.getSearchedItems');

  @override
  Future<void> getSearchedItems() {
    return _$getSearchedItemsAsyncAction.run(() => super.getSearchedItems());
  }

  final _$removeRecentSearchAsyncAction =
      AsyncAction('_SearchStoreBase.removeRecentSearch');

  @override
  Future removeRecentSearch(String label) {
    return _$removeRecentSearchAsyncAction
        .run(() => super.removeRecentSearch(label));
  }

  final _$cleanHistoryAsyncAction =
      AsyncAction('_SearchStoreBase.cleanHistory');

  @override
  Future cleanHistory() {
    return _$cleanHistoryAsyncAction.run(() => super.cleanHistory());
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
searchedText: ${searchedText},
history: ${history},
searchedItems: ${searchedItems},
textEditingController: ${textEditingController}
    ''';
  }
}
