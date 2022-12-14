import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';
import 'package:warehouse_user/widgets/sensor_widget.dart';

import '../helper/color_helper.dart';
import '../helper/shared_files.dart';

class GodownSensor extends StatelessWidget {
  WarehouseController controller;

  GodownSensor({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppMethods.DEFAULT_PADDING),
                border: Border.all(
                  color: borderColor,
                  width: 5,
                ),
                color: godownBGColor,
              ),
              child: Opacity(
                opacity: 0.3,
                child: Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.65,
                    height: constraints.maxHeight * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        controller.selectedGodown.column!,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            controller.selectedGodown.row!,
                            (index) => Image.asset(
                              "asset/Grain.png",
                              width: (constraints.maxWidth /
                                      controller.selectedGodown.row!) *
                                  0.30,
                              height: (constraints.maxHeight /
                                      controller.selectedGodown.column!) *
                                  0.30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.selectedGodown.leftOuterSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.leftOuterSensor![index],
                    SensorPosition.LeftOuter,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),*/
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  controller.selectedGodown.rightOuterSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.rightOuterSensor![index],
                    SensorPosition.RightOuter,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),*/
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                  left: constraints.maxWidth * 0.07,
                  right: constraints.maxWidth * 0.07,
                  top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.selectedGodown.topOuterSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.topOuterSensor![index],
                    SensorPosition.TopOuter,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0), */
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  left: constraints.maxWidth * 0.07,
                  right: constraints.maxWidth * 0.07,
                  bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  controller.selectedGodown.bottomOuterSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.bottomOuterSensor![index],
                    SensorPosition.BottonOuter,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0), */
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                right: constraints.maxWidth * 0.07,
                top: constraints.maxHeight * 0.07,
                bottom: constraints.maxHeight * 0.07,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  controller.selectedGodown.rightInnerSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.rightInnerSensor![index],
                    SensorPosition.RightInner,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),*/
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                  left: constraints.maxWidth * 0.17,
                  right: constraints.maxWidth * 0.17,
                  top: constraints.maxHeight * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.selectedGodown.topInnerSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.topInnerSensor![index],
                    SensorPosition.TopInner,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0), */
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  left: constraints.maxWidth * 0.17,
                  right: constraints.maxWidth * 0.17,
                  bottom: constraints.maxHeight * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  controller.selectedGodown.bottomInnerSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.bottomInnerSensor![index],
                    SensorPosition.BottomInner,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0), */
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: constraints.maxWidth * 0.07,
                top: constraints.maxHeight * 0.07,
                bottom: constraints.maxHeight * 0.07,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.selectedGodown.leftInnerSensor?.length ?? 0,
                  (index) => getSensorWidget(
                    controller,
                    controller.selectedGodown.leftInnerSensor![index],
                    SensorPosition.LeftInner,
                    constraints,
                    context,
                    /*constraints.maxHeight /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),
                    constraints.maxWidth /
                        (controller.selectedGodown.leftOuterSensor?.length ??
                            0),*/
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight / 2,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: constraints.maxWidth * 0.01,
                    runSpacing: constraints.maxHeight * 0.01,
                    children: List.generate(
                      controller.selectedGodown.centerSensor?.length ?? 0,
                      (index) => getSensorWidget(
                        controller,
                        controller.selectedGodown.centerSensor![index],
                        SensorPosition.Center,
                        constraints,
                        context,
                        /*constraints.maxHeight /
                            (controller.selectedGodown.leftOuterSensor?.length ??
                                0),
                        constraints.maxWidth /
                            (controller.selectedGodown.leftOuterSensor?.length ??
                                0), */
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

enum SensorPosition {
  LeftOuter,
  LeftInner,
  TopOuter,
  TopInner,
  RightOuter,
  RightInner,
  BottonOuter,
  BottomInner,
  Center,
}
