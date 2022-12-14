import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/color_helper.dart';
import 'package:warehouse_user/helper/models/godown_model.dart';
import 'package:warehouse_user/helper/models/warehouse_model.dart';

import 'models/alert_sensor_data.dart';

void navigateScreen(BuildContext context, String route, {dynamic data}) {}

class AppMethods {
  static GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  static double DEFAULT_PADDING = 10;
  static String ENCRYPTION_KEY = "zd9Rz1CNGrSVbkrZz72MkNBcsaDr79uW";

  static String RodentMSG = "Please take corrective and preventive actions";
  static String humidityMSG = "Please open warehouse doors for ventilation";
  static String temperatureMSG = "Please open warehouse doors for ventilation";
  static String co2MSG = "Please check for potential infestation";
  static String fireSmokeMSG = "Critical Alert: Please check immediately";
  static String gasMSG = "Check Level of Phosphine Gas in the godown";
  static String o2MSG = "Check Oxygen Level";
  static String doorMSG = "Please check if entry is authorised";
  static int ERROR_CODE = -404;
  static int SENSOR_AMBIENT = 1;
  static int SENSOR_CO2 = 2;
  static int SENSOR_AIRFLOW = 3;
  static int SENSOR_OXYGEN = 4;
  static int SENSOR_PHOSPHENE = 5;
  static int SENSOR_RODENT = 6;
  static int SENSOR_SMOKE = 7;
  static int SENSOR_DOOR = 8;

  static String SENSOR_TYPE_AMBIENT = "AMBIENT";
  static String SENSOR_TYPE_CO2 = "CO2";
  static String SENSOR_TYPE_AIRFLOW = "AIRFLOW";
  static String SENSOR_TYPE_OXYGEN = "OXYGEN";
  static String SENSOR_TYPE_PHOSPHENE = "PHOSPHENE";
  static String SENSOR_TYPE_RODENT = "RODENT";
  static String SENSOR_TYPE_SMOKE = "SMOKE";
  static String SENSOR_TYPE_DOOR = "DOOR";

  static String getBase64String(String filePath) {
    File imageFile = File(filePath);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static String formatHHMMSS(int seconds) {
    final hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final minutes = (seconds / 60).truncate();

    final hoursStr = (hours).toString().padLeft(2, '0');
    final minutesStr = (minutes).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  static List<AlertSensorData> setAlerts(
      GodownModel item, WarehouseModel warehouseModel) {
    List<AlertSensorData> alerts = [];
    var _currentTime = DateTime.now();
    var time = DateTime(2022, 1, 1, _currentTime.hour, _currentTime.minute,
        _currentTime.second);
    if (item.topInnerSensor != null && item.topInnerSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.topInnerSensor!, warehouseModel, time));
    }
    if (item.topOuterSensor != null && item.topOuterSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.topOuterSensor!, warehouseModel, time));
    }
    if (item.rightInnerSensor != null && item.rightInnerSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.rightInnerSensor!, warehouseModel, time));
    }
    if (item.rightOuterSensor != null && item.rightOuterSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.rightOuterSensor!, warehouseModel, time));
    }
    if (item.bottomInnerSensor != null && item.bottomInnerSensor!.isNotEmpty) {
      alerts
          .addAll(setDataAlert(item.bottomInnerSensor!, warehouseModel, time));
    }
    if (item.bottomOuterSensor != null && item.bottomOuterSensor!.isNotEmpty) {
      alerts
          .addAll(setDataAlert(item.bottomOuterSensor!, warehouseModel, time));
    }
    if (item.leftInnerSensor != null && item.leftInnerSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.leftInnerSensor!, warehouseModel, time));
    }
    if (item.leftOuterSensor != null && item.leftOuterSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.leftOuterSensor!, warehouseModel, time));
    }
    if (item.centerSensor != null && item.centerSensor!.isNotEmpty) {
      alerts.addAll(setDataAlert(item.centerSensor!, warehouseModel, time));
    }
    return alerts;
  }

  static List<AlertSensorData> setDataAlert(
    List<SensorData> sensors,
    WarehouseModel warehouseModel,
    DateTime time,
  ) {
    List<AlertSensorData> alerts = [];
    for (var data in sensors) {
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        if (double.tryParse("${data.humidity}") != null &&
            double.tryParse("${warehouseModel.humidityHigher}") != null &&
            double.tryParse("${warehouseModel.humidityLower}") != null &&
            (double.parse("${data.humidity}") >=
                    double.parse("${warehouseModel.humidityHigher}") ||
                double.parse("${data.humidity}") <=
                    double.parse("${warehouseModel.humidityLower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.humidity?.toStringAsFixed(2)} %",
              message: humidityMSG,
              iconPath: "asset/drop_high.png",
              type: "Humidity",
            ),
          );
          //break;
        }
        if (double.tryParse("${data.co2}") != null &&
            double.tryParse("${warehouseModel.co2Higher}") != null &&
            double.tryParse("${warehouseModel.co2Lower}") != null &&
            (double.parse("${data.co2}") >=
                    double.parse("${warehouseModel.co2Higher}") ||
                double.parse("${data.co2}") <=
                    double.parse("${warehouseModel.co2Lower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.co2?.toStringAsFixed(2)} ppm",
              message: co2MSG,
              iconPath: "asset/cloud_high.png",
              type: "CO2",
            ),
          );
          //break;
        }
        if (double.tryParse("${data.temperature}") != null &&
            double.tryParse("${warehouseModel.temperatureHigher}") != null &&
            double.tryParse("${warehouseModel.temperatureLower}") != null &&
            (double.parse("${data.temperature}") >=
                    double.parse("${warehouseModel.temperatureHigher}") ||
                double.parse("${data.temperature}") <=
                    double.parse("${warehouseModel.temperatureLower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.temperature?.toStringAsFixed(2)} °C",
              message: temperatureMSG,
              iconPath: "asset/temperature_high.png",
              type: "Temperature",
            ),
          );
          //break;
        }
        if (double.tryParse("${data.pressure}") != null &&
            double.tryParse("${warehouseModel.pressureHigher}") != null &&
            double.tryParse("${warehouseModel.pressureLower}") != null &&
            (double.parse("${data.pressure}") >=
                    double.parse("${warehouseModel.pressureHigher}") ||
                double.parse("${data.pressure}") <=
                    double.parse("${warehouseModel.pressureLower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.pressure} hPa",
              message: temperatureMSG,
              iconPath: "asset/pressure_high.png",
              type: "Pressure",
            ),
          );
          //break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        if (double.tryParse("${data.co2}") != null &&
            double.tryParse("${warehouseModel.co2Higher}") != null &&
            double.tryParse("${warehouseModel.co2Lower}") != null &&
            (double.parse("${data.co2}") >=
                    double.parse("${warehouseModel.co2Higher}") ||
                double.parse("${data.co2}") <=
                    double.parse("${warehouseModel.co2Lower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.co2?.toStringAsFixed(2)} ppm",
              message: co2MSG,
              iconPath: "asset/cloud_high.png",
              type: "CO2",
            ),
          );
          //break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        if (data.rodentEnable != null) {
          if (data.rodentEnable ?? false) {
            alerts.add(
              AlertSensorData(
                name: data.name,
                time: data.time,
                value: "!",
                message: RodentMSG,
                iconPath: "asset/rat.png",
                type: "Rodent",
              ),
            );
            //break;
          }
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        var haveNormal =
            time.isAfter(DateTime.parse(warehouseModel.doorTimeStart ?? "")) &&
                time.isBefore(DateTime.parse(warehouseModel.doorTimeEnd ?? ""));
        if (!haveNormal) {
          if (data.doorOpen != null) {
            if (data.doorOpen ?? false) {
              alerts.add(
                AlertSensorData(
                  name: data.name,
                  time: data.time,
                  value: "",
                  message: doorMSG,
                  type: "Door",
                ),
              );
              //break;
            }
          }
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        if (double.tryParse("${data.temperature}") != null &&
            double.tryParse("${warehouseModel.temperatureHigher}") != null &&
            double.tryParse("${warehouseModel.temperatureLower}") != null &&
            (double.parse("${data.temperature}") >=
                    double.parse("${warehouseModel.temperatureHigher}") ||
                double.parse("${data.temperature}") <=
                    double.parse("${warehouseModel.temperatureLower}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.temperature?.toStringAsFixed(2)} °C",
              message: temperatureMSG,
              iconPath: "asset/temperature_high.png",
              type: "Temperature",
            ),
          );
          //break;
        }
        if (double.tryParse("${data.air}") != null &&
            double.tryParse("${warehouseModel.airflowLevel}") != null &&
            (double.parse("${data.air}") >=
                double.parse("${warehouseModel.airflowLevel}"))) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.air?.toStringAsFixed(2)} sim",
              message: temperatureMSG,
              iconPath: "asset/fan_high.png",
              type: "Air",
            ),
          );
          //break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        if (double.tryParse("${data.oxygen}") != null &&
            double.tryParse("${warehouseModel.oxygenLevel}") != null &&
            double.parse("${data.oxygen}") <=
                double.parse("${warehouseModel.temperatureLower}")) {
          alerts.add(
            AlertSensorData(
              name: data.name,
              time: data.time,
              value: "${data.oxygen?.toStringAsFixed(2)} %",
              message: o2MSG,
              iconPath: "asset/oxygen.png",
              type: "Oxygen",
            ),
          );
          //break;
        }
      }
    }
    return alerts;
  }

  static Color getMeasurementColor(double value, double lower, double higher) {
    if (value <= higher && value >= lower) {
      return greenColor;
    } else {
      return redColor;
    }
  }

  static bool isNormal(double value, double lower, double higher) {
    if (value <= higher && value >= lower) {
      return true;
    } else {
      return false;
    }
  }
}
