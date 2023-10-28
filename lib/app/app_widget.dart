import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('pt', 'BR')],
      // ignore: deprecated_member_use
      theme: ThemeData(appBarTheme: AppBarTheme(brightness: Brightness.light)),
      debugShowCheckedModeBanner: false,
      title: "DeliveryApp",
      initialRoute: "/",
    ).modular();
  }
}
