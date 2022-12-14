import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';

import '../helper/routes.dart';
import '../screens/warehouse/controller.dart';
import 'model/dummy_measurement_model.dart';
import 'utils/prefs.dart';

class WarehouseGlobalController extends GetxController
    with GetTickerProviderStateMixin {
  late Prefs _prefs;
  List<String> warehouseLocationsList = [
    "1A",
    // "1B",
    // "1C",
    // "2C",
    // "3A",
  ];
  late DummyMeasurementDataModel warehouse1A;
  late List<DummyMeasurementDataModel> measurementList;
  late DummyMeasurementDataModel currentWarehouse;
  late AnimationController blinkAnimation;

  late List<List<CustomMeasurement>> topLevelAlerts = [];

/*  Size stackSize = const Size(0, 0);
  GlobalKey globalKey = GlobalKey();*/

  @override
  void onInit() {
    blinkAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    blinkAnimation.repeat(reverse: true);
    getChanges();
    warehouse1A = DummyMeasurementDataModel(
      gridData: GridData(rows: 3, columns: 3),
      doorsData: DoorsData(leftDoors: [
        LeftDoors(
          isRunning: false,
          battery: 0,
          name: "door-E0E2E6A18298",
          time: DateTime.now()
              .subtract(const Duration(minutes: 6))
              .toUtc()
              .toString(),
          id: "D1",
        ),
        LeftDoors(
            isRunning: false,
            battery: 0,
            name: "door-E0E2E6A182FC",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "D2"),
      ], topDoors: [
        LeftDoors(isRunning: false, id: ""),
        LeftDoors(isRunning: false, id: ""),
      ], rightDoors: [
        LeftDoors(isRunning: false, id: ""),
        LeftDoors(isRunning: false, id: ''),
      ]),
      measurement: Measurement(
        leftMeasurement: [
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-4417935048D8",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A3"),
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-441793504908",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A2"),
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-441793504860",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A1"),
        ],
        rightMeasurement: [
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-4417935048B8",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A4"),
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-4417935048EC",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A5"),
          LeftMeasurement(
              humidity: 0,
              temperature: 0,
              co2: 0,
              battery: 0,
              name: "ambient-4417935048B0",
              time: DateTime.now()
                  .subtract(const Duration(minutes: 6))
                  .toUtc()
                  .toString(),
              id: "A6"),
        ],
      ),
      leftMotionDetectorValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-4417935048F8",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R2"),
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-4417935052F0",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R1"),
      ],
      topMotionDetectorValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-44179350489C",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R3"),
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-441793504888",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R4"),
      ],
      bottomMotionDetectorValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-E0E2E6A18300",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R8"),
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-4417935048C4",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R7"),
      ],
      rightMotionDetectorValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-4417935048AC",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R5"),
        SensorData(
            value: 0.0,
            battery: 0,
            name: "motion-441793504894",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "R6"),
      ],
      smokeValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "smoke-E0E2E6A18260",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "smoke"),
      ],
      airFlows: [
        AirflowData(
            temperature: 0,
            air: 0,
            battery: 0,
            name: "airflow-4417935048D4",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "AF2"),
        AirflowData(
            temperature: 0,
            air: 0,
            battery: 0,
            name: "airflow-4417935048BC",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "AF1"),
      ],
      gasValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "gas-4417935048D0",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "gas"),
      ],
      oxygenValues: [
        SensorData(
            value: 0.0,
            battery: 0,
            name: "oxygen-441793504858",
            time: DateTime.now()
                .subtract(const Duration(minutes: 6))
                .toUtc()
                .toString(),
            id: "oxygen"),
      ],
    );
    measurementList = [
      warehouse1A,
      DummyMeasurementDataModel(),
      DummyMeasurementDataModel(),
      DummyMeasurementDataModel(),
      DummyMeasurementDataModel(),
    ];
    _prefs = Prefs();
    currentWarehouse = warehouse1A;
    /*SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      var size = globalKey.currentContext!.size!;
      stackSize = size;
      update();
    });*/
    super.onInit();
  }

  void goToNextPage(int index) async {
    currentWarehouse = measurementList[index];
    Get.rootDelegate.toNamed(Routes.DASHBOARD_PAGE);
  }

  void setTopLevelAlerts(DummyMeasurementDataModel dummyMeasurementDataModel) {
    topLevelAlerts.clear();
    if (AppConfig.getAlertList(dummyMeasurementDataModel).isNotEmpty) {
      topLevelAlerts.add(AppConfig.getAlertList(dummyMeasurementDataModel));
    }
    WarehouseController warehouseController =
        Get.put<WarehouseController>(WarehouseController());
    if (topLevelAlerts.isEmpty) {
      warehouseController.warehouses
          .where((element) => element.id == "80")
          .first
          .haveAlert = true;
    } else {
      warehouseController.warehouses
          .where((element) => element.id == "80")
          .first
          .haveAlert = false;
    }
    warehouseController.update(["list"]);
    update();
  }

  void getChanges() {
    blinkAnimation.addListener(() {
      update(["title"]);
    });
  }
}
