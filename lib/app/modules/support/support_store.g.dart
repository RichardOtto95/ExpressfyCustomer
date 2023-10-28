// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportStore on _SupportStoreBase, Store {
  final _$textControllerAtom = Atom(name: '_SupportStoreBase.textController');

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  final _$imagesAtom = Atom(name: '_SupportStoreBase.images');

  @override
  List<File>? get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(List<File>? value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$imagesNameAtom = Atom(name: '_SupportStoreBase.imagesName');

  @override
  List<String>? get imagesName {
    _$imagesNameAtom.reportRead();
    return super.imagesName;
  }

  @override
  set imagesName(List<String>? value) {
    _$imagesNameAtom.reportWrite(value, super.imagesName, () {
      super.imagesName = value;
    });
  }

  final _$imagesBoolAtom = Atom(name: '_SupportStoreBase.imagesBool');

  @override
  bool get imagesBool {
    _$imagesBoolAtom.reportRead();
    return super.imagesBool;
  }

  @override
  set imagesBool(bool value) {
    _$imagesBoolAtom.reportWrite(value, super.imagesBool, () {
      super.imagesBool = value;
    });
  }

  final _$cameraImageAtom = Atom(name: '_SupportStoreBase.cameraImage');

  @override
  File? get cameraImage {
    _$cameraImageAtom.reportRead();
    return super.cameraImage;
  }

  @override
  set cameraImage(File? value) {
    _$cameraImageAtom.reportWrite(value, super.cameraImage, () {
      super.cameraImage = value;
    });
  }

  final _$clearNewSupportMessagesAsyncAction =
      AsyncAction('_SupportStoreBase.clearNewSupportMessages');

  @override
  Future<void> clearNewSupportMessages() {
    return _$clearNewSupportMessagesAsyncAction
        .run(() => super.clearNewSupportMessages());
  }

  final _$createSupportAsyncAction =
      AsyncAction('_SupportStoreBase.createSupport');

  @override
  Future<void> createSupport() {
    return _$createSupportAsyncAction.run(() => super.createSupport());
  }

  final _$sendSupportMessageAsyncAction =
      AsyncAction('_SupportStoreBase.sendSupportMessage');

  @override
  Future<void> sendSupportMessage() {
    return _$sendSupportMessageAsyncAction
        .run(() => super.sendSupportMessage());
  }

  final _$sendImageAsyncAction = AsyncAction('_SupportStoreBase.sendImage');

  @override
  Future<dynamic> sendImage(dynamic context) {
    return _$sendImageAsyncAction.run(() => super.sendImage(context));
  }

  @override
  String toString() {
    return '''
textController: ${textController},
images: ${images},
imagesName: ${imagesName},
imagesBool: ${imagesBool},
cameraImage: ${cameraImage}
    ''';
  }
}
