import 'package:flutter/material.dart';
import 'package:pdfviwer/homepage/myhome_page.dart';
import 'package:pdfviwer/notifiers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder (
      valueListenable: isDarkModelNotifier,
        builder: (context, isDark, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: isDark? Brightness.dark : Brightness.light,                 ///added dark////
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home: const MyHomePage(),
          );
        },
    );
  }
}
