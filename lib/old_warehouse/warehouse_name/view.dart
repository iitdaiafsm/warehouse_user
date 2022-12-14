import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';
import 'package:warehouse_user/old_warehouse/warehouse_global_controller.dart';

import '../../helper/routes.dart';
import '../utils/app_config.dart';
import '../utils/app_size.dart';
import '../utils/colors.dart';
import '../utils/fsm_resource.dart';
import '../utils_widgets/flutter_bounce.dart';

class WarehouseNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: GetBuilder<WarehouseGlobalController>(
            init: WarehouseGlobalController(),
            builder: (logic) {
              return Container(
                padding: EdgeInsets.all(
                    getWidth(AppConfig.DEFAULT_PADDING, context)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        margin: EdgeInsets.all(getWidth(1, context)),
                        padding: EdgeInsets.all(getWidth(1, context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce(
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
                              ),
                              onPressed: () {
                                // Get.offNamed(Routes.INITIAL_ROUTE);
                                Get.rootDelegate
                                    .backUntil(Routes.INITIAL_ROUTE);
                              },
                            ),
                            Text(
                              "FCI Pusa, Delhi",
                              style: FSMResources.FSMTextStyle(
                                color: appPrimaryColor,
                                size: AppConfig.FONT_SIZE_H1,
                                type: TextStyleType.bold,
                                context: context,
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Bounce(
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
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: getWidth(AppConfig.DEFAULT_PADDING, context),
                      // ),

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: getWidth(0, context),
                            crossAxisSpacing: getWidth(1, context),
                            childAspectRatio: 0.5),
                        itemCount: logic.warehouseLocationsList.length,
                        itemBuilder: (ctx, index) => Bounce(
                            child: _getWidget(
                                context,
                                logic.warehouseLocationsList[index],
                                logic.measurementList[index]),
                            onPressed: () {
                              if (index == 0) {
                                logic.goToNextPage(index);
                              } else {
                                /*Get.snackbar("Alert", "Coming Soon...",
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderWidth: getWidth(0.1,Get.context!),
                                    borderColor: appPrimaryColor,
                                    margin: EdgeInsets.all(
                                      getWidth(2,Get.context!),
                                    ),
                                    titleText: Text(
                                      "Alert",
                                      style: FSMResources.FSMTextStyle(
                                          type: TextStyleType.bold,
                                          color: appTextDarkColor,
                                          size: AppConfig.FONT_SIZE_H5,
                                          context: Get.context!
                                      ),
                                    ),
                                    messageText: Text(
                                      "Coming Soon...",
                                      style: FSMResources.FSMTextStyle(
                                          type: TextStyleType.regular,
                                          color: appTextDarkColor,
                                          size: AppConfig.FONT_SIZE_H6,
                                          context: Get.context!
                                      ),
                                    ));*/
                              }
                            }),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      onWillPop: () async {
        // Get.offNamed(Routes.INITIAL_ROUTE);
        Get.rootDelegate.backUntil(Routes.INITIAL_ROUTE);
        return Future.value(true);
      },
    );
  }

  _getWidget(BuildContext context, String title,
      DummyMeasurementDataModel dummyMeasurementDataModel) {
    List<CustomMeasurement>? highMeasurement =
        AppConfig.getAlertList(dummyMeasurementDataModel);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(getWidth(1, context)),

      // height: getWidth(0.6),
      decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius:
              BorderRadius.all(Radius.circular(getWidth(0.5, context))),
          boxShadow: [
            BoxShadow(
                color: title != "1A"
                    ? Colors.blueGrey
                    : highMeasurement.isNotEmpty
                        ? appDangerShadowColor
                        : appGreenColor,
                offset: Offset(0, 0),
                blurRadius: getWidth(0.8, context))
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getWidth(0.5, context)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(getWidth(0.3, context)),
                  // height: getWidth(0.6),
                  decoration: BoxDecoration(
                      color: appWhiteColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(getWidth(0.5, context))),
                      boxShadow: [
                        BoxShadow(
                            color: title != "1A"
                                ? Colors.blueGrey
                                : highMeasurement.isNotEmpty
                                    ? appDangerShadowColor
                                    : appGreenColor,
                            offset: Offset(0, 0),
                            blurRadius: getWidth(0.8, context))
                      ]),
                  child: Text(
                    title,
                    style: FSMResources.FSMTextStyle(
                      context: context,
                      color: title != "1A"
                          ? Colors.blueGrey
                          : highMeasurement.isNotEmpty
                              ? appDangerTextColor
                              : appGreenColor,
                      size: AppConfig.FONT_SIZE_H4,
                      type: TextStyleType.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                ),
                Image.asset(
                  "asset/warehouse_icon.png",
                  width: getWidth(10, context),
                ),
                SizedBox(
                  height: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                ),
                Text(
                  title != "1A"
                      ? "Coming Soon"
                      : highMeasurement.isNotEmpty
                          ? "Alerts"
                          : "No Alert",
                  style: FSMResources.FSMTextStyle(
                    context: context,
                    color: title != "1A"
                        ? Colors.blueGrey
                        : highMeasurement.isNotEmpty
                            ? appDangerTextColor
                            : appGreenColor,
                    size: AppConfig.FONT_SIZE_H4,
                    type: TextStyleType.bold,
                  ),
                ),
              ],
            ),
          ),
          if (highMeasurement.isNotEmpty)
            SizedBox(
              height: getHeight(17, context),
              child: ListView(
                children: List.generate(
                  highMeasurement.length,
                  (index) => Container(
                    margin: EdgeInsets.only(
                      bottom: getWidth(1, context),
                      top: index == 0 ? getWidth(1, context) : 0,
                      left: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                      right: getWidth(AppConfig.DEFAULT_PADDING / 2, context),
                    ),
                    padding: EdgeInsets.all(getWidth(0.7, context)),
                    // height: getWidth(0.6),
                    decoration: BoxDecoration(
                        color: appWhiteColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(getWidth(0.3, context))),
                        boxShadow: [
                          BoxShadow(
                              color: appDangerShadowColor,
                              offset: Offset(0, 0),
                              blurRadius: getWidth(0.8, context))
                        ]),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: getWidth(2, context),
                          child: Image.asset(
                            getFilePath(highMeasurement[index]),
                            width: getWidth(1.7, context),
                            height: getWidth(1.7, context),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        getTabMenuName(
                                            highMeasurement[index].type),
                                        style: FSMResources.FSMTextStyle(
                                            color: appDangerTextColor,
                                            size: AppConfig.FONT_SIZE_H9,
                                            context: context,
                                            type: TextStyleType.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getWidth(6, context),
                                    child: Text(
                                      "${getSensorValue(highMeasurement[index])} ${getSensorUnit(highMeasurement[index])} ",
                                      style: FSMResources.FSMTextStyle(
                                        color: appDangerTextColor,
                                        size: AppConfig.FONT_SIZE_H8,
                                        context: context,
                                        type: TextStyleType.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      getTabMenuDescription(
                                          highMeasurement[index].type),
                                      style: FSMResources.FSMTextStyle(
                                        color: appDangerTextColor,
                                        size: AppConfig.FONT_SIZE_H9,
                                        context: context,
                                        type: TextStyleType.italic,
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                  Text(
                                    AppConfig.getFormattedOnlyTime(
                                        highMeasurement[index].time),
                                    style: FSMResources.FSMTextStyle(
                                      color: appDangerTextColor,
                                      size: AppConfig.FONT_SIZE_H9,
                                      context: context,
                                      type: TextStyleType.italic,
                                    ),
                                    textAlign: TextAlign.end,
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
            )
        ],
      ),
    );
  }

  String getFilePath(CustomMeasurement highMeasurement) {
    switch (highMeasurement.type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "";
      case TabMenus.TEMPERATURE:
        return "asset/temperature_high.png";
      case TabMenus.HUMDITY:
        return "asset/drop_high.png";
      case TabMenus.CO2:
        return "asset/cloud_high.png";
      case TabMenus.RODENTS:
        return "asset/prox_sensor_down.png";
      case TabMenus.GAS:
        return "asset/gas_icon.png";
      case TabMenus.OXYGEN:
        return "asset/oxygen.png";
      case TabMenus.SMOKE:
        return "asset/smoke_icon.png";
      case TabMenus.AIRFLOW:
        return "asset/fan_low.png";
    }
  }

  String getTabMenuName(TabMenus type) {
    switch (type) {
      case TabMenus.ALL:
        return "All";
      case TabMenus.DOORS:
        return "Doors";
      case TabMenus.TEMPERATURE:
        return "Temperature";
      case TabMenus.HUMDITY:
        return "Humidity";
      case TabMenus.CO2:
        return "CO2";
      case TabMenus.RODENTS:
        return "Rodent";
      case TabMenus.GAS:
        return "Gas";
      case TabMenus.OXYGEN:
        return "Oxygen";
      case TabMenus.SMOKE:
        return "Smoke";
      case TabMenus.AIRFLOW:
        return "Airflow";
    }
  }

  String getTabMenuDescription(TabMenus type) {
    switch (type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "Please check if entry is authorised";
      case TabMenus.TEMPERATURE:
        return "Please open warehouse doors for ventilation";
      case TabMenus.HUMDITY:
        return "Please open warehouse doors for ventilation";
      case TabMenus.CO2:
        return "Please check for potential infestation";
      case TabMenus.RODENTS:
        return "Please take corrective and preventive actions";
      case TabMenus.GAS:
        return "";
      case TabMenus.OXYGEN:
        return "";
      case TabMenus.SMOKE:
        return "Critical Alert: Please check immediately";
      case TabMenus.AIRFLOW:
        return "";
    }
  }

  String getSensorValue(CustomMeasurement customMeasurement) {
    switch (customMeasurement.type) {
      case TabMenus.ALL:
        return customMeasurement.value.toString();
      case TabMenus.DOORS:
        return "Open";
      case TabMenus.TEMPERATURE:
        return customMeasurement.value.toString();
      case TabMenus.HUMDITY:
        return customMeasurement.value.toString();
      case TabMenus.CO2:
        return customMeasurement.value.toString();
      case TabMenus.RODENTS:
        return "!";
      case TabMenus.GAS:
        return customMeasurement.value.toString();
      case TabMenus.OXYGEN:
        return customMeasurement.value.toString();
      case TabMenus.SMOKE:
        return "Not Safe";
      case TabMenus.AIRFLOW:
        return customMeasurement.value.toString();
    }
  }

  String getSensorUnit(CustomMeasurement highMeasurement) {
    switch (highMeasurement.type) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "";
      case TabMenus.TEMPERATURE:
        return "\u00B0C";
      case TabMenus.HUMDITY:
        return "%";
      case TabMenus.CO2:
        return "ppm";
      case TabMenus.RODENTS:
        return "";
      case TabMenus.GAS:
        return "ppm";
      case TabMenus.OXYGEN:
        return "%";
      case TabMenus.SMOKE:
        return "";
      case TabMenus.AIRFLOW:
        return "L/min";
    }
  }
}
