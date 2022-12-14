import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/utils/color_filter.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/flutter_bounce.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/mesurement_widget.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/tooltip/src/just_the_tooltip.dart';

import '../../widgets/dotted_border/dotted_border.dart';
import '../utils/app_config.dart';
import '../utils/app_size.dart';
import '../utils/colors.dart';
import '../utils/fsm_resource.dart';
import '../utils_widgets/door_widget.dart';
import '../utils_widgets/fan_widget.dart';
import '../utils_widgets/tooltip/src/models/just_the_controller.dart';
import '../utils_widgets/wheat_widget.dart';
import 'logic.dart';

class WarehousePage extends StatelessWidget {
  final String title;
  final void Function() onBackPressed;
  final DummyMeasurementDataModel dummyMeasurementDataModel;
  final void Function() onDrawerPressed;

  WarehousePage({
    Key? key,
    required this.title,
    required this.dummyMeasurementDataModel,
    required this.onBackPressed,
    required this.onDrawerPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      height: height(context),
      child: Padding(
        padding: EdgeInsets.all(getWidth(AppConfig.DEFAULT_PADDING, context)),
        child: GetBuilder<WarehouseLogic>(
            init: WarehouseLogic(),
            didChangeDependencies: (state) {
              // Get.log(
              //     "Warehouse Data : ${jsonEncode(dummyMeasurementDataModel)}");
              state.controller!.updateVariables(context);
              state.controller!.setAlertsList(dummyMeasurementDataModel);
            },
            didUpdateWidget: (builder, state) {
              // Get.log(
              //     "Warehouse Data : ${jsonEncode(dummyMeasurementDataModel)}");
              state.controller!.updateVariables(context);
              state.controller!.setAlertsList(dummyMeasurementDataModel);
            },
            builder: (logic) {
              // Get.log((logic.stackSize.width/logic.stackSize.height).toString());
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: appWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryColor,
                            offset: const Offset(0, 0),
                            blurRadius: getWidth(1, context))
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getWidth(1, context)),
                        topRight: Radius.circular(getWidth(1, context)),
                      ),
                    ),
                    padding: EdgeInsets.all(getWidth(1, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Bounce(
                            onPressed: onBackPressed,
                            child: CircleAvatar(
                              radius: getWidth(1.4, context),
                              backgroundColor: appPrimaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: getWidth(1.8, context),
                                ),
                              ),
                            )),
                        Text(
                          title,
                          style: FSMResources.FSMTextStyle(
                            color: appPrimaryColor,
                            size: AppConfig.FONT_SIZE_H1,
                            type: TextStyleType.bold,
                            context: context,
                          ),
                        ),
                        Bounce(
                            child: CircleAvatar(
                              radius: getWidth(1.4, context),
                              backgroundColor: appPrimaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: getWidth(1.8, context),
                                ),
                              ),
                            ),
                            onPressed: onDrawerPressed),
                      ],
                    ),
                  ),
                  if ((dummyMeasurementDataModel.gridData!.columns! >=
                      dummyMeasurementDataModel.gridData!.rows!))
                    SizedBox(
                      height: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                    ),
                  Center(
                    child: Text(
                      "Warehouse 1A",
                      style: FSMResources.FSMTextStyle(
                        context: context,
                        color: appPrimaryColor,
                        size: AppConfig.FONT_SIZE_H5,
                        type: TextStyleType.bold,
                      ),
                    ),
                  ),
                  if ((dummyMeasurementDataModel.gridData!.columns! >=
                      dummyMeasurementDataModel.gridData!.rows!))
                    SizedBox(
                      height: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                    ),
                  /*if ((dummyMeasurementDataModel.gridData!.columns! >=
                          dummyMeasurementDataModel.gridData!.rows!))
                        Wrap(
                          children: List.generate(
                              logic.tabsList.length,
                              (index) => MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Bounce(
                                      onPressed: () {
                                        logic.onTabMenuClicked(
                                            logic.tabsList[index]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getWidth(0.5, context),
                                            horizontal: getWidth(2, context)),
                                        margin: EdgeInsets.only(
                                            left: getWidth(0.3, context),
                                            right: getWidth(0.3, context)),
                                        decoration: BoxDecoration(
                                            color: logic.tabsList[index] ==
                                                    logic.selectedTab
                                                ? appPrimaryColor
                                                : appPrimaryLightColor,
                                            borderRadius: BorderRadius.circular(
                                              getWidth(0.5, context),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: appDividerColor,
                                                offset: const Offset(-3, 3),
                                                blurRadius:
                                                    getWidth(0.2, context),
                                              ),
                                            ],
                                            border: Border.all(
                                                color: appPrimaryColor,
                                                width: getWidth(0.1, context))),
                                        child: Text(
                                          logic.getTabMenuName(
                                              logic.tabsList[index]),
                                          style: FSMResources.FSMTextStyle(
                                            color: logic.tabsList[index] ==
                                                    logic.selectedTab
                                                ? appWhiteColor
                                                : appTextDarkColor,
                                            size: AppConfig.FONT_SIZE_H4,
                                            type: TextStyleType.bold,
                                            context: context,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),*/
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*if (!(dummyMeasurementDataModel.gridData!.columns! >=
                            dummyMeasurementDataModel.gridData!.rows!))
                          SizedBox(
                            height: logic.stackSize.height,
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    logic.tabsList.length,
                                    (index) => Bounce(
                                          onPressed: () {
                                            logic.onTabMenuClicked(
                                                logic.tabsList[index]);
                                          },
                                          child: Container(
                                            width: getWidth(12, context),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: getWidth(0.6, context),
                                                horizontal: getWidth(1, context)),
                                            margin: EdgeInsets.only(
                                              bottom: getWidth(1.15, context),
                                            ),
                                            decoration: BoxDecoration(
                                              color: logic.tabsList[index] ==
                                                      logic.selectedTab
                                                  ? appPrimaryColor
                                                  : appPrimaryLightColor,
                                              borderRadius: BorderRadius.circular(
                                                getWidth(0.2, context),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: appDividerColor,
                                                  offset: const Offset(-3, 3),
                                                  blurRadius:
                                                      getWidth(0.2, context),
                                                ),
                                              ],
                                              border: Border.all(
                                                color: appPrimaryColor,
                                                width: getWidth(
                                                  0.3,
                                                  context,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              logic.getTabMenuName(
                                                  logic.tabsList[index]),
                                              style: FSMResources.FSMTextStyle(
                                                color: logic.tabsList[index] ==
                                                        logic.selectedTab
                                                    ? appWhiteColor
                                                    : appTextDarkColor,
                                                size: AppConfig.FONT_SIZE_H5,
                                                context: context,
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                          ),*/
                        if (!(dummyMeasurementDataModel.gridData!.columns! >=
                            dummyMeasurementDataModel.gridData!.rows!))
                          SizedBox(
                            width: getWidth(1, context),
                          ),
                        Container(
                          height:
                              (dummyMeasurementDataModel.gridData!.columns! >=
                                      dummyMeasurementDataModel.gridData!.rows!)
                                  ? (dummyMeasurementDataModel.gridData!.rows! /
                                          dummyMeasurementDataModel
                                              .gridData!.columns!) *
                                      getRelativeSize(height(context), 120)
                                  : getRelativeSize(height(context), 100),
                          width: (dummyMeasurementDataModel.gridData!.rows! >=
                                  dummyMeasurementDataModel.gridData!.columns!)
                              ? (dummyMeasurementDataModel.gridData!.columns! /
                                      dummyMeasurementDataModel
                                          .gridData!.rows!) *
                                  getRelativeSize(height(context), 120)
                              : getRelativeSize(height(context), 100),
                          key: logic.globalKey,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: appTextDarkColor,
                                width:
                                    getWidth(AppConfig.BORDER_WIDTH, context),
                              ),
                              color: appWarehouseBackgroundColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getWidth(1, context)))),
                          child: Stack(
                            children: [
                              if (dummyMeasurementDataModel.fansData != null &&
                                  dummyMeasurementDataModel
                                      .fansData!.isNotEmpty)
                                SizedBox(
                                  height: logic.stackSize.height,
                                  width: logic.stackSize.width,
                                  child: Stack(
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .fansData!.length,
                                      (index) => Positioned(
                                        child: FanWidgetPage(
                                          shouldRotate:
                                              dummyMeasurementDataModel
                                                  .fansData![index].isRunning!,
                                        ),
                                        top: dummyMeasurementDataModel
                                            .fansData![index].top,
                                        bottom: dummyMeasurementDataModel
                                            .fansData![index].bottom,
                                        left: dummyMeasurementDataModel
                                            .fansData![index].left,
                                        right: dummyMeasurementDataModel
                                            .fansData![index].right,
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.gridData != null)
                                Center(
                                  child: Opacity(
                                    opacity: 0.3,
                                    child: WheatWidget(
                                      crossAxisCount: dummyMeasurementDataModel
                                          .gridData!.columns!,
                                      numberOfRows: dummyMeasurementDataModel
                                          .gridData!.rows!,
                                      size: logic.stackSize,
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: 0,
                                right:
                                    getRelativeSize(logic.stackSize.width, 2),
                                left: getRelativeSize(logic.stackSize.width, 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    dummyMeasurementDataModel
                                        .topMotionDetectorValues!.length,
                                    (index) {
                                      JustTheController controller =
                                          JustTheController();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MouseRegion(
                                            onHover: (e) {
                                              controller.attach(
                                                  showTooltip: (
                                                      {autoClose = true,
                                                      immediately =
                                                          false}) async {},
                                                  hideTooltip: (
                                                      {immediately =
                                                          true}) async {});
                                              controller.showTooltip(
                                                  autoClose: true,
                                                  immediately: false);
                                            },
                                            child: SizedBox(
                                              width: getWidth(4, context),
                                              child: GestureDetector(
                                                onLongPress: () {
                                                  controller.attach(
                                                      showTooltip: (
                                                          {autoClose = true,
                                                          immediately =
                                                              false}) async {},
                                                      hideTooltip: (
                                                          {immediately =
                                                              true}) async {});
                                                  controller.showTooltip(
                                                      autoClose: true,
                                                      immediately: false);
                                                },
                                                child: JustTheTooltip(
                                                  controller: controller,
                                                  content: AppConfig
                                                      .getHoverInnerWidget(
                                                          dummyMeasurementDataModel
                                                              .topMotionDetectorValues![
                                                                  index]
                                                              .name!,
                                                          [
                                                            KeyValueClass(
                                                              key: "Date",
                                                              value: AppConfig
                                                                  .getFormattedOnlyDate(
                                                                dummyMeasurementDataModel
                                                                    .topMotionDetectorValues![
                                                                        index]
                                                                    .time,
                                                              ),
                                                            ),
                                                            KeyValueClass(
                                                              key: "Time",
                                                              value: AppConfig
                                                                  .getFormattedOnlyTime(
                                                                dummyMeasurementDataModel
                                                                    .topMotionDetectorValues![
                                                                        index]
                                                                    .time,
                                                              ),
                                                            ),
                                                            KeyValueClass(
                                                              key: "Value",
                                                              value:
                                                                  "${dummyMeasurementDataModel.topMotionDetectorValues![index].value}",
                                                            ),
                                                            KeyValueClass(
                                                              key: "Battery",
                                                              value:
                                                                  "${dummyMeasurementDataModel.topMotionDetectorValues![index].battery} %",
                                                            ),
                                                          ],
                                                          context),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: [
                                                      AppConfig.isSensorStopped(
                                                              dummyMeasurementDataModel
                                                                  .topMotionDetectorValues![
                                                                      index]
                                                                  .time)
                                                          ? ColorFiltered(
                                                              colorFilter:
                                                                  ColorFilter.matrix(
                                                                      ColorFilterGenerator
                                                                          .saturationAdjustMatrix(
                                                                value: -1,
                                                              )),
                                                              child:
                                                                  Image.asset(
                                                                "asset/prox_sensor_top.png",
                                                                height: getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                              ),
                                                            )
                                                          : Transform.scale(
                                                              scale: logic.hoverID ==
                                                                      dummyMeasurementDataModel
                                                                          .topMotionDetectorValues![
                                                                              index]
                                                                          .id
                                                                  ? 1.3
                                                                  : 1,
                                                              child:
                                                                  Image.asset(
                                                                "asset/prox_sensor_top.png",
                                                                // width: getRelativeSize(logic.stackSize.width, 4),
                                                                color: logic.hoverID ==
                                                                        dummyMeasurementDataModel
                                                                            .topMotionDetectorValues![
                                                                                index]
                                                                            .id
                                                                    ? Colors.amber[
                                                                        800]
                                                                    : dummyMeasurementDataModel.topMotionDetectorValues![index].value! >
                                                                            0.7
                                                                        ? appDangerTextColor
                                                                        : null,
                                                                height: getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                              ),
                                                            ),
                                                      if (dummyMeasurementDataModel
                                                                  .topMotionDetectorValues![
                                                                      index]
                                                                  .battery !=
                                                              null &&
                                                          dummyMeasurementDataModel
                                                                  .topMotionDetectorValues![
                                                                      index]
                                                                  .battery! <
                                                              AppConfig
                                                                  .BATTERY_LEVEL)
                                                        Center(
                                                          child: FadeTransition(
                                                            opacity: logic
                                                                .blinkAnimation,
                                                            child: Container(
                                                              height: getRelativeSize(
                                                                  logic
                                                                      .stackSize
                                                                      .height,
                                                                  4),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .amberAccent,
                                                                    spreadRadius:
                                                                        getWidth(
                                                                            0.2,
                                                                            context),
                                                                    blurRadius:
                                                                        getWidth(
                                                                            0.7,
                                                                            context),
                                                                    offset: const Offset(
                                                                        0,
                                                                        0), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                "asset/battery-status.png",
                                                                width: getWidth(
                                                                    4, context),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DottedBorder(
                                            color: AppConfig.isSensorStopped(
                                                    dummyMeasurementDataModel
                                                        .topMotionDetectorValues![
                                                            index]
                                                        .time)
                                                ? Colors.blueGrey
                                                : logic.hoverID ==
                                                        dummyMeasurementDataModel
                                                            .topMotionDetectorValues![
                                                                index]
                                                            .id
                                                    ? Colors.amber[800]!
                                                    : dummyMeasurementDataModel
                                                                .topMotionDetectorValues![
                                                                    index]
                                                                .value! >
                                                            0.7
                                                        ? appDangerTextColor
                                                        : appPrimaryColor,
                                            // strokeWidth: getWidth(0),
                                            strokeWidth: dummyMeasurementDataModel
                                                        .topMotionDetectorValues![
                                                            index]
                                                        .value! >
                                                    0.7
                                                ? 3
                                                : 1,
                                            borderType: BorderType.RRect,
                                            padding: EdgeInsets.zero,
                                            // dashPattern: [2,1],
                                            dashPattern: dummyMeasurementDataModel
                                                        .topMotionDetectorValues![
                                                            index]
                                                        .value! >
                                                    0.7
                                                ? [1, 0]
                                                : [8, 15],
                                            child: SizedBox(
                                              height: getRelativeSize(
                                                  logic.stackSize.height, 80),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right:
                                    getRelativeSize(logic.stackSize.width, 2),
                                left: getRelativeSize(logic.stackSize.width, 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    dummyMeasurementDataModel
                                        .bottomMotionDetectorValues!.length,
                                    (index) {
                                      JustTheController controller =
                                          JustTheController();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DottedBorder(
                                            color: AppConfig.isSensorStopped(
                                                    dummyMeasurementDataModel
                                                        .bottomMotionDetectorValues![
                                                            index]
                                                        .time)
                                                ? Colors.blueGrey
                                                : logic.hoverID ==
                                                        dummyMeasurementDataModel
                                                            .bottomMotionDetectorValues![
                                                                index]
                                                            .id
                                                    ? Colors.amber[800]!
                                                    : dummyMeasurementDataModel
                                                                .bottomMotionDetectorValues![
                                                                    index]
                                                                .value! >
                                                            0.7
                                                        ? appDangerTextColor
                                                        : appPrimaryColor,
                                            strokeWidth: dummyMeasurementDataModel
                                                        .bottomMotionDetectorValues![
                                                            index]
                                                        .value! >
                                                    0.7
                                                ? 3
                                                : 1,
                                            borderType: BorderType.RRect,
                                            padding: EdgeInsets.zero,
                                            // dashPattern: [2,1],
                                            dashPattern: dummyMeasurementDataModel
                                                        .bottomMotionDetectorValues![
                                                            index]
                                                        .value! >
                                                    0.7
                                                ? [1, 0]
                                                : [8, 15],
                                            child: SizedBox(
                                              height: getRelativeSize(
                                                  logic.stackSize.height, 80),
                                            ),
                                          ),
                                          MouseRegion(
                                            onHover: (e) {
                                              controller.attach(
                                                  showTooltip: (
                                                      {autoClose = true,
                                                      immediately =
                                                          false}) async {},
                                                  hideTooltip: (
                                                      {immediately =
                                                          true}) async {});
                                              controller.showTooltip(
                                                  autoClose: true,
                                                  immediately: false);
                                            },
                                            child: SizedBox(
                                              width: getWidth(4, context),
                                              child: GestureDetector(
                                                  onLongPress: () {
                                                    controller.attach(
                                                        showTooltip: (
                                                            {autoClose = true,
                                                            immediately =
                                                                false}) async {},
                                                        hideTooltip: (
                                                            {immediately =
                                                                true}) async {});
                                                    controller.showTooltip(
                                                        autoClose: true,
                                                        immediately: false);
                                                  },
                                                  child: JustTheTooltip(
                                                      controller: controller,
                                                      content: AppConfig
                                                          .getHoverInnerWidget(
                                                              dummyMeasurementDataModel
                                                                  .bottomMotionDetectorValues![
                                                                      index]
                                                                  .name!,
                                                              [
                                                                KeyValueClass(
                                                                  key: "Date",
                                                                  value: AppConfig
                                                                      .getFormattedOnlyDate(
                                                                    dummyMeasurementDataModel
                                                                        .bottomMotionDetectorValues![
                                                                            index]
                                                                        .time,
                                                                  ),
                                                                ),
                                                                KeyValueClass(
                                                                  key: "Time",
                                                                  value: AppConfig
                                                                      .getFormattedOnlyTime(
                                                                    dummyMeasurementDataModel
                                                                        .bottomMotionDetectorValues![
                                                                            index]
                                                                        .time,
                                                                  ),
                                                                ),
                                                                KeyValueClass(
                                                                  key: "Value",
                                                                  value:
                                                                      "${dummyMeasurementDataModel.bottomMotionDetectorValues![index].value}",
                                                                ),
                                                                KeyValueClass(
                                                                  key:
                                                                      "Battery",
                                                                  value:
                                                                      "${dummyMeasurementDataModel.bottomMotionDetectorValues![index].battery} %",
                                                                ),
                                                              ],
                                                              context),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        children: [
                                                          AppConfig.isSensorStopped(
                                                                  dummyMeasurementDataModel
                                                                      .bottomMotionDetectorValues![
                                                                          index]
                                                                      .time)
                                                              ? ColorFiltered(
                                                                  colorFilter:
                                                                      ColorFilter
                                                                          .matrix(
                                                                              ColorFilterGenerator.saturationAdjustMatrix(
                                                                    value: -1,
                                                                  )),
                                                                  child: Image
                                                                      .asset(
                                                                    "asset/prox_sensor_down.png",
                                                                    height: getRelativeSize(
                                                                        logic
                                                                            .stackSize
                                                                            .height,
                                                                        4),
                                                                  ),
                                                                )
                                                              : Transform.scale(
                                                                  scale: logic.hoverID ==
                                                                          dummyMeasurementDataModel
                                                                              .bottomMotionDetectorValues![index]
                                                                              .id
                                                                      ? 1.3
                                                                      : 1,
                                                                  child: Image
                                                                      .asset(
                                                                    "asset/prox_sensor_down.png",
                                                                    // width: getRelativeSize(logic.stackSize.width, 4),
                                                                    color: logic.hoverID ==
                                                                            dummyMeasurementDataModel
                                                                                .bottomMotionDetectorValues![
                                                                                    index]
                                                                                .id
                                                                        ? Colors.amber[
                                                                            800]
                                                                        : dummyMeasurementDataModel.bottomMotionDetectorValues![index].value! >
                                                                                0.7
                                                                            ? appDangerTextColor
                                                                            : null,
                                                                    height: getRelativeSize(
                                                                        logic
                                                                            .stackSize
                                                                            .height,
                                                                        4),
                                                                  ),
                                                                ),
                                                          if (dummyMeasurementDataModel
                                                                      .bottomMotionDetectorValues![
                                                                          index]
                                                                      .battery !=
                                                                  null &&
                                                              dummyMeasurementDataModel
                                                                      .bottomMotionDetectorValues![
                                                                          index]
                                                                      .battery! <
                                                                  AppConfig
                                                                      .BATTERY_LEVEL)
                                                            Center(
                                                              child:
                                                                  FadeTransition(
                                                                opacity: logic
                                                                    .blinkAnimation,
                                                                child:
                                                                    Container(
                                                                  height: getRelativeSize(
                                                                      logic
                                                                          .stackSize
                                                                          .height,
                                                                      4),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .amberAccent,
                                                                        spreadRadius: getWidth(
                                                                            0.2,
                                                                            context),
                                                                        blurRadius: getWidth(
                                                                            0.7,
                                                                            context),
                                                                        offset: const Offset(
                                                                            0,
                                                                            0), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    "asset/battery-status.png",
                                                                    width: getWidth(
                                                                        4,
                                                                        context),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ))),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: getRelativeSize(logic.stackSize.height, 2),
                                bottom:
                                    getRelativeSize(logic.stackSize.height, 2),
                                left: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      dummyMeasurementDataModel
                                          .leftMotionDetectorValues!
                                          .length, (index) {
                                    JustTheController controller =
                                        JustTheController();
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                          onHover: (e) {
                                            controller.attach(
                                                showTooltip: (
                                                    {autoClose = true,
                                                    immediately =
                                                        false}) async {},
                                                hideTooltip: (
                                                    {immediately =
                                                        true}) async {});
                                            controller.showTooltip(
                                                autoClose: true,
                                                immediately: false);
                                          },
                                          child: GestureDetector(
                                            onLongPress: () {
                                              controller.attach(
                                                  showTooltip: (
                                                      {autoClose = true,
                                                      immediately =
                                                          false}) async {},
                                                  hideTooltip: (
                                                      {immediately =
                                                          true}) async {});
                                              controller.showTooltip(
                                                  autoClose: true,
                                                  immediately: false);
                                            },
                                            child: JustTheTooltip(
                                              controller: controller,
                                              content:
                                                  AppConfig.getHoverInnerWidget(
                                                      dummyMeasurementDataModel
                                                          .leftMotionDetectorValues![
                                                              index]
                                                          .name!,
                                                      [
                                                        KeyValueClass(
                                                          key: "Date",
                                                          value: AppConfig
                                                              .getFormattedOnlyDate(
                                                            dummyMeasurementDataModel
                                                                .leftMotionDetectorValues![
                                                                    index]
                                                                .time,
                                                          ),
                                                        ),
                                                        KeyValueClass(
                                                          key: "Time",
                                                          value: AppConfig
                                                              .getFormattedOnlyTime(
                                                            dummyMeasurementDataModel
                                                                .leftMotionDetectorValues![
                                                                    index]
                                                                .time,
                                                          ),
                                                        ),
                                                        KeyValueClass(
                                                          key: "Value",
                                                          value:
                                                              "${dummyMeasurementDataModel.leftMotionDetectorValues![index].value}",
                                                        ),
                                                        KeyValueClass(
                                                          key: "Battery",
                                                          value:
                                                              "${dummyMeasurementDataModel.leftMotionDetectorValues![index].battery} %",
                                                        ),
                                                      ],
                                                      context),
                                              child: Stack(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  AppConfig.isSensorStopped(
                                                          dummyMeasurementDataModel
                                                              .leftMotionDetectorValues![
                                                                  index]
                                                              .time)
                                                      ? ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.matrix(
                                                                  ColorFilterGenerator
                                                                      .saturationAdjustMatrix(
                                                            value: -1,
                                                          )),
                                                          child: Image.asset(
                                                            "asset/prox_sensor_left.png",
                                                            height:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        )
                                                      : Transform.scale(
                                                          scale: logic.hoverID ==
                                                                  dummyMeasurementDataModel
                                                                      .leftMotionDetectorValues![
                                                                          index]
                                                                      .id
                                                              ? 1.3
                                                              : 1,
                                                          child: Image.asset(
                                                            "asset/prox_sensor_left.png",
                                                            // width: getRelativeSize(logic.stackSize.width, 4),
                                                            color: AppConfig.isSensorStopped(
                                                                    dummyMeasurementDataModel
                                                                        .leftMotionDetectorValues![
                                                                            index]
                                                                        .time)
                                                                ? Colors
                                                                    .blueGrey
                                                                : logic.hoverID ==
                                                                        dummyMeasurementDataModel
                                                                            .leftMotionDetectorValues![
                                                                                index]
                                                                            .id
                                                                    ? Colors.amber[
                                                                        800]
                                                                    : dummyMeasurementDataModel.leftMotionDetectorValues![index].value! >
                                                                            0.7
                                                                        ? appDangerTextColor
                                                                        : null,
                                                            height:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        ),
                                                  if (dummyMeasurementDataModel
                                                              .leftMotionDetectorValues![
                                                                  index]
                                                              .battery !=
                                                          null &&
                                                      dummyMeasurementDataModel
                                                              .leftMotionDetectorValues![
                                                                  index]
                                                              .battery! <
                                                          AppConfig
                                                              .BATTERY_LEVEL)
                                                    Center(
                                                      child: FadeTransition(
                                                        opacity: logic
                                                            .blinkAnimation,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .amberAccent,
                                                                spreadRadius:
                                                                    getWidth(
                                                                        0.2,
                                                                        context),
                                                                blurRadius:
                                                                    getWidth(
                                                                        0.7,
                                                                        context),
                                                                offset: const Offset(
                                                                    0,
                                                                    0), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Image.asset(
                                                            "asset/battery-status.png",
                                                            width:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        DottedBorder(
                                          color: AppConfig.isSensorStopped(
                                                  dummyMeasurementDataModel
                                                      .leftMotionDetectorValues![
                                                          index]
                                                      .time!)
                                              ? Colors.blueGrey
                                              : logic.hoverID ==
                                                      dummyMeasurementDataModel
                                                          .leftMotionDetectorValues![
                                                              index]
                                                          .id
                                                  ? Colors.amber[800]!
                                                  : dummyMeasurementDataModel
                                                              .leftMotionDetectorValues![
                                                                  index]
                                                              .value! >
                                                          0.7
                                                      ? appDangerTextColor
                                                      : appPrimaryColor,
                                          // strokeWidth: getWidth(0),
                                          strokeWidth: dummyMeasurementDataModel
                                                      .leftMotionDetectorValues![
                                                          index]
                                                      .value! >
                                                  0.7
                                              ? 3
                                              : 1,
                                          borderType: BorderType.RRect,
                                          padding: EdgeInsets.zero,
                                          // dashPattern: [2,1],
                                          dashPattern: dummyMeasurementDataModel
                                                      .leftMotionDetectorValues![
                                                          index]
                                                      .value! >
                                                  0.7
                                              ? [1, 0]
                                              : [8, 15],
                                          child: SizedBox(
                                            width: getRelativeSize(
                                                logic.stackSize.width, 80),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Positioned(
                                top: getRelativeSize(logic.stackSize.height, 2),
                                bottom:
                                    getRelativeSize(logic.stackSize.height, 2),
                                right: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      dummyMeasurementDataModel
                                          .rightMotionDetectorValues!
                                          .length, (index) {
                                    JustTheController controller =
                                        JustTheController();
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DottedBorder(
                                          color: AppConfig.isSensorStopped(
                                                  dummyMeasurementDataModel
                                                      .rightMotionDetectorValues![
                                                          index]
                                                      .time)
                                              ? Colors.blueGrey
                                              : logic.hoverID ==
                                                      dummyMeasurementDataModel
                                                          .rightMotionDetectorValues![
                                                              index]
                                                          .id
                                                  ? Colors.amber[800]!
                                                  : dummyMeasurementDataModel
                                                              .rightMotionDetectorValues![
                                                                  index]
                                                              .value! >
                                                          0.7
                                                      ? appDangerTextColor
                                                      : appPrimaryColor,

                                          // strokeWidth: getWidth(0),
                                          strokeWidth: dummyMeasurementDataModel
                                                      .rightMotionDetectorValues![
                                                          index]
                                                      .value! >
                                                  0.7
                                              ? 3
                                              : 1,
                                          borderType: BorderType.RRect,
                                          padding: EdgeInsets.zero,
                                          // dashPattern: [2,1],
                                          dashPattern: dummyMeasurementDataModel
                                                      .rightMotionDetectorValues![
                                                          index]
                                                      .value! >
                                                  0.7
                                              ? [1, 0]
                                              : [8, 15],
                                          child: SizedBox(
                                            width: getRelativeSize(
                                                logic.stackSize.width, 80),
                                          ),
                                        ),
                                        MouseRegion(
                                          onHover: (e) {
                                            controller.attach(
                                                showTooltip: (
                                                    {autoClose = true,
                                                    immediately =
                                                        false}) async {},
                                                hideTooltip: (
                                                    {immediately =
                                                        true}) async {});
                                            controller.showTooltip(
                                                autoClose: true,
                                                immediately: false);
                                          },
                                          child: GestureDetector(
                                            onLongPress: () {
                                              controller.attach(
                                                  showTooltip: (
                                                      {autoClose = true,
                                                      immediately =
                                                          false}) async {},
                                                  hideTooltip: (
                                                      {immediately =
                                                          true}) async {});
                                              controller.showTooltip(
                                                  autoClose: true,
                                                  immediately: false);
                                            },
                                            child: JustTheTooltip(
                                              controller: controller,
                                              content:
                                                  AppConfig.getHoverInnerWidget(
                                                      dummyMeasurementDataModel
                                                          .rightMotionDetectorValues![
                                                              index]
                                                          .name!,
                                                      [
                                                        KeyValueClass(
                                                          key: "Date",
                                                          value: AppConfig
                                                              .getFormattedOnlyDate(
                                                            dummyMeasurementDataModel
                                                                .rightMotionDetectorValues![
                                                                    index]
                                                                .time,
                                                          ),
                                                        ),
                                                        KeyValueClass(
                                                          key: "Time",
                                                          value: AppConfig
                                                              .getFormattedOnlyTime(
                                                            dummyMeasurementDataModel
                                                                .rightMotionDetectorValues![
                                                                    index]
                                                                .time,
                                                          ),
                                                        ),
                                                        KeyValueClass(
                                                          key: "Value",
                                                          value:
                                                              "${dummyMeasurementDataModel.rightMotionDetectorValues![index].value}",
                                                        ),
                                                        KeyValueClass(
                                                          key: "Battery",
                                                          value:
                                                              "${dummyMeasurementDataModel.rightMotionDetectorValues![index].battery} %",
                                                        ),
                                                      ],
                                                      context),
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  AppConfig.isSensorStopped(
                                                          dummyMeasurementDataModel
                                                              .rightMotionDetectorValues![
                                                                  index]
                                                              .time)
                                                      ? ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.matrix(
                                                                  ColorFilterGenerator
                                                                      .saturationAdjustMatrix(
                                                            value: -1,
                                                          )),
                                                          child: Image.asset(
                                                            "asset/prox_sensor_right.png",
                                                            height:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        )
                                                      : Transform.scale(
                                                          scale: logic.hoverID ==
                                                                  dummyMeasurementDataModel
                                                                      .rightMotionDetectorValues![
                                                                          index]
                                                                      .id
                                                              ? 1.3
                                                              : 1,
                                                          child: Image.asset(
                                                            "asset/prox_sensor_right.png",
                                                            // width: getRelativeSize(logic.stackSize.width, 4),
                                                            color: logic.hoverID ==
                                                                    dummyMeasurementDataModel
                                                                        .rightMotionDetectorValues![
                                                                            index]
                                                                        .id
                                                                ? Colors
                                                                    .amber[800]!
                                                                : dummyMeasurementDataModel
                                                                            .rightMotionDetectorValues![index]
                                                                            .value! >
                                                                        0.7
                                                                    ? appDangerTextColor
                                                                    : null,
                                                            height:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        ),
                                                  if (dummyMeasurementDataModel
                                                              .rightMotionDetectorValues![
                                                                  index]
                                                              .battery !=
                                                          null &&
                                                      dummyMeasurementDataModel
                                                              .rightMotionDetectorValues![
                                                                  index]
                                                              .battery! <
                                                          AppConfig
                                                              .BATTERY_LEVEL)
                                                    Center(
                                                      child: FadeTransition(
                                                        opacity: logic
                                                            .blinkAnimation,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .amberAccent,
                                                                spreadRadius:
                                                                    getWidth(
                                                                        0.2,
                                                                        context),
                                                                blurRadius:
                                                                    getWidth(
                                                                        0.7,
                                                                        context),
                                                                offset: const Offset(
                                                                    0,
                                                                    0), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Image.asset(
                                                            "asset/battery-status.png",
                                                            width:
                                                                getRelativeSize(
                                                                    logic
                                                                        .stackSize
                                                                        .height,
                                                                    4),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              if (dummyMeasurementDataModel.gridData != null)
                                Container(
                                  height: logic.stackSize.height,
                                  width: logic.stackSize.width,
                                  margin: EdgeInsets.all(getRelativeSize(
                                      logic.stackSize.width, 2)),
                                  child: logic.getSmokeSensorWidget(
                                      "1A", context, dummyMeasurementDataModel),
                                ),
                              if (dummyMeasurementDataModel.doorsData != null &&
                                  dummyMeasurementDataModel
                                          .doorsData!.leftDoors !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .doorsData!.leftDoors!.isNotEmpty)
                                Positioned(
                                  top: getWidth(0.5, context),
                                  bottom: getWidth(0.5, context),
                                  left: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .doorsData!.leftDoors!.length,
                                      (index) => DoorWidgetPage(
                                        blinkAnimation: logic.blinkAnimation,
                                        doorWidgetData: DoorWidgetData(
                                          dummyMeasurementDataModel.doorsData!
                                              .leftDoors![index].isRunning!,
                                          DoorDirection.LEFT,
                                        ),
                                        hoverID: logic.hoverID,
                                        leftDoors: dummyMeasurementDataModel
                                            .doorsData!.leftDoors![index],
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.doorsData != null &&
                                  dummyMeasurementDataModel
                                          .doorsData!.rightDoors !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .doorsData!.rightDoors!.isNotEmpty)
                                Positioned(
                                  top: getWidth(0.5, context),
                                  bottom: getWidth(0.5, context),
                                  right: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .doorsData!.rightDoors!.length,
                                      (index) => DoorWidgetPage(
                                        blinkAnimation: logic.blinkAnimation,
                                        doorWidgetData: DoorWidgetData(
                                          dummyMeasurementDataModel.doorsData!
                                              .rightDoors![index].isRunning!,
                                          DoorDirection.RIGHT,
                                        ),
                                        hoverID: logic.hoverID,
                                        leftDoors: dummyMeasurementDataModel
                                            .doorsData!.rightDoors![index],
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.doorsData != null &&
                                  dummyMeasurementDataModel
                                          .doorsData!.topDoors !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .doorsData!.topDoors!.isNotEmpty)
                                Positioned(
                                  top: 0,
                                  right: getWidth(0.5, context),
                                  left: getWidth(0.5, context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .doorsData!.topDoors!.length,
                                      (index) => DoorWidgetPage(
                                        blinkAnimation: logic.blinkAnimation,
                                        doorWidgetData: DoorWidgetData(
                                          dummyMeasurementDataModel.doorsData!
                                              .topDoors![index].isRunning!,
                                          DoorDirection.UP,
                                        ),
                                        hoverID: logic.hoverID,
                                        leftDoors: dummyMeasurementDataModel
                                            .doorsData!.topDoors![index],
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.doorsData != null &&
                                  dummyMeasurementDataModel
                                          .doorsData!.bottomDoors !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .doorsData!.bottomDoors!.isNotEmpty)
                                Positioned(
                                  bottom: 0,
                                  right: getWidth(0.5, context),
                                  left: getWidth(0.5, context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .doorsData!.bottomDoors!.length,
                                      (index) => DoorWidgetPage(
                                        blinkAnimation: logic.blinkAnimation,
                                        doorWidgetData: DoorWidgetData(
                                          dummyMeasurementDataModel.doorsData!
                                              .bottomDoors![index].isRunning!,
                                          DoorDirection.DOWN,
                                        ),
                                        hoverID: logic.hoverID,
                                        leftDoors: dummyMeasurementDataModel
                                            .doorsData!.bottomDoors![index],
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.measurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                          .measurement!.leftMeasurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .measurement!.leftMeasurement!.isNotEmpty)
                                Positioned(
                                  top: getWidth(2, context),
                                  bottom: getWidth(2, context),
                                  left: getWidth(3, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .measurement!.leftMeasurement!.length,
                                      (index) => MeasurementWidget(
                                        measurementData:
                                            dummyMeasurementDataModel
                                                .measurement!
                                                .leftMeasurement![index],
                                        blinkAnimation: logic.blinkAnimation,
                                        sensorPosition: SensorPosition.Left,
                                        measurementHighAnimation:
                                            logic.measurementHighAnimation,
                                        direction: Direction.Vertical,
                                        hoverID: logic.hoverID,
                                        tabMenus: logic.tabMenus,
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.measurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                          .measurement!.rightMeasurement !=
                                      null &&
                                  dummyMeasurementDataModel.measurement!
                                      .rightMeasurement!.isNotEmpty)
                                Positioned(
                                  top: getWidth(2, context),
                                  bottom: getWidth(2, context),
                                  right: getWidth(3, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      dummyMeasurementDataModel.measurement!
                                          .rightMeasurement!.length,
                                      (index) => MeasurementWidget(
                                        measurementData:
                                            dummyMeasurementDataModel
                                                .measurement!
                                                .rightMeasurement![index],
                                        sensorPosition: SensorPosition.Right,
                                        blinkAnimation: logic.blinkAnimation,
                                        measurementHighAnimation:
                                            logic.measurementHighAnimation,
                                        direction: Direction.Vertical,
                                        hoverID: logic.hoverID,
                                        tabMenus: logic.tabMenus,
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.measurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                          .measurement!.topMeasurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                      .measurement!.topMeasurement!.isNotEmpty)
                                Positioned(
                                  top: getWidth(2, context),
                                  right: getWidth(2, context),
                                  left: getWidth(2, context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      dummyMeasurementDataModel
                                          .measurement!.topMeasurement!.length,
                                      (index) => MeasurementWidget(
                                        blinkAnimation: logic.blinkAnimation,
                                        measurementData:
                                            dummyMeasurementDataModel
                                                .measurement!
                                                .topMeasurement![index],
                                        sensorPosition: SensorPosition.Top,
                                        measurementHighAnimation:
                                            logic.measurementHighAnimation,
                                        direction: Direction.Horizontal,
                                        hoverID: logic.hoverID,
                                        tabMenus: logic.tabMenus,
                                      ),
                                    ),
                                  ),
                                ),
                              if (dummyMeasurementDataModel.measurement !=
                                      null &&
                                  dummyMeasurementDataModel
                                          .measurement!.bottomMeasurement !=
                                      null &&
                                  dummyMeasurementDataModel.measurement!
                                      .bottomMeasurement!.isNotEmpty)
                                Positioned(
                                  bottom: getWidth(2, context),
                                  right: getWidth(2, context),
                                  left: getWidth(2, context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      dummyMeasurementDataModel.measurement!
                                          .bottomMeasurement!.length,
                                      (index) => MeasurementWidget(
                                        blinkAnimation: logic.blinkAnimation,
                                        measurementData:
                                            dummyMeasurementDataModel
                                                .measurement!
                                                .bottomMeasurement![index],
                                        sensorPosition: SensorPosition.Bottom,
                                        measurementHighAnimation:
                                            logic.measurementHighAnimation,
                                        direction: Direction.Horizontal,
                                        hoverID: logic.hoverID,
                                        tabMenus: logic.tabMenus,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(1, context),
                        ),
                        Expanded(
                          child: Container(
                            height: logic.stackSize.height,
                            decoration: BoxDecoration(
                                color: appWhiteColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(getWidth(1, context))),
                                boxShadow: [
                                  BoxShadow(
                                      color: logic.highMeasurement!.isNotEmpty
                                          ? appDangerShadowColor
                                          : appGreenColor,
                                      offset: Offset(0, 0),
                                      blurRadius: getWidth(0.8, context))
                                ]),
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(
                                    AppConfig.DEFAULT_PADDING / 2, context),
                                vertical: getWidth(
                                    AppConfig.DEFAULT_PADDING / 2, context)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    logic.highMeasurement!.isNotEmpty
                                        ? "Alerts"
                                        : "No Alerts",
                                    style: FSMResources.FSMTextStyle(
                                      color: logic.highMeasurement!.isNotEmpty
                                          ? appDangerShadowColor
                                          : appGreenColor,
                                      size: AppConfig.FONT_SIZE_H3,
                                      type: TextStyleType.bold,
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(
                                        AppConfig.DEFAULT_PADDING / 2, context),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      logic.highMeasurement!.length,
                                      (index) => MouseRegion(
                                        onEnter: (event) {
                                          // Get.log(
                                          //     "Enter at ${logic.highMeasurement![index].id}");
                                          logic.hoverWidget(
                                              logic.highMeasurement![index].id,
                                              logic.highMeasurement![index]
                                                  .type);
                                        },
                                        onExit: (event) {
                                          logic.hoverWidget("", TabMenus.ALL);
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            logic.openTrendDialog(
                                                logic.highMeasurement![index],
                                                logic.highMeasurement![index]
                                                    .type,
                                                context);
                                          },
                                          onLongPress: () {
                                            logic.hoverWidget(
                                                logic
                                                    .highMeasurement![index].id,
                                                logic.highMeasurement![index]
                                                    .type);
                                            Future.delayed(
                                                (Duration(seconds: 3)), () {
                                              logic.hoverWidget(
                                                  "", TabMenus.ALL);
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: getWidth(1, context),
                                              left: getWidth(
                                                  AppConfig.DEFAULT_PADDING / 2,
                                                  context),
                                              right: getWidth(
                                                  AppConfig.DEFAULT_PADDING / 2,
                                                  context),
                                            ),
                                            padding: EdgeInsets.all(
                                                getWidth(0.7, context)),
                                            // height: getWidth(0.6),
                                            decoration: BoxDecoration(
                                                color: appWhiteColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(getWidth(
                                                        0.3, context))),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          appDangerShadowColor,
                                                      offset: Offset(0, 0),
                                                      blurRadius: getWidth(
                                                          0.8, context))
                                                ]),
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: getWidth(2, context),
                                                  child: Image.asset(
                                                    logic.getFilePath(
                                                        logic.highMeasurement![
                                                            index]),
                                                    width:
                                                        getWidth(1.7, context),
                                                    height:
                                                        getWidth(1.7, context),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                logic.getTabMenuName(logic
                                                                    .highMeasurement![
                                                                        index]
                                                                    .type),
                                                                style: FSMResources
                                                                    .FSMTextStyle(
                                                                  color:
                                                                      appDangerTextColor,
                                                                  size: AppConfig
                                                                      .FONT_SIZE_H6,
                                                                  context:
                                                                      context,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: getWidth(
                                                                6, context),
                                                            child: Text(
                                                              "${logic.getSensorValue(logic.highMeasurement![index])} ${logic.getSensorUnit(logic.highMeasurement![index])} ",
                                                              style: FSMResources
                                                                  .FSMTextStyle(
                                                                color:
                                                                    appDangerTextColor,
                                                                size: AppConfig
                                                                    .FONT_SIZE_H7,
                                                                context:
                                                                    context,
                                                                type:
                                                                    TextStyleType
                                                                        .bold,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Center(
                                                            child: Text(
                                                              logic.getTabMenuDescription(
                                                                  logic
                                                                      .highMeasurement![
                                                                          index]
                                                                      .type),
                                                              style: FSMResources
                                                                  .FSMTextStyle(
                                                                color:
                                                                    appDangerTextColor,
                                                                size: AppConfig
                                                                    .FONT_SIZE_H8,
                                                                context:
                                                                    context,
                                                                type:
                                                                    TextStyleType
                                                                        .italic,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          )),
                                                          Text(
                                                            AppConfig.getFormattedOnlyTime(
                                                                logic
                                                                    .highMeasurement![
                                                                        index]
                                                                    .time),
                                                            style: FSMResources
                                                                .FSMTextStyle(
                                                              color:
                                                                  appDangerTextColor,
                                                              size: 1,
                                                              context: context,
                                                              type:
                                                                  TextStyleType
                                                                      .italic,
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
