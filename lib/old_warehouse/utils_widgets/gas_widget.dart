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

class GasWidget extends StatelessWidget {
  final SensorData? gasValue;
  final Animation measurementHighAnimation;
  final AnimationController blinkAnimation;
  final String hoverID;
  final TabMenus tabMenus;

  GasWidget({
    Key? key,
    required this.gasValue,
    required this.measurementHighAnimation,
    required this.tabMenus,
    required this.hoverID,
    required this.blinkAnimation,
  }) : super(key: key);
  final JustTheController controller = JustTheController();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
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
                gasValue!.name!,
                [
                  KeyValueClass(
                    key: "Date",
                    value: AppConfig.getFormattedOnlyDate(
                      gasValue!.time,
                    ),
                  ),
                  KeyValueClass(
                    key: "Time",
                    value: AppConfig.getFormattedOnlyTime(
                      gasValue!.time,
                    ),
                  ),
                  KeyValueClass(
                    key: "Gas",
                    value: "${gasValue!.value} ppm",
                  ),
                  KeyValueClass(
                    key: "Battery",
                    value: "${gasValue!.battery} %",
                  ),
                ],
                context),
            child: Container(
              child: AppConfig.isSensorStopped(gasValue!.time)
                  ? AppConfig.getGrayWidget("asset/gas_icon.png", context)
                  : Transform.scale(
                      scale: hoverID == gasValue!.id ? 1.3 : 1,
                      child: _getHorizontalMeasurement(context)),
              margin: EdgeInsets.all(getWidth(0.5, context)),
            ),
          )),
    );
  }

  Widget _getHorizontalMeasurement(BuildContext context) {
    bool isGasNormal = gasValue!.value! > AppConfig.HIGHER_GAS;
    return Stack(
      alignment: Alignment.center,
      children: [
        _getInnerHorizontalWidget(
          gasValue!.value,
          !isGasNormal,
          "asset/gas_icon.png",
          "ppm",
          context,
        ),
        if (gasValue!.battery != null &&
            gasValue!.battery! < AppConfig.BATTERY_LEVEL)
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
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  "asset/battery-status.png",
                  width: getWidth(2.5, context),
                ),
              ),
            ),
          )
      ],
    );
  }

  _getInnerHorizontalWidget(double? value, bool isNormal, String imagePath,
      String unit, BuildContext context) {
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
                  color: AppConfig.getMeasurementColor(
                      gasValue!.value!, SensorType.Gas),
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
                    color: AppConfig.getMeasurementColor(
                        gasValue!.value!, SensorType.Gas),
                    type: TextStyleType.bold,
                    size: AppConfig.FONT_SIZE_H10),
              ),
              Text(
                unit,
                maxLines: 1,
                style: FSMResources.FSMTextStyle(
                    context: context,
                    color: AppConfig.getMeasurementColor(
                        gasValue!.value!, SensorType.Gas),
                    type: TextStyleType.bold,
                    size: 0.6),
              )
            ],
          ),
        ),
        SizedBox(
          height: getHeight(0.5, context),
        ),
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
                  color: AppConfig.getMeasurementColor(
                      gasValue!.value!, SensorType.Gas),
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
        //
        // if (!isNormal)
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
                  color: AppConfig.getMeasurementColor(
                      gasValue!.value!, SensorType.Gas),
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
                    color: AppConfig.getMeasurementColor(
                        gasValue!.value!, SensorType.Gas),
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
