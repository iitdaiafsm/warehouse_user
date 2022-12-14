import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:super_tooltip/super_tooltip.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/just_the_tooltip.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/models/just_the_controller.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';

// import 'package:warehouse_user/old_warehouse/warehouse/logicper_tooltip.dart';

import '../model/dummy_measurement_model.dart';
import '../utils/color_filter.dart';

class MeasurementWidget extends StatelessWidget {
  final LeftMeasurement? measurementData;
  final Animation measurementHighAnimation;
  final AnimationController blinkAnimation;
  final Direction direction;
  final SensorPosition sensorPosition;
  final String hoverID;
  final TabMenus tabMenus;

  final JustTheController toolTipController = JustTheController();

  MeasurementWidget({
    Key? key,
    required this.measurementData,
    required this.measurementHighAnimation,
    required this.blinkAnimation,
    required this.direction,
    required this.sensorPosition,
    required this.hoverID,
    required this.tabMenus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        toolTipController.attach(
            showTooltip: ({autoClose = true, immediately = false}) async {},
            hideTooltip: ({immediately = true}) async {});
        toolTipController.showTooltip(autoClose: true, immediately: false);
      },
      child: GestureDetector(
        onLongPress: () {
          toolTipController.attach(
              showTooltip: ({autoClose = true, immediately = false}) async {},
              hideTooltip: ({immediately = true}) async {});
          toolTipController.showTooltip(autoClose: true, immediately: false);
        },
        child: JustTheTooltip(
          controller: toolTipController,
          content: AppConfig.getHoverInnerWidget(
              measurementData!.name!,
              [
                KeyValueClass(
                  key: "Date",
                  value: AppConfig.getFormattedOnlyDate(
                    measurementData!.time,
                  ),
                ),
                KeyValueClass(
                  key: "Time",
                  value: AppConfig.getFormattedOnlyTime(
                    measurementData!.time,
                  ),
                ),
                KeyValueClass(
                  key: "CO2",
                  value: "${measurementData!.co2} ppm",
                ),
                KeyValueClass(
                  key: "Humidity",
                  value: "${measurementData!.humidity} %",
                ),
                KeyValueClass(
                  key: "Temperature",
                  value: "${measurementData!.temperature} C",
                ),
                KeyValueClass(
                  key: "Battery",
                  value: "${measurementData!.battery} % ",
                ),
              ],
              context),
          child: direction == Direction.Horizontal
              ? _getHorizontalMeasurement(context)
              : _getVerticalMeasurement(context),
        ),
      ),
    );
    /*return Container(
      padding: EdgeInsets.all(
        getWidth(0.5, context),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              getWidth(0.5, context),
            ),
          ),
          color: appWhiteColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: (measurementData!.humidity! >= 75 ||
                      measurementData!.temperature! >= 75 ||
                      measurementData!.co2! >= 75)
                  ? appDangerTextColor
                  : appGreenColor,
              blurRadius: (measurementData!.humidity! >= 75 ||
                      measurementData!.temperature! >= 75 ||
                      measurementData!.co2! >= 75)
                  ? measurementHighAnimation.value
                  : getWidth(0.5, context),
              spreadRadius: (measurementData!.humidity! >= 75 ||
                      measurementData!.temperature! >= 75 ||
                      measurementData!.co2! >= 75)
                  ? measurementHighAnimation.value
                  : getWidth(0.5, context),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getWidget(
              measurementData!.humidity! < 75
                  ? "asset/drop_low.png"
                  : "asset/drop_high.png",
              "H",
              "${measurementData!.humidity!}%",
              measurementData!.humidity! < 75
                  ? appPrimaryColor
                  : appDangerTextColor,
              context),
          SizedBox(
            height: getWidth(0.3, context),
          ),
          _getWidget(
              measurementData!.temperature! < 75
                  ? "asset/temperature_low.png"
                  : "asset/temperature_high.png",
              "T",
              "${measurementData!.temperature!} C",
              measurementData!.temperature! < 75
                  ? appPrimaryColor
                  : appDangerTextColor,
              context),
          SizedBox(
            height: getWidth(0.1, context),
          ),
          _getWidget(
              measurementData!.co2! < 75
                  ? "asset/cloud_low.png"
                  : "asset/cloud_high.png",
              "C",
              "${measurementData!.co2!}%",
              measurementData!.co2! < 75 ? appPrimaryColor : appDangerTextColor,
              context),
        ],
      ),
    );*/
  }

  Widget _getWidget(String filePath, String title, String value,
      Color textColor, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          filePath,
          width: getWidth(1, context),
          height: getWidth(1, context),
        ),
        SizedBox(
          width: getWidth(1, context),
        ),
        Text(
          title,
          style: FSMResources.FSMTextStyle(
            type: TextStyleType.bold,
            color: textColor,
            size: AppConfig.FONT_SIZE_H9,
            context: context,
          ),
        ),
        SizedBox(
          width: getWidth(0.5, context),
        ),
        Text(
          value,
          style: FSMResources.FSMTextStyle(
            color: textColor,
            size: AppConfig.FONT_SIZE_H9,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _getVerticalMeasurement(BuildContext context) {
    bool isHumidityNormal =
        measurementData!.humidity! <= AppConfig.HIGHER_HUMIDITY;
    bool isTemperatureNormal =
        measurementData!.temperature! <= AppConfig.HIGHER_TEMPERATURE;
    bool isCO2Normal = measurementData!.co2! <= AppConfig.HIGHER_CO2;
    return AppConfig.isSensorStopped(measurementData!.time)
        ? getVerticalMeasurementGrayWidget(context)
        : Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: sensorPosition == SensorPosition.Right
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: hoverID == measurementData!.id &&
                            tabMenus == TabMenus.CO2
                        ? 1.3
                        : 1,
                    child: _getInnerVerticalWidget(
                      measurementData!.co2,
                      isCO2Normal,
                      isCO2Normal
                          ? "asset/cloud_low.png"
                          : "asset/cloud_high.png",
                      "ppm",
                      context,
                      SensorType.CO2,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(0.5, context),
                  ),
                  Transform.scale(
                    scale: hoverID == measurementData!.id &&
                            tabMenus == TabMenus.HUMDITY
                        ? 1.3
                        : 1,
                    child: _getInnerVerticalWidget(
                      measurementData!.humidity,
                      isHumidityNormal,
                      isHumidityNormal
                          ? "asset/drop_low.png"
                          : "asset/drop_high.png",
                      "%",
                      context,
                      SensorType.Humidity,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(0.5, context),
                  ),
                  Transform.scale(
                    scale: hoverID == measurementData!.id &&
                            tabMenus == TabMenus.TEMPERATURE
                        ? 1.3
                        : 1,
                    child: _getInnerVerticalWidget(
                      measurementData!.temperature,
                      isTemperatureNormal,
                      isTemperatureNormal
                          ? "asset/temperature_low.png"
                          : "asset/temperature_high.png",
                      "\u00B0C",
                      context,
                      SensorType.Temperature,
                    ),
                  )
                ],
              ),
              if (measurementData!.battery != null &&
                  measurementData!.battery! < AppConfig.BATTERY_LEVEL)
                Center(
                  child: FadeTransition(
                    opacity: blinkAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: getWidth(0.2, context),
                            blurRadius: getWidth(0.7, context),
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: getWidth(4, context),
                      ),
                    ),
                  ),
                )
            ],
          );
  }

  Widget _getHorizontalMeasurement(BuildContext context) {
    bool isHumidityNormal =
        measurementData!.humidity! <= AppConfig.HIGHER_HUMIDITY;
    bool isTemperatureNormal =
        measurementData!.temperature! <= AppConfig.HIGHER_TEMPERATURE;
    bool isCO2Normal = measurementData!.co2! <= AppConfig.HIGHER_CO2;
    return InkWell(
      onHover: (value) {
        // Get.log("IS HOVERING : ! $value");
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: sensorPosition == SensorPosition.Top
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getInnerHorizontalWidget(
                measurementData!.co2,
                isCO2Normal,
                isCO2Normal ? "asset/cloud_low.png" : "asset/cloud_high.png",
                "ppm",
                context,
                SensorType.CO2,
              ),
              SizedBox(
                width: getWidth(0.5, context),
              ),
              _getInnerHorizontalWidget(
                measurementData!.humidity,
                isHumidityNormal,
                isHumidityNormal ? "asset/drop_low.png" : "asset/drop_high.png",
                "%",
                context,
                SensorType.Humidity,
              ),
              SizedBox(
                width: getWidth(0.5, context),
              ),
              _getInnerHorizontalWidget(
                  measurementData!.temperature,
                  isTemperatureNormal,
                  isTemperatureNormal
                      ? "asset/temperature_low.png"
                      : "asset/temperature_high.png",
                  "\u00B0C",
                  context,
                  SensorType.Temperature),
            ],
          ),
          if (measurementData!.battery != null &&
              measurementData!.battery! < AppConfig.BATTERY_LEVEL)
            FadeTransition(
              opacity: blinkAnimation,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent,
                      spreadRadius: getWidth(0.2, context),
                      blurRadius: getWidth(0.7, context),
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  "asset/battery-status.png",
                  width: getWidth(4, context),
                ),
              ),
            ),
        ],
      ),
    );
  }

  _getInnerHorizontalWidget(double? value, bool isNormal, String imagePath,
      String unit, BuildContext context, SensorType sensorType) {
    return Column(
      children: [
        if (sensorPosition == SensorPosition.Bottom)
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
                    color: AppConfig.getMeasurementColor(value!, sensorType),
                    blurRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                    spreadRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                  ),
                ]),
            padding: EdgeInsets.all(getWidth(0.25, context)),
            child: Column(
              children: [
                Text(
                  "$value",
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H9),
                ),
                Text(
                  unit,
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: 0.6),
                )
              ],
            ),
          ),
        if (sensorPosition == SensorPosition.Bottom)
          SizedBox(
            height: getHeight(0.5, context),
          ),
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
                  color: AppConfig.getMeasurementColor(value!, sensorType),
                  blurRadius: !isNormal
                      ? measurementHighAnimation.value
                      : getWidth(0.25, context),
                  spreadRadius: !isNormal
                      ? measurementHighAnimation.value
                      : getWidth(0.25, context),
                ),
              ]),
          padding: EdgeInsets.all(getWidth(0.25, context)),
          child: Image.asset(imagePath),
        ),
        if (sensorPosition == SensorPosition.Top)
          SizedBox(
            height: getHeight(0.5, context),
          ),
        if (sensorPosition == SensorPosition.Top)
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
                    color: AppConfig.getMeasurementColor(value, sensorType),
                    blurRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                    spreadRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                  ),
                ]),
            padding: EdgeInsets.all(getWidth(0.25, context)),
            child: Column(
              children: [
                Text(
                  "$value",
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H9),
                ),
                Text(
                  unit,
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: 0.6),
                )
              ],
            ),
          )
      ],
    );
  }

  _getInnerVerticalWidget(double? value, bool isNormal, String imagePath,
      String unit, BuildContext context, SensorType sensorType) {
    return Row(
      children: [
        if (sensorPosition == SensorPosition.Right)
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
                    color: AppConfig.getMeasurementColor(value!, sensorType),
                    blurRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                    spreadRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                  ),
                ]),
            padding: EdgeInsets.all(getWidth(0.25, context)),
            child: Column(
              children: [
                Text(
                  "$value",
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H9),
                ),
                Text(
                  unit,
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: 0.6),
                )
              ],
            ),
          ),
        if (sensorPosition == SensorPosition.Right)
          SizedBox(
            width: getWidth(0.5, context),
          ),
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
                  color: AppConfig.getMeasurementColor(value!, sensorType),
                  blurRadius: !isNormal
                      ? measurementHighAnimation.value
                      : getWidth(0.25, context),
                  spreadRadius: !isNormal
                      ? measurementHighAnimation.value
                      : getWidth(0.25, context),
                ),
              ]),
          padding: EdgeInsets.all(getWidth(0.25, context)),
          child: Image.asset(imagePath),
        ),
        if (sensorPosition == SensorPosition.Left)
          SizedBox(
            width: getWidth(0.5, context),
          ),
        if (sensorPosition == SensorPosition.Left)
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
                    color: AppConfig.getMeasurementColor(value, sensorType),
                    blurRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                    spreadRadius: !isNormal
                        ? measurementHighAnimation.value
                        : getWidth(0.25, context),
                  ),
                ]),
            padding: EdgeInsets.all(getWidth(0.25, context)),
            child: Column(
              children: [
                Text(
                  "$value",
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H9),
                ),
                Text(
                  unit,
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: AppConfig.getMeasurementColor(value, sensorType),
                      type: TextStyleType.bold,
                      size: 0.6),
                )
              ],
            ),
          )
      ],
    );
  }

  _getInnerVerticalGrayWidget(String imagePath, BuildContext context) {
    return Container(
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
    );
  }

  getVerticalMeasurementGrayWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getInnerVerticalGrayWidget(
          "asset/cloud_low.png",
          context,
        ),
        SizedBox(
          height: getHeight(0.5, context),
        ),
        _getInnerVerticalGrayWidget(
          "asset/drop_low.png",
          context,
        ),
        SizedBox(
          height: getHeight(0.5, context),
        ),
        _getInnerVerticalGrayWidget(
          "asset/temperature_low.png",
          context,
        ),
      ],
    );
  }
}

enum Direction { Vertical, Horizontal }

enum SensorPosition { Top, Right, Bottom, Left }
