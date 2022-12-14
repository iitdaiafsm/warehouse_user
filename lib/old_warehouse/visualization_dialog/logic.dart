import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:influxdb_client/api.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/app_config.dart';
import '../utils/chart_sample_data.dart';

class VisualizationDialogLogic extends GetxController {
  // late Map<String, dynamic> argumentMap;
  late InfluxDBClient influxDBClient;
  late QueryService queryService;
  Widget dialogWidget = const Center(child: CircularProgressIndicator());
  List<ChartSampleData> chartsList = [];

  @override
  void onInit() {
    // argumentMap = Get.arguments;
    influxDBClient = InfluxDBClient(
      url: AppConfig.INFLUXDB_URL,
      token: AppConfig.INFLUXDB_TOKEN,
      org: AppConfig.INFLUXDB_ORG,
      bucket: 'vibes',
    );
    //
    queryService = influxDBClient.getQueryService();

    super.onInit();
  }

  Future<void> getAllHistoryOfSensor(
      String name, String field, TabMenus menus, BuildContext context) async {
    Get.log("Name : $name, Field : $field");
    var recordStream = await queryService.query('''
  from(bucket: "vibes")
  |> range(start: -30m)
  |> filter(fn: (r) => r["_measurement"] == "mqtt_consumer")
  |> filter(fn: (r) => r["topic"] == "/devices/vibes/$name")
  |> filter(fn: (r) => r["_field"] == "$field")
  |> filter(fn: (r) => r["host"] == "wfp-smartwarehouse.in")
  |> yield(name: "last")
  ''');

    var recordList = await recordStream.toList();
    Get.log("$recordList");
    for (var element in recordList) {
      chartsList.add(
        ChartSampleData(
            x: DateTime.parse(element['_time']).toLocal(),
            y: element['_value']),
        // y: Random().nextDouble()),
      );
    }
    Get.log("Data : ${jsonEncode(chartsList)}");
    dialogWidget = getTrendWidget(chartsList, menus, name, context);
    update();
  }

/*List<LineSeries<SalesData, num>> getDefaultData() {
    final List<SalesData> chartData = <SalesData>[
      SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
      SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
      SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
      SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
      SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
      SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
      SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
    ];
    return <LineSeries<SalesData, num>>[
      LineSeries<SalesData, num>(
          enableToolTip: isTooltipVisible,
          dataSource: chartData,
          xValueMapper: (SalesData sales, _) => sales.numeric,
          yValueMapper: (SalesData sales, _) => sales.sales1,
          width: lineWidth ?? 2,
          enableAnimation: false,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.Circle,
              borderWidth: 3,
              borderColor: Colors.red),
          dataLabelSettings: DataLabelSettings(
              visible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto)),
      LineSeries<SalesData, num>(
          enableToolTip: isTooltipVisible,
          dataSource: chartData,
          enableAnimation: false,
          width: lineWidth ?? 2,
          xValueMapper: (SalesData sales, _) => sales.numeric,
          yValueMapper: (SalesData sales, _) => sales.sales2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.Circle,
              borderWidth: 3,
              borderColor: Colors.black),
          dataLabelSettings: DataLabelSettings(
              isVisible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto))
    ];
  }*/

  String getSensorChildName(TabMenus menus) {
    switch (menus) {
      case TabMenus.ALL:
        return "";
      case TabMenus.DOORS:
        return "- Door";
      case TabMenus.TEMPERATURE:
        return "- Temperature";
      case TabMenus.HUMDITY:
        return "- Humidity";
      case TabMenus.CO2:
        return "- CO2";
      case TabMenus.RODENTS:
        return "- Rodent";
      case TabMenus.GAS:
        return "- Gas";
      case TabMenus.OXYGEN:
        return "- Oxygen";
      case TabMenus.SMOKE:
        return "- Smoke";
      case TabMenus.AIRFLOW:
        return "- Airflow";
    }
  }

  Color getColor(ChartSampleData chartsList, TabMenus menus) {
    switch (menus) {
      case TabMenus.ALL:
        return Colors.black;
      case TabMenus.DOORS:
        if (chartsList.y! > 0.8) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }
      case TabMenus.TEMPERATURE:
        return Colors.black;
      case TabMenus.HUMDITY:
        return chartsList.y! > AppConfig.HIGHER_HUMIDITY
            ? appDangerTextColor
            : appGreenColor;
      case TabMenus.CO2:
        return Colors.black;
      case TabMenus.RODENTS:
        if (chartsList.y! > 0.7) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }
      case TabMenus.GAS:
        return Colors.black;
      case TabMenus.OXYGEN:
        return Colors.black;
      case TabMenus.SMOKE:
        if (chartsList.y! > AppConfig.SMOKE_HIGH) {
          return appDangerTextColor;
        } else {
          return appGreenColor;
        }
      case TabMenus.AIRFLOW:
        return Colors.black;
    }
  }

  Widget getTrendWidget(List<ChartSampleData> chartsList, TabMenus menus,
      String name, BuildContext context) {
    // DateTime _now = DateTime.now();
    // List<DateTime> dateTimeList = List.generate(
    //   30,
    //   (index) => _now.subtract(
    //     Duration(minutes: index),
    //   ),
    // );
    if (menus == TabMenus.DOORS ||
        menus == TabMenus.RODENTS ||
        menus == TabMenus.SMOKE) {
      // return Container();

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$name ${getSensorChildName(menus)}",
            style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
          ),
          Row(
            children: List.generate(
              chartsList.length,
              (index) => Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: getHeight(6, context),
                      // width: getWidth(1, context),
                      decoration: BoxDecoration(
                        color: getBarColor(menus, chartsList[index]),
                        borderRadius: BorderRadius.circular(
                          getWidth(
                            1,
                            context,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: getWidth(
                          0.5,
                          context,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(6, context),
                      child: Center(
                        child: FittedBox(
                          child: Transform.rotate(
                            angle: -pi / 2,
                            child: Text(
                              AppConfig.getFormattedByFormat(
                                  chartsList[index].x!.toString(), "hh:mm a"),
                              style: FSMResources.FSMTextStyle(
                                context: context,
                                size: AppConfig.FONT_SIZE_H3,
                                color: appWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(),
        ],
      );
    } else {
      return SfCartesianChart(
        title: ChartTitle(text: "$name ${getSensorChildName(menus)}"),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        enableAxisAnimation: true,
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings:
              InteractiveTooltip(format: 'point.y ${getSensorUnit(menus)}'),
        ),
        primaryXAxis:
            DateTimeAxis(majorGridLines: const MajorGridLines(width: 0)),
        series: <LineSeries<ChartSampleData, DateTime>>[
          LineSeries<ChartSampleData, DateTime>(
            dataSource: chartsList,
            xValueMapper: (charts, i) => (charts.x as DateTime),
            yValueMapper: (charts, i) => charts.y,
          ),
        ],
      );
    }
  }

  String getSensorUnit(TabMenus menus) {
    switch (menus) {
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

  Color getBarColor(TabMenus menus, ChartSampleData chartsList) {
    switch (menus) {
      case TabMenus.ALL:
        return Colors.black;
      case TabMenus.DOORS:
        Color color = Colors.blue.withOpacity(0.2);
        if (chartsList.y! > AppConfig.DOOR_LEVEL) {
          color =
              Colors.red.withOpacity(double.parse(chartsList.y!.toString()));
        }
        return color;
      case TabMenus.TEMPERATURE:
        return Colors.black;
      case TabMenus.HUMDITY:
        return Colors.black;
      case TabMenus.CO2:
        return Colors.black;
      case TabMenus.RODENTS:
        Color color = Colors.blue.withOpacity(0.2);
        if (chartsList.y! > AppConfig.RODENT_LEVEL) {
          color =
              Colors.red.withOpacity(double.parse(chartsList.y!.toString()));
        }
        return color;
      case TabMenus.GAS:
        return Colors.black;
      case TabMenus.OXYGEN:
        return Colors.black;
      case TabMenus.SMOKE:
        Color color = Colors.blue.withOpacity(0.1);
        if (chartsList.y! >= 0.1) {
          color =
              Colors.blue.withOpacity(double.parse(chartsList.y!.toString()));
        }
        if (chartsList.y! > AppConfig.SMOKE_HIGH) {
          color =
              Colors.red.withOpacity(double.parse(chartsList.y!.toString()));
        }
        return color;
      case TabMenus.AIRFLOW:
        return Colors.black;
    }
  }
}
