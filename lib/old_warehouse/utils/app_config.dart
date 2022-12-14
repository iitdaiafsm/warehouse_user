import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';

import 'app_size.dart';
import 'color_filter.dart';
import 'colors.dart';
import 'fsm_resource.dart';

class AppConfig {
  static double DEFAULT_PADDING = 2;
  static double BORDER_WIDTH = 0.2;
  static double FONT_SIZE_H1 = 2.4;
  static double FONT_SIZE_H2 = 2.2;
  static double FONT_SIZE_H3 = 2.0;
  static double FONT_SIZE_H4 = 1.8;
  static double FONT_SIZE_H5 = 1.6;
  static double FONT_SIZE_H6 = 1.4;
  static double FONT_SIZE_H7 = 1.2;
  static double FONT_SIZE_H8 = 1.0;
  static double FONT_SIZE_H9 = 0.8;
  static double FONT_SIZE_H10 = 0.6;
  static double FONT_SIZE_H11 = 0.4;
  static double FONT_SIZE_H12 = 0.2;

  static String INFLUXDB_TOKEN =
      "IQDuRsScn2SO48P_rmH3UQr1bcOlhuMhdsBrCvgXrrTVG814HAHEkqgtvbDPm6TRc5Zb6K3zHvS4hPEgGKGd-g==";
  static String INFLUXDB_ORG = "IITD-WFP";
  static String INFLUXDB_URL = "https://www.wfp-smartwarehouse.in:8086";

  static String SELECTED_VALUE = "";

  static int LOWER_HUMIDITY = 20;
  static int HIGHER_HUMIDITY = 70;

  static int LOWER_TEMPERATURE = 27;
  static int HIGHER_TEMPERATURE = 39;

  static int LOWER_CO2 = 500;
  static int HIGHER_CO2 = 1500;

  static double SMOKE_HIGH = 0.1;

  static int LOWER_AIR = -1;
  static int HIGHER_AIR = 1;

  static int LOWER_GAS = 0;
  static int HIGHER_GAS = 10;

  static int BATTERY_LEVEL = 25;

  static double OXYGEN_LEVEL = 20.75;
  static double DOOR_LEVEL = 0.8;
  static double RODENT_LEVEL = 0.5;
  /*static int LOWER_HUMIDITY = 0;
  static int HIGHER_HUMIDITY = 25;

  static int LOWER_TEMPERATURE = 27;
  static int HIGHER_TEMPERATURE = 30;

  static int LOWER_CO2 = 200;
  static int HIGHER_CO2 = 300;

  static double SMOKE_HIGH = -0.1;

  static int LOWER_AIR = -0;
  static int HIGHER_AIR = 0;

  static int LOWER_GAS = -29;
  static int HIGHER_GAS = -22;

  static int BATTERY_LEVEL = 99;

  static int OXYGEN_LEVEL = 30;
  static double DOOR_LEVEL = 0.6;
  static double RODENT_LEVEL = 0.6;*/

  static String getFormattedTime(String? time) {
    DateTime sensorDateTime = DateTime.parse(time!).toLocal();
    final String formattedTime =
        DateFormat("dd MMM, yyyy | hh:mm:ss a").format(sensorDateTime);
    return formattedTime;
  }

  static String getFormattedOnlyTime(String? time) {
    DateTime sensorDateTime = DateTime.parse(time!).toLocal();
    final String formattedTime = DateFormat("hh:mm a").format(sensorDateTime);
    return formattedTime;
  }

  static String getFormattedOnlyDate(String? time) {
    DateTime sensorDateTime = DateTime.parse(time!).toLocal();
    final String formattedTime =
        DateFormat("dd MMM, yyyy").format(sensorDateTime);
    return formattedTime;
  }

  static String getFormattedByFormat(String? time, String formater) {
    DateTime sensorDateTime = DateTime.parse(time!).toLocal();
    final String formattedTime = DateFormat(formater).format(sensorDateTime);
    return formattedTime;
  }

  static String convertDateFormat(
      String dateTimeString, String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }

  static bool isSensorStopped(String? time) {
    DateTime sensorDateTime = DateTime.parse(time!).toLocal();
    DateTime currentTime = DateTime.now();

    var difference = currentTime.difference(sensorDateTime);
    return difference.inMinutes >= 5;
  }

  static getGrayWidget(String imagePath, BuildContext context) {
    return Column(
      children: [
        Container(
          width: getWidth(2.3, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  getWidth(0.25, context),
                ),
              ),
              color: appWhiteColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.blueGrey,
                  blurRadius: getWidth(0.25, context),
                  spreadRadius: getWidth(0.25, context),
                ),
              ]),
          padding: EdgeInsets.all(getWidth(0.25, context)),
          child: ColorFiltered(
            colorFilter:
                ColorFilter.matrix(ColorFilterGenerator.saturationAdjustMatrix(
              value: -1,
            )),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
      ],
    );
  }

  static List<CustomMeasurement> getAlertList(
      DummyMeasurementDataModel dummyMeasurementDataModel) {
    DateTime todayTime = DateTime.now();

    DateTime morningTime =
        DateTime(todayTime.year, todayTime.month, todayTime.day, 6, 0, 0);
    DateTime eveningTime =
        DateTime(todayTime.year, todayTime.month, todayTime.day, 19, 30, 0);

    bool isDangerTimeZone =
        (todayTime.isAfter(eveningTime) || todayTime.isBefore(morningTime));

    // Get.log("Are you in danger time zone : $isDangerTimeZone");
    List<CustomMeasurement> highMeasurement = [];

    if (dummyMeasurementDataModel.measurement != null) {
      if (dummyMeasurementDataModel.measurement!.leftMeasurement != null &&
          dummyMeasurementDataModel.measurement!.leftMeasurement!.isNotEmpty) {
        for (var item
            in dummyMeasurementDataModel.measurement!.leftMeasurement!) {
          if (!isSensorStopped(item.time) &&
              item.humidity != null &&
              (item.humidity! > AppConfig.HIGHER_HUMIDITY)) {
            highMeasurement.add(CustomMeasurement(item.humidity!,
                TabMenus.HUMDITY, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.temperature != null &&
              (item.temperature! > AppConfig.HIGHER_TEMPERATURE)) {
            highMeasurement.add(CustomMeasurement(item.temperature!,
                TabMenus.TEMPERATURE, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.co2 != null &&
              (item.co2! > AppConfig.HIGHER_CO2)) {
            highMeasurement.add(CustomMeasurement(
                item.co2!, TabMenus.CO2, item.time!, item.name!, item.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.measurement!.topMeasurement != null &&
          dummyMeasurementDataModel.measurement!.topMeasurement!.isNotEmpty) {
        for (var item
            in dummyMeasurementDataModel.measurement!.topMeasurement!) {
          if (!isSensorStopped(item.time) &&
              item.humidity != null &&
              (item.humidity! > AppConfig.HIGHER_HUMIDITY)) {
            highMeasurement.add(CustomMeasurement(item.humidity!,
                TabMenus.HUMDITY, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.temperature != null &&
              (item.temperature! > AppConfig.HIGHER_TEMPERATURE)) {
            highMeasurement.add(CustomMeasurement(item.temperature!,
                TabMenus.TEMPERATURE, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.co2 != null &&
              (item.co2! > AppConfig.HIGHER_CO2)) {
            highMeasurement.add(CustomMeasurement(
                item.co2!, TabMenus.CO2, item.time!, item.name!, item.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.measurement!.rightMeasurement != null &&
          dummyMeasurementDataModel.measurement!.rightMeasurement!.isNotEmpty) {
        for (var item
            in dummyMeasurementDataModel.measurement!.rightMeasurement!) {
          if (!isSensorStopped(item.time) &&
              item.humidity != null &&
              (item.humidity! > AppConfig.HIGHER_HUMIDITY)) {
            highMeasurement.add(CustomMeasurement(item.humidity!,
                TabMenus.HUMDITY, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.temperature != null &&
              (item.temperature! > AppConfig.HIGHER_TEMPERATURE)) {
            highMeasurement.add(CustomMeasurement(item.temperature!,
                TabMenus.TEMPERATURE, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.co2 != null &&
              (item.co2! > AppConfig.HIGHER_CO2)) {
            highMeasurement.add(CustomMeasurement(
                item.co2!, TabMenus.CO2, item.time!, item.name!, item.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.measurement!.bottomMeasurement != null &&
          dummyMeasurementDataModel
              .measurement!.bottomMeasurement!.isNotEmpty) {
        for (var item
            in dummyMeasurementDataModel.measurement!.bottomMeasurement!) {
          if (!isSensorStopped(item.time) &&
              item.humidity != null &&
              (item.humidity! > AppConfig.HIGHER_HUMIDITY)) {
            highMeasurement.add(CustomMeasurement(item.humidity!,
                TabMenus.HUMDITY, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.temperature != null &&
              (item.temperature! > AppConfig.HIGHER_TEMPERATURE)) {
            highMeasurement.add(CustomMeasurement(item.temperature!,
                TabMenus.TEMPERATURE, item.time!, item.name!, item.id!));
          }
          if (!isSensorStopped(item.time) &&
              item.co2 != null &&
              (item.co2! > AppConfig.HIGHER_CO2)) {
            highMeasurement.add(CustomMeasurement(
                item.co2!, TabMenus.CO2, item.time!, item.name!, item.id!));
          }
        }
      }
    }
    if (dummyMeasurementDataModel.leftMotionDetectorValues != null &&
        dummyMeasurementDataModel.leftMotionDetectorValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.leftMotionDetectorValues!) {
        if (!isSensorStopped(item.time) &&
            item.value != null &&
            item.value! > RODENT_LEVEL) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.RODENTS, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.topMotionDetectorValues != null &&
        dummyMeasurementDataModel.topMotionDetectorValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.topMotionDetectorValues!) {
        if (!isSensorStopped(item.time) &&
            item.value != null &&
            item.value! > RODENT_LEVEL) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.RODENTS, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.rightMotionDetectorValues != null &&
        dummyMeasurementDataModel.rightMotionDetectorValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.rightMotionDetectorValues!) {
        if (!isSensorStopped(item.time) &&
            item.value != null &&
            item.value! > RODENT_LEVEL) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.RODENTS, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.bottomMotionDetectorValues != null &&
        dummyMeasurementDataModel.bottomMotionDetectorValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.bottomMotionDetectorValues!) {
        if (!isSensorStopped(item.time) &&
            item.value != null &&
            item.value! > RODENT_LEVEL) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.RODENTS, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.airFlows != null &&
        dummyMeasurementDataModel.airFlows!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.airFlows!) {
        if (!isSensorStopped(item.time) &&
            !(item.air! <= HIGHER_AIR && item.air! >= LOWER_AIR)) {
          highMeasurement.add(CustomMeasurement(
              item.air!, TabMenus.AIRFLOW, item.time!, item.name!, item.id!));
        }
        if (!isSensorStopped(item.time) &&
            item.temperature != null &&
            (item.temperature! > AppConfig.HIGHER_TEMPERATURE)) {
          highMeasurement.add(CustomMeasurement(item.temperature!,
              TabMenus.TEMPERATURE, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.oxygenValues != null &&
        dummyMeasurementDataModel.oxygenValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.oxygenValues!) {
        if (!isSensorStopped(item.time) && (item.value! < OXYGEN_LEVEL)) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.OXYGEN, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.gasValues != null &&
        dummyMeasurementDataModel.gasValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.gasValues!) {
        if (!isSensorStopped(item.time) &&
            (item.value! > AppConfig.HIGHER_GAS)) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.GAS, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.smokeValues != null &&
        dummyMeasurementDataModel.smokeValues!.isNotEmpty) {
      for (var item in dummyMeasurementDataModel.smokeValues!) {
        if (!isSensorStopped(item.time) && item.value! > AppConfig.SMOKE_HIGH) {
          highMeasurement.add(CustomMeasurement(
              item.value!, TabMenus.SMOKE, item.time!, item.name!, item.id!));
        }
      }
    }
    if (dummyMeasurementDataModel.doorsData != null) {
      if (dummyMeasurementDataModel.doorsData!.leftDoors != null &&
          dummyMeasurementDataModel.doorsData!.leftDoors!.isNotEmpty) {
        for (var element in dummyMeasurementDataModel.doorsData!.leftDoors!) {
          if (isDangerTimeZone && element.isRunning!) {
            highMeasurement.add(CustomMeasurement(1.0, TabMenus.DOORS,
                element.time!, element.name!, element.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.doorsData!.topDoors != null &&
          dummyMeasurementDataModel.doorsData!.topDoors!.isNotEmpty) {
        for (var element in dummyMeasurementDataModel.doorsData!.topDoors!) {
          if (isDangerTimeZone && element.isRunning!) {
            highMeasurement.add(CustomMeasurement(1.0, TabMenus.DOORS,
                element.time!, element.name!, element.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.doorsData!.rightDoors != null &&
          dummyMeasurementDataModel.doorsData!.rightDoors!.isNotEmpty) {
        for (var element in dummyMeasurementDataModel.doorsData!.rightDoors!) {
          if (isDangerTimeZone && element.isRunning!) {
            highMeasurement.add(CustomMeasurement(1.0, TabMenus.DOORS,
                element.time!, element.name!, element.id!));
          }
        }
      }
      if (dummyMeasurementDataModel.doorsData!.bottomDoors != null &&
          dummyMeasurementDataModel.doorsData!.bottomDoors!.isNotEmpty) {
        for (var element in dummyMeasurementDataModel.doorsData!.bottomDoors!) {
          if (isDangerTimeZone && element.isRunning!) {
            highMeasurement.add(CustomMeasurement(1.0, TabMenus.DOORS,
                element.time!, element.name!, element.id!));
          }
        }
      }
    }

    return highMeasurement;
  }

  static Widget getHoverWidget(
      String title, List<KeyValueClass> keyValueList, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              getWidth(0.25, context),
            ),
          ),
          color: appWhiteColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: Colors.blueGrey,
              blurRadius: getWidth(0.25, context),
              spreadRadius: getWidth(0.25, context),
            ),
          ]),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(0.5, context), vertical: getWidth(0.7, context)),
      child: getHoverInnerWidget(title, keyValueList, context),
    );
  }

  static Widget getHoverInnerWidget(
      String title, List<KeyValueClass> keyValueList, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getWidth(0.4, context)),
      width: getWidth(15, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: FSMResources.FSMTextStyle(
                context: context,
                color: appPrimaryColor,
                size: AppConfig.FONT_SIZE_H9,
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              keyValueList.length,
              (index) => Row(
                children: [
                  SizedBox(
                    width: getWidth(6, context),
                    child: Text(
                      keyValueList[index].key!,
                      style: FSMResources.FSMTextStyle(
                          context: context,
                          size: AppConfig.FONT_SIZE_H9,
                          color: appTextDarkColor,
                          type: TextStyleType.bold),
                    ),
                  ),
                  Text(
                    ":",
                    style: FSMResources.FSMTextStyle(
                        context: context,
                        size: AppConfig.FONT_SIZE_H9,
                        color: appTextDarkColor,
                        type: TextStyleType.bold),
                  ),
                  Text(
                    keyValueList[index].value!,
                    style: FSMResources.FSMTextStyle(
                      context: context,
                      size: AppConfig.FONT_SIZE_H9,
                      color: appTextDarkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color getMeasurementColor(double value, SensorType sensorType) {
    switch (sensorType) {
      case SensorType.Humidity:
        if (value > HIGHER_HUMIDITY) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }

      case SensorType.Temperature:
        if (value > HIGHER_TEMPERATURE) {
          return appDangerTextColor;
        } else if (value <= HIGHER_TEMPERATURE && value >= LOWER_TEMPERATURE) {
          return appOrangeColor;
        } else {
          return appGreenColor;
        }
      case SensorType.CO2:
        if (value > HIGHER_CO2) {
          return appDangerTextColor;
        } else if (value <= HIGHER_CO2 && value >= LOWER_CO2) {
          return appOrangeColor;
        } else {
          return appGreenColor;
        }
      case SensorType.Oxygen:
        if (value < OXYGEN_LEVEL) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }
      case SensorType.Gas:
        if (value > HIGHER_GAS) {
          return appDangerTextColor;
        } else if (value <= HIGHER_GAS && value >= LOWER_GAS) {
          return appGreenColor;
        } else {
          return appGreenColor;
        }
      case SensorType.Airflow:
        if (value < 0) {
          value = value + (2 * value);
        }
        if (value > HIGHER_AIR) {
          return appDangerTextColor;
        } else if (value <= HIGHER_AIR && value >= LOWER_AIR) {
          return appGreenColor;
        } else {
          return appDangerTextColor;
        }
      case SensorType.Smoke:
        if (value > SMOKE_HIGH) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }
    }
  }

  static double getLowParameters(String type) {
    switch (type) {
      case "temperature":
        return double.parse("$LOWER_TEMPERATURE");
      case "eco2":
        return double.parse("$LOWER_CO2");
      case "humidity":
        return double.parse("$LOWER_HUMIDITY");
      case "bat_soc":
        return double.parse("$BATTERY_LEVEL");
      case "value":
        return 0.8;
      case "gas":
        return double.parse("$LOWER_GAS");
      case "oxygen":
        return double.parse("$OXYGEN_LEVEL");
      case "airflow":
        return 0.0;
      default:
        return 0;
    }
  }

  static double getHighParameters(String type) {
    switch (type) {
      case "temperature":
        return double.parse("$HIGHER_TEMPERATURE");
      case "eco2":
        return double.parse("$HIGHER_CO2");
      case "humidity":
        return double.parse("$HIGHER_HUMIDITY");
      case "bat_soc":
        return double.parse("$BATTERY_LEVEL");
      case "value":
        return 1;
      case "gas":
        return double.parse("$HIGHER_GAS");
      case "oxygen":
        return double.parse("$OXYGEN_LEVEL");
      case "airflow":
        return 1.0;
      default:
        return 1;
    }
  }

  static double getLowBoundaries(String type) {
    switch (type) {
      case "temperature":
        return double.parse("$LOWER_TEMPERATURE");
      case "eco2":
        return 300;
      case "humidity":
        return 0;
      case "bat_soc":
        return double.parse("$BATTERY_LEVEL");
      case "value":
        return 0.8;
      case "gas":
        return -3.5;
      case "oxygen":
        return double.parse("$OXYGEN_LEVEL");
      case "airflow":
        return -0.3;
      default:
        return 0;
    }
  }

  static double getHighBoundaries(String type) {
    switch (type) {
      case "temperature":
        return double.parse("$LOWER_TEMPERATURE");
      case "eco2":
        return 1600;
      case "humidity":
        return 100;
      case "bat_soc":
        return double.parse("$BATTERY_LEVEL");
      case "value":
        return 0.8;
      case "gas":
        return 15;
      case "oxygen":
        return double.parse("$OXYGEN_LEVEL");
      case "airflow":
        return 0.3;
      default:
        return 0;
    }
  }
}

class KeyValueClass {
  String? key;
  String? value;

  KeyValueClass({this.key, this.value});
}

enum SensorType { Humidity, Temperature, CO2, Oxygen, Gas, Airflow, Smoke }
