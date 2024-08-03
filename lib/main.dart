import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pdfviwer/Splash_screen.dart';
import 'package:pdfviwer/notifier/notifiers.dart';
import 'package:device_preview/device_preview.dart';


void main() => runApp(
  DevicePreview(
    builder: (context) => const MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder (
      valueListenable: isDarkModelNotifier,
        builder: (context, isDark, child) {

          return GetMaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor:  Colors.white ,
              brightness: isDark? Brightness.dark : Brightness.light,                 ///added darkMode////
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home:  const SplashScreen(),
          );
        },
    );
  }
}
