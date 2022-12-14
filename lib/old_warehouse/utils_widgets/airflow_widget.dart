import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/just_the_tooltip.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/models/just_the_controller.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';

import '../model/dummy_measurement_model.dart';

class AirflowWidget extends StatelessWidget {
  final AirflowData? airflowData;
  final Animation measurementHighAnimation;
  final AnimationController blinkAnimation;
  final String hoverID;
  final TabMenus tabMenus;

  AirflowWidget({
    Key? key,
    required this.airflowData,
    required this.measurementHighAnimation,
    required this.hoverID,
    required this.tabMenus,
    required this.blinkAnimation,
  }) : super(key: key);
  final JustTheController controller = JustTheController();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        controller.attach(
            showTooltip: ({autoClose = true, immediately = false}) async {},
            hideTooltip: ({immediately = true}) async {});
        controller.showTooltip(autoClose: true, immediately: false);
      },
      child: GestureDetector(
        onLongPress: () {
          controller.attach(
              showTooltip: ({autoClose = true, immediately = false}) async {},
              hideTooltip: ({immediately = true}) async {});
          controller.showTooltip(autoClose: true, immediately: false);
        },
        child: JustTheTooltip(
          controller: controller,
          content: AppConfig.getHoverInnerWidget(
              airflowData!.name!,
              [
                KeyValueClass(
                  key: "Date",
                  value: AppConfig.getFormattedOnlyDate(
                    airflowData!.time,
                  ),
                ),
                KeyValueClass(
                  key: "Time",
                  value: AppConfig.getFormattedOnlyTime(
                    airflowData!.time,
                  ),
                ),
                KeyValueClass(
                  key: "Air",
                  value: "${airflowData!.air} L/min",
                ),
                KeyValueClass(
                  key: "Temperature",
                  value: "${airflowData!.temperature} \u00B0C",
                ),
                KeyValueClass(
                  key: "Battery",
                  value: "${airflowData!.battery} %",
                ),
              ],
              context),
          child: Container(
            child: AppConfig.isSensorStopped(airflowData!.time)
                ? AppConfig.getGrayWidget("asset/fan_low.png", context)
                : Transform.scale(
                    scale: hoverID == airflowData!.id ? 1.3 : 1,
                    child: _getHorizontalMeasurement(context),
                  ),
            margin: EdgeInsets.all(
              getWidth(0.5, context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHorizontalMeasurement(BuildContext context) {
    bool isAirflowNormal = airflowData!.air! >= AppConfig.LOWER_AIR &&
        airflowData!.air! <= AppConfig.HIGHER_AIR;
    bool isTemperatureNormal =
        airflowData!.temperature! <= AppConfig.HIGHER_TEMPERATURE;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getInnerHorizontalWidget(
              airflowData!.air,
              isAirflowNormal,
              "asset/fan_low.png",
              "L/min",
              context,
              SensorType.Airflow,
            ),
            SizedBox(
              width: getWidth(0.5, context),
            ),
            _getInnerHorizontalWidget(
              airflowData!.temperature,
              isTemperatureNormal,
              isTemperatureNormal
                  ? "asset/temperature_low.png"
                  : "asset/temperature_high.png",
              "\u00B0C",
              context,
              SensorType.Temperature,
            ),
          ],
        ),
        if (airflowData!.battery != null &&
            airflowData!.battery! < AppConfig.BATTERY_LEVEL)
          Center(
            child: FadeTransition(
              opacity: blinkAnimation,
              child: Container(
                alignment: Alignment.center,
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
          )
      ],
    );
  }

  _getInnerHorizontalWidget(double? value, bool isNormal, String imagePath,
      String unit, BuildContext context, SensorType sensorType) {
    return Column(
      children: [
        Container(
          width: getWidth(2.5, context),
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
        // if (!isNormal)
        SizedBox(
          height: getHeight(0.5, context),
        ),
        // if (!isNormal)
        Container(
          width: getWidth(2.5, context),
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
                // maxLines: 1,
                style: FSMResources.FSMTextStyle(
                    context: context,
                    color: AppConfig.getMeasurementColor(value, sensorType),
                    type: TextStyleType.bold,
                    size: AppConfig.FONT_SIZE_H10),
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
      String unit, BuildContext context) {
    return Row(
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
                  color: !isNormal ? appDangerTextColor : appGreenColor,
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
        if (!isNormal)
          SizedBox(
            width: getWidth(0.5, context),
          ),
        if (!isNormal)
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
                    color: !isNormal ? appDangerTextColor : appGreenColor,
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
                      color: appDangerTextColor,
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H9),
                ),
                Text(
                  unit,
                  maxLines: 1,
                  style: FSMResources.FSMTextStyle(
                      context: context,
                      color: appDangerTextColor,
                      type: TextStyleType.bold,
                      size: 0.6),
                )
              ],
            ),
          )
      ],
    );
  }
}

enum Direction { Vertical, Horizontal }
