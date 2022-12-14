import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:warehouse_user/old_warehouse/dashboard/view.dart';
import 'package:warehouse_user/old_warehouse/stream/view.dart';
import 'package:warehouse_user/old_warehouse/trends/view.dart';
import 'package:warehouse_user/old_warehouse/warehouse_name/view.dart';
import 'package:warehouse_user/screens/godowns/view.dart';

import '../screens/sensor/view.dart';
import '../screens/warehouse/view.dart';

class Routes {
  static const INITIAL_ROUTE = "/";
  static const GODOWN_PAGE = "/godown-page";
  static const SENSOR_PAGE = "/sensor-page";
  static const DASHBOARD_PAGE = "/main-page";
  static const WAREHOUSE_LIST_PAGE = "/warehouse";
  static const STREAM_PAGE = "/stream";
  static const TRENDS_PAGE = "/trends";

  static final routes = [
    GetPage(name: INITIAL_ROUTE, page: () => WarehouseScreen()),
    GetPage(name: GODOWN_PAGE, page: () => GodownScreen()),
    GetPage(name: SENSOR_PAGE, page: () => SensorScreen()),
    GetPage(name: Routes.DASHBOARD_PAGE, page: () => DashboardPage()),
    GetPage(name: Routes.WAREHOUSE_LIST_PAGE, page: () => WarehouseNamePage()),
    GetPage(name: Routes.STREAM_PAGE, page: () => StreamPage()),
    GetPage(name: Routes.TRENDS_PAGE, page: () => TrendsPage()),
  ];

  static Widget getPage(String route) {
    switch (route) {
      default:
        return Container();
    }
  }
}

abstract class AppPages {
  static final pages = [];
}
