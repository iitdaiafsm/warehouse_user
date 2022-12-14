import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/extensions.dart';

import '../helper/color_helper.dart';
import '../helper/models/godown_model.dart';
import '../helper/shared_files.dart';
import '../helper/styles.dart';
import '../screens/warehouse/controller.dart';
import 'dotted_line.dart';
import 'godown_sensor.dart';

Widget getSensorWidget(
  WarehouseController controller,
  SensorData data,
  SensorPosition position,
  BoxConstraints constraints,
  BuildContext context,
  /* double emptyHeight,
      double emptyWidth,*/
) {
  switch (position) {
    case SensorPosition.LeftOuter:
      if (data.name == "none") {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          height: constraints.maxWidth * 0.06,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_left.png",
                    height: constraints.maxHeight * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_vertical.png",
                    height: constraints.maxHeight * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              children: [
                Image.asset(
                  "asset/prox_sensor_left.png",
                  height: constraints.maxHeight * 0.04,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }

      return Container();
    case SensorPosition.LeftInner:
      if (data.name == "none") {

        return SizedBox(
          width: constraints.maxWidth * 0.07,
          height: constraints.maxWidth * 0.07,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_left.png",
                    height: constraints.maxHeight * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_vertical.png",
                    height: constraints.maxHeight * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              children: [
                Image.asset(
                  "asset/prox_sensor_left.png",
                  height: constraints.maxHeight * 0.04,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.TopOuter:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxHeight * 0.07,
          height: constraints.maxHeight * 0.07,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_up.png",
                    width: constraints.maxWidth * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_horizontal.png",
                    width: constraints.maxWidth * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Image.asset(
                  "asset/prox_sensor_top.png",
                  height: constraints.maxWidth * 0.03,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          height: constraints.maxHeight * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.TopInner:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxHeight * 0.09,
          height: constraints.maxHeight * 0.09,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_up.png",
                    height: constraints.maxWidth * 0.025,
                  )
                : Image.asset(
                    "asset/close_door_horizontal.png",
                    height: constraints.maxWidth * 0.025,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Image.asset(
                  "asset/prox_sensor_top.png",
                  height: constraints.maxWidth * 0.03,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.06,
                      height: constraints.maxWidth * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.RightOuter:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          height: constraints.maxWidth * 0.06,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_right.png",
                    height: constraints.maxHeight * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_vertical.png",
                    height: constraints.maxHeight * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
                Image.asset(
                  "asset/prox_sensor_right.png",
                  height: constraints.maxHeight * 0.04,
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          width: constraints.maxWidth * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.RightInner:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          height: constraints.maxWidth * 0.07,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_right.png",
                    height: constraints.maxHeight * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_vertical.png",
                    height: constraints.maxHeight * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
                Image.asset(
                  "asset/prox_sensor_right.png",
                  height: constraints.maxHeight * 0.04,
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          width: constraints.maxWidth * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.BottonOuter:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxHeight * 0.07,
          height: constraints.maxHeight * 0.07,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_down.png",
                    width: constraints.maxWidth * 0.09,
                  )
                : Image.asset(
                    "asset/close_door_horizontal.png",
                    width: constraints.maxWidth * 0.09,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
                Image.asset(
                  "asset/prox_sensor_down.png",
                  height: constraints.maxWidth * 0.03,
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          height: constraints.maxHeight * 0.07,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.05,
                          height: constraints.maxWidth * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          height: constraints.maxHeight * 0.06,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.BottomInner:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxHeight * 0.09,
          height: constraints.maxHeight * 0.09,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            data.doorOpen ?? false
                ? Image.asset(
                    "asset/open_door_down.png",
                    height: constraints.maxWidth * 0.025,
                  )
                : Image.asset(
                    "asset/close_door_horizontal.png",
                    height: constraints.maxWidth * 0.025,
                  ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineLength: double.infinity,
                    lineThickness: 1,
                    dashColor: data.rodentEnable ?? false
                        ? redColor
                        : Theme.of(context).primaryColor,
                    dashGapLength: data.rodentEnable ?? false ? 2 : 6,
                  ),
                ),
                Image.asset(
                  "asset/prox_sensor_down.png",
                  height: constraints.maxWidth * 0.03,
                ),
              ],
            ),
            if (data.battery != null &&
                data.battery! <
                    (controller.selectedWarehouse.batteryLevel ?? 25))
              FadeTransition(
                opacity: controller.blinkAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent,
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "asset/battery-status.png",
                    height: constraints.maxWidth * 0.04,
                  ),
                ),
              )
          ],
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.06,
                      height: constraints.maxWidth * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
    case SensorPosition.Center:
      if (data.name!.contains("none")) {
        return SizedBox(
          width: constraints.maxHeight * 0.09,
          height: constraints.maxHeight * 0.09,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        return SizedBox(
          width: constraints.maxHeight * 0.09,
          height: constraints.maxHeight * 0.09,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        return SizedBox(
          width: constraints.maxHeight * 0.09,
          height: constraints.maxHeight * 0.09,
        );
      }
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0)
                                ? "asset/pressure_low.png"
                                : "asset/pressure_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.pressure ?? 0,
                                    controller
                                            .selectedWarehouse.pressureLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.pressureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.pressure ?? 0,
                                        controller.selectedWarehouse
                                                .pressureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .pressureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.pressure ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "hPa",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.pressure ?? 0,
                                            controller.selectedWarehouse
                                                    .pressureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .pressureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0)
                                ? "asset/drop_low.png"
                                : "asset/drop_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.humidity ?? 0,
                                    controller
                                            .selectedWarehouse.humidityLower ??
                                        0,
                                    controller
                                            .selectedWarehouse.humidityHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.humidity ?? 0,
                                        controller.selectedWarehouse
                                                .humidityLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .humidityHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.humidity ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "%",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.humidity ?? 0,
                                            controller.selectedWarehouse
                                                    .humidityLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .humidityHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.name!.contains("smoke")) {
        return SizedBox(
          width: constraints.maxWidth * 0.1,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.05,
                      height: constraints.maxWidth * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.value ?? 0,
                                controller.selectedWarehouse.smokeLevel ?? 0,
                                controller.selectedWarehouse.co2Higher ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(data.co2 ?? 0, 0,
                                controller.selectedWarehouse.smokeLevel ?? 0)
                            ? "asset/smoke_icon.png"
                            : "asset/smoke_icon_high.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.co2 ?? 0,
                                0,
                                controller.selectedWarehouse.smokeLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    0,
                                    controller.selectedWarehouse.smokeLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "${data.co2 ?? 0}",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        0,
                                        controller
                                                .selectedWarehouse.smokeLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.co2 ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.co2 ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.co2 ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "ppm",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.co2 ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.tvoc ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.tvoc ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.tvoc ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.tvoc ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "tvoc",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ?? 0)
                                ? "asset/cloud_low.png"
                                : "asset/cloud_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.aqi ?? 0,
                                    controller.selectedWarehouse.co2Lower ?? 0,
                                    controller.selectedWarehouse.co2Higher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.aqi ?? 0,
                                        controller.selectedWarehouse.co2Lower ??
                                            0,
                                        controller
                                                .selectedWarehouse.co2Higher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.aqi ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "aqi",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.aqi ?? 0,
                                            controller.selectedWarehouse
                                                    .co2Lower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .co2Higher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0)
                                ? "asset/fan_low.png"
                                : "asset/fan_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.air ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .airflowLevel ??
                                            0),
                                    controller.selectedWarehouse.airflowLevel ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.air ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .airflowLevel ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.air ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.air ?? 0,
                                            0 -
                                                (controller.selectedWarehouse
                                                        .airflowLevel ??
                                                    0),
                                            controller.selectedWarehouse
                                                    .airflowLevel ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.06,
                          height: constraints.maxWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                          child: Image.asset(
                            AppMethods.isNormal(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0)
                                ? "asset/temperature_low.png"
                                : "asset/temperature_high.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.04,
                          height: constraints.maxWidth * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppMethods.DEFAULT_PADDING / 2),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: AppMethods.getMeasurementColor(
                                    data.temperature ?? 0,
                                    controller.selectedWarehouse
                                            .temperatureLower ??
                                        0,
                                    controller.selectedWarehouse
                                            .temperatureHigher ??
                                        0),
                                blurRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                                spreadRadius: AppMethods.isNormal(
                                        data.temperature ?? 0,
                                        controller.selectedWarehouse
                                                .temperatureLower ??
                                            0,
                                        controller.selectedWarehouse
                                                .temperatureHigher ??
                                            0)
                                    ? 6
                                    : 6,
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                          child: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  (data.temperature ?? 0).toStringAsFixed(2),
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: true,
                                    fontSize: FontSize.H6,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  maxLines: 1,
                                  style: textStyle(
                                    context: context,
                                    color: AppMethods.isNormal(
                                            data.temperature ?? 0,
                                            controller.selectedWarehouse
                                                    .temperatureLower ??
                                                0,
                                            controller.selectedWarehouse
                                                    .temperatureHigher ??
                                                0)
                                        ? greenColor
                                        : redColor,
                                    isBold: false,
                                    fontSize: FontSize.H7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        return SizedBox(
          height: constraints.maxHeight * 0.09,
          child: FittedBox(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.06,
                      height: constraints.maxWidth * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 2),
                      child: Image.asset(
                        AppMethods.isNormal(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0)
                            ? "asset/oxygen.png"
                            : "asset/oxygen.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.04,
                      height: constraints.maxWidth * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppMethods.DEFAULT_PADDING / 2),
                        color: appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppMethods.getMeasurementColor(
                                data.oxygen ?? 0,
                                0 -
                                    (controller.selectedWarehouse.oxygenLevel ??
                                        0),
                                controller.selectedWarehouse.oxygenLevel ?? 0),
                            blurRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                            spreadRadius: AppMethods.isNormal(
                                    data.oxygen ?? 0,
                                    0 -
                                        (controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0),
                                    controller.selectedWarehouse.oxygenLevel ??
                                        0)
                                ? 6
                                : 6,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING / 4),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              (data.oxygen ?? 0).toStringAsFixed(2),
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: true,
                                fontSize: FontSize.H6,
                              ),
                            ),
                            Text(
                              "%",
                              maxLines: 1,
                              style: textStyle(
                                context: context,
                                color: AppMethods.isNormal(
                                        data.oxygen ?? 0,
                                        0 -
                                            (controller.selectedWarehouse
                                                    .oxygenLevel ??
                                                0),
                                        controller.selectedWarehouse
                                                .oxygenLevel ??
                                            0)
                                    ? greenColor
                                    : redColor,
                                isBold: false,
                                fontSize: FontSize.H7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (data.battery != null &&
                    data.battery! <
                        (controller.selectedWarehouse.batteryLevel ?? 25))
                  FadeTransition(
                    opacity: controller.blinkAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent,
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "asset/battery-status.png",
                        width: constraints.maxWidth * 0.04,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ).dottedBorder();
      }
      return Container();
  }
}
