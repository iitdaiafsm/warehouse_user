// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/airflow_widget.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/gas_widget.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/oxygen_widget.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/smoke_widget.dart';
import 'package:warehouse_user/old_warehouse/visualization_dialog/view.dart';

import '../utils/app_config.dart';
import '../utils/fsm_resource.dart';

class WarehouseLogic extends GetxController with GetTickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  Size? containerSize;
  Size stackSize = const Size(0, 0);
  late Animation measurementHighAnimation;
  late AnimationController _animationController;
  late TabMenus selectedTab;
  late AnimationController blinkAnimation;
  String hoverID = "";
  TabMenus tabMenus = TabMenus.ALL;

  List<CustomMeasurement>? highMeasurement = [];

  List<TabMenus> tabsList = [
    TabMenus.ALL,
    TabMenus.DOORS,
    TabMenus.TEMPERATURE,
    TabMenus.HUMDITY,
    TabMenus.CO2,
  ];

  @override
  void onInit() {
    selectedTab = TabMenus.ALL;
    blinkAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    blinkAnimation.repeat(reverse: true);

    super.onInit();
  }

  void updateVariables(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      var size = globalKey.currentContext?.size!;
      // Get.log('the new height is $height');
      stackSize = size ?? const Size(0, 0);
      update();
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animationController.repeat(reverse: true);
    measurementHighAnimation =
        Tween(begin: getWidth(0.25, context), end: getWidth(0.5, context))
            .animate(_animationController)
          ..addListener(() {
            update();
            /*if (mounted) {
          update();
        }*/
          });
  }

  String getTabMenuName(TabMenus tabsList) {
    switch (tabsList) {
      case TabMenus.ALL:
        return "All";
      case TabMenus.DOORS:
        return "Doors";
      case TabMenus.TEMPERATURE:
        return "Temperature";
      case TabMenus.HUMDITY:
        return "Humidity";
      case TabMenus.CO2:
        return "CO2";
      case TabMenus.RODENTS:
        return "Rodent";
      case TabMenus.GAS:
        return "Gas";
      case TabMenus.OXYGEN:
        return "Oxygen";
      case TabMenus.SMOKE:
        return "Smoke";
      case TabMenus.AIRFLOW:
        return "Airflow";
    }
  }

  String getFilePath(CustomMeasurement customMeasurement) {
    switch (customMeasurement.type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "asset/warehouse_front.png";
      case TabMenus.TEMPERATURE:
        return "asset/temperature_high.png";
      case TabMenus.HUMDITY:
        return "asset/drop_high.png";
      case TabMenus.CO2:
        return "asset/cloud_high.png";
      case TabMenus.RODENTS:
        return "asset/rat.png";
      case TabMenus.GAS:
        return "asset/gas_icon.png";
      case TabMenus.OXYGEN:
        return "asset/oxygen.png";
      case TabMenus.SMOKE:
        return "asset/smoke_icon.png";
      case TabMenus.AIRFLOW:
        return "asset/fan_low.png";
    }
  }

  void onTabMenuClicked(TabMenus tabsList) {
    selectedTab = tabsList;
    switch (tabsList) {
      case TabMenus.ALL:
        break;
      case TabMenus.DOORS:
        showComingSoonSnackBar();
        break;
      case TabMenus.TEMPERATURE:
        showComingSoonSnackBar();
        break;
      case TabMenus.HUMDITY:
        showComingSoonSnackBar();
        break;
      case TabMenus.CO2:
        showComingSoonSnackBar();
        break;
    }
    update();
  }

  void showComingSoonSnackBar() {
    Get.snackbar("Alert", "Coming Soon...",
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: getWidth(0.1, Get.context!),
        borderColor: appPrimaryColor,
        margin: EdgeInsets.all(
          getWidth(2, Get.context!),
        ),
        titleText: Text(
          "Alert",
          style: FSMResources.FSMTextStyle(
              type: TextStyleType.bold,
              color: appTextDarkColor,
              size: AppConfig.FONT_SIZE_H5,
              context: Get.context!),
        ),
        messageText: Text(
          "Coming Soon...",
          style: FSMResources.FSMTextStyle(
              type: TextStyleType.regular,
              color: appTextDarkColor,
              size: AppConfig.FONT_SIZE_H6,
              context: Get.context!),
        ));
  }

  Future<void> getInfluxData() async {}

  void setAlertsList(DummyMeasurementDataModel dummyMeasurementDataModel) {
    highMeasurement!.clear();
    var tempList = AppConfig.getAlertList(dummyMeasurementDataModel);
    highMeasurement!.addAll(tempList);
    update();
  }

  Widget getSmokeSensorWidget(String s, BuildContext context,
      DummyMeasurementDataModel dummyMeasurementDataModel) {
    switch (s) {
      case "1A":
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmokeWidget(
                      smokeValue: dummyMeasurementDataModel.smokeValues![0],
                      measurementHighAnimation: measurementHighAnimation,
                      hoverID: hoverID,
                      blinkAnimation: blinkAnimation,
                      tabMenus: tabMenus),
                  OxygenWidget(
                      oxygenValue: dummyMeasurementDataModel.oxygenValues![0],
                      measurementHighAnimation: measurementHighAnimation,
                      blinkAnimation: blinkAnimation,
                      hoverID: hoverID,
                      tabMenus: tabMenus),
                  GasWidget(
                      gasValue: dummyMeasurementDataModel.gasValues![0],
                      measurementHighAnimation: measurementHighAnimation,
                      blinkAnimation: blinkAnimation,
                      hoverID: hoverID,
                      tabMenus: tabMenus),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AirflowWidget(
                      airflowData: dummyMeasurementDataModel.airFlows![0],
                      measurementHighAnimation: measurementHighAnimation,
                      blinkAnimation: blinkAnimation,
                      hoverID: hoverID,
                      tabMenus: tabMenus),
                  AirflowWidget(
                      airflowData: dummyMeasurementDataModel.airFlows![1],
                      measurementHighAnimation: measurementHighAnimation,
                      hoverID: hoverID,
                      blinkAnimation: blinkAnimation,
                      tabMenus: tabMenus),
                ],
              )
            ],
          );
          /*return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            /*children: List.generate(
              4,
              (columnIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (rowIndex) => ((columnIndex == 1) &&
                          (rowIndex == 1 || rowIndex == 2))
                      ? Image.asset(
                          dummyMeasurementDataModel.smokeValues![rowIndex - 1] >
                                  AppConfig.SMOKE_HIGH
                              ? "asset/smoke_detector_high.png"
                              : "asset/smoke_detector_low.png",
                          width: getWidth(3, context),
                        )
                      : (columnIndex == 2 && rowIndex == 1)
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  getWidth(1, context),
                                ),
                              ),
                    padding: EdgeInsets.all(getWidth(0.4,context),),
                    child: Column(
                      children: [
                        Image.asset(
                          "asset/fan_low.png",
                          width: getWidth(3, context),
                        ),
                        Text("3.77",style: FSMResources.FSMTextStyle(context: context),)
                      ],
                    ),
                            )
                          : Container(),
                ),
              ),
            ),*/
            children: [
              Row(
                children: [
                  Container(
                    height: getHeight(2, context),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: getHeight(2, context),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AirflowWidget(airflowData: dummyMeasurementDataModel.airFlows![0], measurementHighAnimation: measurementHighAnimation),
                  AirflowWidget(airflowData: dummyMeasurementDataModel.airFlows![1], measurementHighAnimation: measurementHighAnimation),
                  AirflowWidget(airflowData: dummyMeasurementDataModel.airFlows![2], measurementHighAnimation: measurementHighAnimation),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmokeWidget(smokeValue: dummyMeasurementDataModel.smokeValues![0], measurementHighAnimation: measurementHighAnimation),
                  SmokeWidget(smokeValue: dummyMeasurementDataModel.smokeValues![1], measurementHighAnimation: measurementHighAnimation),
                  /*Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          getWidth(
                            1,
                            context,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color:dummyMeasurementDataModel.smokeValues![0] >
                              AppConfig.SMOKE_HIGH?appDangerTextColor:appGreenColor,
                            blurRadius:dummyMeasurementDataModel.smokeValues![0] >
                              AppConfig.SMOKE_HIGH?measurementHighAnimation.value: getWidth(0.25, context),
                            spreadRadius: dummyMeasurementDataModel.smokeValues![0] >
                              AppConfig.SMOKE_HIGH?measurementHighAnimation.value: getWidth(0.25, context),
                          ),
                        ]
                    ),
                    padding: EdgeInsets.all(getWidth(0.5, context)),
                    child: Image.asset(dummyMeasurementDataModel.smokeValues![0] >
                        AppConfig.SMOKE_HIGH?"asset/smoke_icon_high.png":"asset/smoke_icon.png",
                      width: getWidth(2, context),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          getWidth(
                            1,
                            context,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color:dummyMeasurementDataModel.smokeValues![1] >
                                AppConfig.SMOKE_HIGH?appDangerTextColor:appGreenColor,
                            blurRadius:dummyMeasurementDataModel.smokeValues![1] >
                                AppConfig.SMOKE_HIGH?measurementHighAnimation.value: getWidth(0.25, context),
                            spreadRadius: dummyMeasurementDataModel.smokeValues![1] >
                                AppConfig.SMOKE_HIGH?measurementHighAnimation.value: getWidth(0.25, context),
                          ),
                        ]
                    ),
                    padding: EdgeInsets.all(getWidth(0.5, context)),
                    child: Image.asset(dummyMeasurementDataModel.smokeValues![1] >
                        AppConfig.SMOKE_HIGH?"asset/smoke_icon_high.png":"asset/smoke_icon.png",
                      width: getWidth(2, context),
                    ),
                  ),*/
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GasWidget(gasValue: dummyMeasurementDataModel.gasValues![0], measurementHighAnimation: measurementHighAnimation),
                  OxygenWidget(oxygenValue: dummyMeasurementDataModel.oxygenValues![0], measurementHighAnimation: measurementHighAnimation),

                ],
              ),
              Row(
                children: [
                  Container(
                    height: getHeight(2, context),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: getHeight(2, context),
                  )
                ],
              ),
            ],
          );*/
        }
      default:
        {
          return Container();
        }
    }
  }

  void openTrendDialog(
    CustomMeasurement customMeasurement,
    TabMenus type,
    BuildContext context,
  ) {
    String fieldValue = "";
    switch (type) {
      case TabMenus.ALL:
        fieldValue = "all";
        break;
      case TabMenus.DOORS:
        fieldValue = "value";
        break;
      case TabMenus.TEMPERATURE:
        fieldValue = "temperature";
        break;
      case TabMenus.HUMDITY:
        fieldValue = "humidity";
        break;
      case TabMenus.CO2:
        fieldValue = "eco2";
        break;
      case TabMenus.RODENTS:
        fieldValue = "value";
        break;
      case TabMenus.GAS:
        fieldValue = "gas";
        break;
      case TabMenus.OXYGEN:
        fieldValue = "oxygen";
        break;
      case TabMenus.SMOKE:
        fieldValue = "value";
        break;
      case TabMenus.AIRFLOW:
        fieldValue = "airflow";
        break;
    }
    /*if (type == TabMenus.DOORS ||
        type == TabMenus.RODENTS ||
        type == TabMenus.SMOKE){
      Get.snackbar("Alert", "Coming Soon");
      return;
    }*/
    /*Get.dialog(
      Center(
        child: Container(
          width: width(context) * 0.8,
          height: height(context) * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getWidth(1, context),
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(
            getWidth(1, context),
          ),
          child: VisualizationDialogPage(),
        ),
      ),
      arguments: {
        "name": customMeasurement.name,
        "field": fieldValue,
        "type": customMeasurement.type
      },
    );*/
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: width(context) * 0.8,
              height: height(context) * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  getWidth(1, context),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(
                getWidth(1, context),
              ),
              child: VisualizationDialogPage(
                map: {
                  "name": customMeasurement.name,
                  "field": fieldValue,
                  "type": customMeasurement.type
                },
              ),
            ),
          );
        });
  }

  void hoverWidget(String id, TabMenus type) {
    hoverID = id;
    tabMenus = type;
    update();
  }

  getTabMenuDescription(TabMenus type) {
    switch (type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "Please check if entry is authorised";
      case TabMenus.TEMPERATURE:
        return "Please open warehouse doors for ventilation";
      case TabMenus.HUMDITY:
        return "Please open warehouse doors for ventilation";
      case TabMenus.CO2:
        return "Please check for potential infestation";
      case TabMenus.RODENTS:
        return "Please take corrective and preventive actions";
      case TabMenus.GAS:
        return "";
      case TabMenus.OXYGEN:
        return "";
      case TabMenus.SMOKE:
        return "Critical Alert: Please check immediately";
      case TabMenus.AIRFLOW:
        return "";
    }
  }

  String getSensorValue(CustomMeasurement customMeasurement) {
    switch (customMeasurement.type) {
      case TabMenus.ALL:
        return customMeasurement.value.toString();
      case TabMenus.DOORS:
        return "Open";
      case TabMenus.TEMPERATURE:
        return customMeasurement.value.toString();
      case TabMenus.HUMDITY:
        return customMeasurement.value.toString();
      case TabMenus.CO2:
        return customMeasurement.value.toString();
      case TabMenus.RODENTS:
        return "!";
      case TabMenus.GAS:
        return customMeasurement.value.toString();
      case TabMenus.OXYGEN:
        return customMeasurement.value.toString();
      case TabMenus.SMOKE:
        return "Not Safe";
      case TabMenus.AIRFLOW:
        return customMeasurement.value.toString();
    }
  }

  String getSensorUnit(CustomMeasurement customMeasurement) {
    switch (customMeasurement.type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "";
      case TabMenus.TEMPERATURE:
        return "\u00B0C";
      case TabMenus.HUMDITY:
        return "%";
      case TabMenus.CO2:
        return "ppm";
      case TabMenus.RODENTS:
        return "";
      case TabMenus.GAS:
        return "ppm";
      case TabMenus.OXYGEN:
        return "%";
      case TabMenus.SMOKE:
        return "";
      case TabMenus.AIRFLOW:
        return "L/min";
    }
  }

  /*@override
  void dispose() {
    Get.log("Called dispose");
    _animationController.dispose();
    measurementHighAnimation.removeListener(() {});
    super.dispose();
  }*/

  @override
  void onClose() {
    Get.log("Called onClose");
    _animationController.dispose();
    measurementHighAnimation.removeListener(() {});
    // super.onClose();
  }
}

enum TabMenus {
  ALL,
  DOORS,
  TEMPERATURE,
  HUMDITY,
  CO2,
  RODENTS,
  GAS,
  OXYGEN,
  SMOKE,
  AIRFLOW
}

class CustomMeasurement {
  final double value;
  final String time;
  final String name;
  final TabMenus type;
  final String id;

  CustomMeasurement(this.value, this.type, this.time, this.name, this.id);
}

class WarehouseData {
  DummyMeasurementDataModel model;
  SensorIdentification sensorIdentification;

  WarehouseData(this.model, this.sensorIdentification);
}

class SensorIdentification {
  String id;
  TabMenus tabMenus;

  SensorIdentification(this.id, this.tabMenus);
}
