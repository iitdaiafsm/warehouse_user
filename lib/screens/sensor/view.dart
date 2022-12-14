import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/helper/styles.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

import '../../widgets/godown_sensor.dart';
import '../../widgets/godown_sensor_alerts.dart';
import '../../widgets/heading_widget.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      smallScreen: Container(
        width: width(context),
        height: height(context),
        padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
        child: GetBuilder<WarehouseController>(
            init: WarehouseController(),
            id: "sensor-page",
            builder: (controller) {
              // print(jsonEncode(controller.selectedGodown));
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeadingWidget(
                    title: controller.selectedGodown.name ?? "",
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING,
                  ),
                  if (width(context) > height(context))
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: width(context) * 0.75,
                            ),
                            margin: EdgeInsets.only(
                                bottom: AppMethods.DEFAULT_PADDING),
                            child: AspectRatio(
                              aspectRatio: controller.selectedGodown.row! /
                                  controller.selectedGodown.column!,
                              child: GodownSensor(
                                controller: controller,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppMethods.DEFAULT_PADDING,
                          ),
                          Expanded(
                            child: GodownSensorsAlerts(controller: controller),
                          )
                        ],
                      ),
                    ),
                  if (width(context) <= height(context)) ...[
                    Container(
                      // width: width(context),
                      margin:
                          EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING),
                      child: AspectRatio(
                        aspectRatio: controller.selectedGodown.row! /
                            controller.selectedGodown.column!,
                        child: Center(
                          child: GodownSensor(
                            controller: controller,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GodownSensorsAlerts(controller: controller),
                    )
                  ]
                ],
              );
            }),
      ),
    );
  }
}
