import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/color_helper.dart';
import 'package:warehouse_user/helper/extensions.dart';
import 'package:warehouse_user/helper/models/warehouse_model.dart';
import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/helper/styles.dart';
import 'package:warehouse_user/widgets/flutter_bounce.dart';

import '../helper/models/alert_sensor_data.dart';
import '../helper/models/godown_model.dart';

class LargeGodownWidget extends StatelessWidget {
  final List<GodownModel> godowns;
  final WarehouseModel warehouseModel;
  final Function(GodownModel) selectedGodown;

  const LargeGodownWidget(
      {Key? key,
      required this.godowns,
      required this.warehouseModel,
      required this.selectedGodown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GodownModel> filterGodowns = godowns
        .where((element) => element.warehouseId == warehouseModel.id)
        .toList();
    for (var item in filterGodowns) {
      // print(jsonEncode(item));
      // print("----");
    }
    return ResponsiveWidget.isLargeScreen(context)
        ? SizedBox(
            width: width(context),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runSpacing: AppMethods.DEFAULT_PADDING,
                spacing: AppMethods.DEFAULT_PADDING,
                runAlignment: WrapAlignment.start,
                children: List.generate(
                  filterGodowns.length,
                  (index) => Bounce(
                    onPressed: () {
                      selectedGodown(filterGodowns[index]);
                    },
                    child: GodownWidgetLarge(
                        godownModel: filterGodowns[index],
                        warehouseModel: warehouseModel),
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
            child: Column(
              children: List.generate(
                  filterGodowns.length,
                  (index) => Bounce(
                        onPressed: () {
                          selectedGodown(filterGodowns[index]);
                        },
                        child: GodownWidgetSmall(
                            godownModel: filterGodowns[index],
                            warehouseModel: warehouseModel),
                      )),
            ),
          );
  }
}

class GodownWidgetLarge extends StatelessWidget {
  final GodownModel godownModel;
  final WarehouseModel warehouseModel;

  List<AlertSensorData> alerts = [];

  GodownWidgetLarge(
      {Key? key, required this.godownModel, required this.warehouseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    alerts = AppMethods.setAlerts(godownModel, warehouseModel);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 350,
        minHeight: 700,
        maxHeight: 700,
        minWidth: 175,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: alerts.isEmpty ? greenColor : redColor,
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppMethods.DEFAULT_PADDING,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppMethods.DEFAULT_PADDING,
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  color: alerts.isEmpty ? greenColor : redColor,
                ),
              ],
              borderRadius: BorderRadius.circular(
                AppMethods.DEFAULT_PADDING,
              ),
            ),
            padding: EdgeInsets.all(
              AppMethods.DEFAULT_PADDING,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  godownModel.name ?? "",
                  style: textStyle(
                    context: context,
                    isBold: true,
                    fontSize: FontSize.H3,
                    color: alerts.isEmpty ? greenColor : redColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          Image.asset(
            "asset/warehouse_icon.png",
            width: 200,
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          Text(
            alerts.isEmpty ? "No Alert" : "Alerts",
            style: textStyle(
              context: context,
              isBold: true,
              color: alerts.isEmpty ? greenColor : redColor,
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  alerts.length,
                  (index) => Container(
                    margin: EdgeInsets.all(
                      AppMethods.DEFAULT_PADDING,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: alerts.isEmpty ? greenColor : redColor,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        AppMethods.DEFAULT_PADDING,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppMethods.DEFAULT_PADDING,
                      vertical: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    child: Row(
                      children: [
                        alerts[index].iconPath != null &&
                                alerts[index].iconPath!.isNotEmpty
                            ? Image.asset(
                                alerts[index].iconPath!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              )
                            : SizedBox(
                                width: 50,
                                height: 50,
                              ),
                        SizedBox(
                          width: AppMethods.DEFAULT_PADDING,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    alerts[index].type ?? "",
                                    style: textStyle(
                                      context: context,
                                      isBold: true,
                                      fontSize: FontSize.H4,
                                      color: alerts.isEmpty
                                          ? greenColor
                                          : redColor,
                                    ),
                                  ),
                                  Text(
                                    (alerts[index].value ?? " "),
                                    style: textStyle(
                                      context: context,
                                      isBold: true,
                                      fontSize: FontSize.H3,
                                      color: alerts.isEmpty
                                          ? greenColor
                                          : redColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                alerts[index].message ?? "",
                                style: textStyle(
                                  context: context,
                                  fontSize: FontSize.H6,
                                  color: alerts.isEmpty ? greenColor : redColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    (alerts[index].time ?? " ").formatTime(),
                                    style: textStyle(
                                      context: context,
                                      isItalic: true,
                                      fontSize: FontSize.H7,
                                      color: alerts.isEmpty
                                          ? greenColor
                                          : redColor,
                                    ),
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
    );
  }
}

class GodownWidgetSmall extends StatelessWidget {
  final GodownModel godownModel;
  final WarehouseModel warehouseModel;

  List<AlertSensorData> alerts = [];

  GodownWidgetSmall(
      {Key? key, required this.godownModel, required this.warehouseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    alerts = AppMethods.setAlerts(godownModel, warehouseModel);
    return Container(
      width: width(context),
      height: ResponsiveWidget.isSmallScreen(context) ? 100 : 125,
      margin: EdgeInsets.only(top: AppMethods.DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: alerts.isEmpty ? greenColor : redColor,
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppMethods.DEFAULT_PADDING,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppMethods.DEFAULT_PADDING,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          Text(
            godownModel.name ?? "",
            style: textStyle(
              context: context,
              isBold: true,
              fontSize: FontSize.H2,
              color: alerts.isEmpty ? greenColor : redColor,
            ),
          ),
          alerts.isEmpty
              ? Center(
                  child: Text(
                    alerts.isEmpty ? "No Alert" : "Alerts",
                    style: textStyle(
                      context: context,
                      isBold: true,
                      color: alerts.isEmpty ? greenColor : redColor,
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        alerts.length,
                        (index) => Container(
                          width: ResponsiveWidget.isSmallScreen(context)
                              ? 250
                              : 300,
                          margin: EdgeInsets.all(
                            AppMethods.DEFAULT_PADDING,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: alerts.isEmpty ? greenColor : redColor,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              AppMethods.DEFAULT_PADDING,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppMethods.DEFAULT_PADDING,
                            vertical: AppMethods.DEFAULT_PADDING / 2,
                          ),
                          child: Row(
                            children: [
                              alerts[index].iconPath != null &&
                                      alerts[index].iconPath!.isNotEmpty
                                  ? Image.asset(
                                      alerts[index].iconPath!,
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.contain,
                                    )
                                  : SizedBox(
                                      width: 25,
                                      height: 25,
                                    ),
                              SizedBox(
                                width: AppMethods.DEFAULT_PADDING,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          alerts[index].type ?? "",
                                          style: textStyle(
                                            context: context,
                                            isBold: true,
                                            fontSize: FontSize.H3,
                                            color: alerts.isEmpty
                                                ? greenColor
                                                : redColor,
                                          ),
                                        ),
                                        Text(
                                          alerts[index].value ?? "",
                                          style: textStyle(
                                            context: context,
                                            isBold: true,
                                            fontSize: FontSize.H3,
                                            color: alerts.isEmpty
                                                ? greenColor
                                                : redColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      alerts[index].message ?? "",
                                      style: textStyle(
                                        context: context,
                                        fontSize: FontSize.H6,
                                        color: alerts.isEmpty
                                            ? greenColor
                                            : redColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          (alerts[index].time ?? " ")
                                              .formatTime(),
                                          style: textStyle(
                                            context: context,
                                            isItalic: true,
                                            fontSize: FontSize.H7,
                                            color: alerts.isEmpty
                                                ? greenColor
                                                : redColor,
                                          ),
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
    );
  }
}
