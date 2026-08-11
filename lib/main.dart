import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sigma/firebase_options.dart';
import 'package:sigma/helper/analytics_helper.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const SigmaApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class SigmaApp extends StatelessWidget {
  const SigmaApp({super.key});

  MaterialColor createMaterialColor(Color color) {
    return MaterialColor(
      color.value,
      <int, Color>{
        50: color.withOpacity(0.1),
        100: color.withOpacity(0.2),
        200: color.withOpacity(0.3),
        300: color.withOpacity(0.4),
        400: color.withOpacity(0.5),
        500: color.withOpacity(0.6),
        600: color.withOpacity(0.7),
        700: color.withOpacity(0.8),
        800: color.withOpacity(0.9),
        900: color.withOpacity(1.0),
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
        primarySwatch: createMaterialColor(AppColors.blue), // Or another color
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkBlue),
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: AppColors.darkBlue, // رنگ دسته‌های انتخاب متن
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      title: 'Sigma',
    );
  }
}
