import 'package:flutter/material.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/just_the_tooltip.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/models/just_the_controller.dart';

import '../utils/app_config.dart';
import '../utils/app_size.dart';

class DoorWidgetPage extends StatelessWidget {
  final DoorWidgetData doorWidgetData;
  final LeftDoors leftDoors;
  final String hoverID;
  final AnimationController blinkAnimation;

  DoorWidgetPage({
    Key? key,
    required this.doorWidgetData,
    required this.leftDoors,
    required this.hoverID,
    required this.blinkAnimation,
  }) : super(key: key);
  JustTheController controller =
      JustTheController(value: TooltipStatus.isHidden);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: JustTheTooltip(
        controller: controller,
        content: leftDoors.name != null
            ? AppConfig.getHoverInnerWidget(
                leftDoors.name ?? "",
                [
                  KeyValueClass(
                    key: "Date",
                    value: AppConfig.getFormattedOnlyDate(
                      leftDoors.time,
                    ),
                  ),
                  KeyValueClass(
                    key: "Time",
                    value: AppConfig.getFormattedOnlyTime(
                      leftDoors.time,
                    ),
                  ),
                  KeyValueClass(
                    key: "Open",
                    value: "${leftDoors.isRunning}",
                  ),
                  KeyValueClass(
                    key: "Battery",
                    value: "${leftDoors.battery} %",
                  ),
                ],
                context)
            : const SizedBox(
                width: 0,
                height: 0,
              ),
        child: MouseRegion(
          onHover: (e) {
            if (leftDoors.name != null) {
              controller.attach(
                  showTooltip: (
                      {autoClose = true, immediately = false}) async {},
                  hideTooltip: ({immediately = true}) async {});
              controller.showTooltip(immediately: false, autoClose: true);
            }
          },
          child: GestureDetector(
            onLongPress: () {
              if (leftDoors.name != null) {
                controller.attach(
                    showTooltip: (
                        {autoClose = true, immediately = false}) async {},
                    hideTooltip: ({immediately = true}) async {});
                controller.showTooltip(immediately: false, autoClose: true);
              }
            },
            child: Transform.scale(
              scale: hoverID == leftDoors.id ? 1.3 : 1,
              child: doorWidgetData.doorDirection == DoorDirection.LEFT
                  ? Center(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          doorWidgetData.isOpen
                              ? Image.asset(
                                  "asset/open_door_left.png",
                                  height: getWidth(4, context),
                                )
                              : Image.asset(
                                  "asset/close_door_vertical.png",
                                  height: getWidth(4, context),
                                ),
                          if (leftDoors.battery != null &&
                              leftDoors.battery! < AppConfig.BATTERY_LEVEL)
                            Center(
                              child: FadeTransition(
                                opacity: blinkAnimation,
                                child: Container(
                                  height: getWidth(3, context),
                                  alignment: Alignment.center,
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
                      ),
                    )
                  : doorWidgetData.doorDirection == DoorDirection.RIGHT
                      ? Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Center(
                              child: doorWidgetData.isOpen
                                  ? Image.asset(
                                      "asset/open_door_right.png",
                                      height: getWidth(4, context),
                                    )
                                  : Image.asset(
                                      "asset/close_door_vertical.png",
                                      height: getWidth(4, context),
                                    ),
                            ),
                            if (leftDoors.battery != null &&
                                leftDoors.battery! < AppConfig.BATTERY_LEVEL)
                              Center(
                                child: FadeTransition(
                                  opacity: blinkAnimation,
                                  child: Container(
                                    height: getWidth(3, context),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amberAccent,
                                          spreadRadius: getWidth(0.2, context),
                                          blurRadius: getWidth(0.7, context),
                                          offset: const Offset(0,
                                              0), // changes position of shadow
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
                        )
                      : doorWidgetData.doorDirection == DoorDirection.UP
                          ? Center(
                              child: doorWidgetData.isOpen
                                  ? Image.asset(
                                      "asset/open_door_up.png",
                                      width: getWidth(4, context),
                                    )
                                  : Image.asset(
                                      "asset/close_door_horizontal.png",
                                      width: getWidth(4, context),
                                    ),
                            )
                          : doorWidgetData.doorDirection == DoorDirection.DOWN
                              ? Center(
                                  child: doorWidgetData.isOpen
                                      ? Image.asset(
                                          "asset/open_door_down.png",
                                          width: getWidth(4, context),
                                        )
                                      : Image.asset(
                                          "asset/close_door_horizontal.png",
                                          width: getWidth(4, context),
                                        ),
                                )
                              : Center(
                                  child: doorWidgetData.isOpen
                                      ? Image.asset(
                                          "asset/open_door_right.png",
                                          height: getWidth(4, context),
                                        )
                                      : Image.asset(
                                          "asset/close_door.png",
                                          height: getWidth(4, context),
                                        ),
                                ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DoorDirection { UP, DOWN, LEFT, RIGHT }

class DoorWidgetData {
  bool isOpen;
  DoorDirection doorDirection;

  DoorWidgetData(this.isOpen, this.doorDirection);
}
