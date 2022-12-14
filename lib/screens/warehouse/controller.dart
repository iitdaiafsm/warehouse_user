import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/helper/influx_service.dart';
import 'package:warehouse_user/helper/models/warehouse_model.dart';
import 'package:warehouse_user/main.dart';

import '../../helper/models/godown_model.dart';

class WarehouseController extends GetxController
    with GetTickerProviderStateMixin {
  List<WarehouseModel> warehouses = [];
  List<GodownModel> godowns = [];
  Map<String, List<WarehouseModel>> mapList = {};
  bool isLoading = true;
  int expandedIndex = -1;
  String htmlId = "";
  late InfluxService influxService;
  late AnimationController blinkAnimation;
  // late AnimationController _animationController;
  WarehouseModel selectedWarehouse = WarehouseModel();
  GodownModel selectedGodown = GodownModel();
  Function deepEq = const DeepCollectionEquality().equals;
  // late Animation measurementHighAnimation;
  // late AnimationController _animationController;

  @override
  void onInit() {
    blinkAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    blinkAnimation.repeat(reverse: true);
    influxService = Get.put(InfluxService());
    influxService.init();
    getWarehouses();

    /*_animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animationController.repeat(reverse: true);
    measurementHighAnimation =
        Tween(begin: 1.1, end: 4.1).animate(_animationController)
          ..addListener(() {
            update([6or-page"]);
            */ /*if (mounted) {
          update();
        }*/ /*
          });*/

    super.onInit();
  }

  bool mapsEqual(Map m1, Map m2) {
    Iterable k1 = m1.keys;
    Iterable k2 = m2.keys;
    // Compare m1 to m2
    if (k1.length != k2.length) return false;
    for (dynamic o in k1) {
      if (!k2.contains(o)) return false;
      if (m1[o] is Map) {
        if (m2[o] is! Map) return false;
        if (!mapsEqual(m1[o], m2[o])) return false;
      } else {
        if (m1[o] != m2[o]) return false;
      }
    }
    return true;
  }

  Future<void> getWarehouses() async {
    warehouses = await firebaseHelper.getWarehouses();
    mapList = groupBy<WarehouseModel, String>(
        warehouses, (value) => value.state ?? "");

    isLoading = false;
    update(["list", "map"]);
    getGodowns();
  }

  void setWarehouse(WarehouseModel warehouseModel) {
    warehouses
        .where((element) => element.id == warehouseModel.id)
        .toList()
        .first = warehouseModel;
    mapList = groupBy<WarehouseModel, String>(
        warehouses, (value) => value.state ?? "");
    update(["list"]);
  }

  Future<void> getGodowns() async {
    godowns = await firebaseHelper.getGodowns();
    isLoading = false;

    // update();
    for (var item in warehouses) {
      influxService.generateQuery(
          item, godowns, (updatedGodown) {}, (updatedWarehouse) {});
    }
  }

  void expand(int index) {
    if (index != expandedIndex) {
      expandedIndex = index;
    } else {
      expandedIndex = -1;
    }
    update(["list"]);
  }

  void setGodowns(GodownModel item) {
    if (jsonEncode(
            godowns.where((element) => element.id == item.id).toList().first) ==
        jsonEncode(item)) {
      godowns.where((element) => element.id == item.id).toList().first = item;
      update(["godown-page"]);
      // update(["sensor-page"]);
    }
    if (selectedGodown.id != null && selectedGodown.id == item.id) {
      if (jsonEncode(selectedGodown) == jsonEncode(item)) {
        selectedGodown = item;
        // print(jsonEncode(item));
        update(["sensor-page"]);
      }
    }
  }

  @override
  void onClose() {
    Get.log("Called onClose");
    // _animationController.dispose();
    // measurementHighAnimation.removeListener(() {});
    // super.onClose();
  }
}
