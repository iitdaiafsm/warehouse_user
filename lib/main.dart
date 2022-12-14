import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/helper/firebase_helper.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

import 'firebase_options.dart';
import 'helper/route_delegate.dart';
import 'helper/routes.dart';
import 'helper/theme_data.dart';

late FirebaseHelper firebaseHelper;
late WarehouseController warehouseController;

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverride();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseHelper = FirebaseHelper();
  warehouseController = Get.put(WarehouseController());
  // firebaseHelper.addDummyData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Warehouse',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      defaultTransition: Transition.rightToLeftWithFade,
      getPages: Routes.routes,
      routerDelegate: AppRouterDelegate(),
    );
  }
}
