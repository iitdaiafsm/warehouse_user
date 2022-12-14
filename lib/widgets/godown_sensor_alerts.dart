import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/color_helper.dart';
import 'package:warehouse_user/helper/extensions.dart';
import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

import '../helper/models/alert_sensor_data.dart';
import '../helper/styles.dart';

class GodownSensorsAlerts extends StatelessWidget {
  final WarehouseController controller;

  const GodownSensorsAlerts({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AlertSensorData> alerts = AppMethods.setAlerts(
        controller.selectedGodown, controller.selectedWarehouse);
    return Container(
        margin: EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING),
        padding: EdgeInsets.only(top: AppMethods.DEFAULT_PADDING),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: alerts.isNotEmpty ? redColor : greenColor,
              blurRadius: 6,
            ),
          ],
        ),
        child: ListView(
          children: [
            Center(
              child: Text(
                alerts.isEmpty ? "No Alert" : "Alerts",
                style: textStyle(
                  context: context,
                  isBold: true,
                  color: alerts.isEmpty ? greenColor : redColor,
                ),
              ),
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING * 2,
            ),
            ...List.generate(
              alerts.length,
              (index) => Container(
                margin: EdgeInsets.only(
                  bottom: AppMethods.DEFAULT_PADDING,
                  left: AppMethods.DEFAULT_PADDING,
                  right: AppMethods.DEFAULT_PADDING,
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
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? 25
                                : 50,
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 25
                                : 50,
                            fit: BoxFit.contain,
                          )
                        : SizedBox(
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? 25
                                : 50,
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 25
                                : 50,
                          ),
                    SizedBox(
                      width: AppMethods.DEFAULT_PADDING,
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, mConstraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: mConstraints.maxWidth,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
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
                                    color:
                                        alerts.isEmpty ? greenColor : redColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
