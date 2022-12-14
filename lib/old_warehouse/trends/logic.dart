import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influxdb_client/api.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warehouse_user/old_warehouse/trends/model.dart';
import 'package:warehouse_user/old_warehouse/utils/chart_sample_data.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/warehouse/logic.dart';

import '../utils/app_config.dart';
import '../utils/app_size.dart';
import '../utils_widgets/tooltip/src/just_the_tooltip.dart';
import '../utils_widgets/tooltip/src/models/just_the_controller.dart';

class TrendsLogic extends GetxController {
  List<CustomMeasurement> trendsList = [
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-4417935048D8", ""),
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-441793504908", ""),
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-441793504860", ""),
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-4417935048B8", ""),
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-4417935048EC", ""),
    CustomMeasurement(0, TabMenus.ALL, "", "ambient-4417935048B0", ""),
    CustomMeasurement(0, TabMenus.DOORS, "", "door-E0E2E6A18298", ""),
    CustomMeasurement(0, TabMenus.DOORS, "", "door-E0E2E6A182FC", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-4417935048F8", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-4417935052F0", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-44179350489C", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-441793504888", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-E0E2E6A18300", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-4417935048C4", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-4417935048AC", ""),
    CustomMeasurement(0, TabMenus.RODENTS, "", "motion-441793504894", ""),
    CustomMeasurement(0, TabMenus.SMOKE, "", "smoke-E0E2E6A18260", ""),
    CustomMeasurement(0, TabMenus.AIRFLOW, "", "airflow-4417935048D4", ""),
    CustomMeasurement(0, TabMenus.AIRFLOW, "", "airflow-4417935048BC", ""),
    CustomMeasurement(0, TabMenus.GAS, "", "gas-4417935048D0", ""),
    CustomMeasurement(0, TabMenus.OXYGEN, "", "oxygen-441793504858", ""),
  ];
  TrendDataModel trendDataModel = TrendDataModel();
  List<TrendsList> widgetsItem = [];
  late InfluxDBClient influxDBClient;
  late QueryService queryService;
  List<DropDownPair> dropDownList = [
    DropDownPair("5 Minutes", "-5m"),
    DropDownPair("15 Minutes", "-15m"),
    DropDownPair("30 Minutes", "-30m"),
    DropDownPair("1 Hour", "-1h"),
    DropDownPair("3 Hours", "-3h"),
    // DropDownPair("6 Hours", "-6h"),
    // DropDownPair("12 Hours", "-12h"),
    // DropDownPair("24 Hours", "-24h"),
  ];
  DropDownPair selectedDropDownPair = DropDownPair("5 Minutes", "-5m");

  @override
  void onInit() {
    influxDBClient = InfluxDBClient(
      url: AppConfig.INFLUXDB_URL,
      token: AppConfig.INFLUXDB_TOKEN,
      org: AppConfig.INFLUXDB_ORG,
      bucket: 'vibes',
    );
    //
    queryService = influxDBClient.getQueryService();
    // getData();
    super.onInit();
  }

  void getData(BuildContext context) async {
    List<Data> dataList = [];
    for (var item in trendsList) {
      var allFluxData =
          await getAllHistoryOfSensor(item.name, getFieldList(item.type));

      for (var fluxData in allFluxData) {
        String field = "";
        Get.log("Length : ${fluxData.length}");

        for (var type in getFieldList(item.type)) {
          List<ChartSampleData> chartList = [];

          var fluxList = fluxData.where((element) => element['_field'] == type);
          if (fluxList.isNotEmpty) {
            for (var flux in fluxList) {
              chartList.add(
                ChartSampleData(
                  y: flux['_value'],
                  x: DateTime.parse(flux['_time']).toLocal(),
                ),
              );
            }
            dataList.add(
              Data(
                sensorName: item.name,
                chartTitle: type,
                chartSampleData: chartList,
                low: AppConfig.getLowParameters(type),
                high: AppConfig.getHighParameters(type),
              ),
            );
          }
        }
      }
    }
    dataList.sort((a, b) {
      return a.chartTitle!.compareTo(b.chartTitle!);
    });
    Get.log("Data is : ${jsonEncode(dataList)}");
    for (var dataItem in dataList) {
      widgetsItem.add(getTrendWidget(dataItem, context));
      update();
    }
  }

  Future<List<List<FluxRecord>>> getAllHistoryOfSensor(
      String name, List<String> fields) async {
    List<List<FluxRecord>> _fluxRecords = [];

    for (var item in fields) {
      var recordStream = await queryService.query('''
  from(bucket: "vibes")
  |> range(start: ${selectedDropDownPair.key})
  |> filter(fn: (r) => r["_measurement"] == "mqtt_consumer")
  |> filter(fn: (r) => r["topic"] == "/devices/vibes/$name")
  |> filter(fn: (r) => r["_field"] == "$item")
  |> filter(fn: (r) => r["host"] == "wfp-smartwarehouse.in")
  |> yield(name: "last")
  ''');

      var recordList = await recordStream.toList();
      _fluxRecords.add(recordList);
    }
    return _fluxRecords;
  }

  TrendsList getTrendWidget(Data data, BuildContext context) {
    double minimumValue = 0;
    double maximumValue = 0;
    List<ChartSampleData> tempList = [];
    for (var dataItem in data.chartSampleData!) {
      tempList.add(dataItem);
    }
    tempList.sort((a, b) {
      return a.y!.compareTo(b.y!);
    });
    maximumValue = double.parse(
        "${(tempList.reduce((value, element) => value.y! > element.y! ? value : element)).y!}");
    minimumValue = double.parse(
        "${(tempList.reduce((value, element) => value.y! < element.y! ? value : element)).y!}");

    Get.log("Minimum : ${data.sensorName} $minimumValue");
    Get.log("Maximum : ${data.sensorName} $maximumValue");

    minimumValue = minimumValue != 0
        ? minimumValue < 0
            ? minimumValue + (minimumValue * 0.2)
            : minimumValue - (minimumValue * 0.2)
        : -0.5;
    maximumValue = maximumValue != 0
        ? maximumValue > 0
            ? maximumValue + (maximumValue * 0.2)
            : maximumValue - (maximumValue * 0.2)
        : 0.5;
    Get.log("Minimum : ${data.sensorName} $minimumValue");
    Get.log("Maximum : ${data.sensorName} $maximumValue");
    Get.log("-------------");
    if (data.sensorName!.contains('motion') ||
        data.sensorName!.contains('door') ||
        data.sensorName!.contains('smoke')) {
      return TrendsList(
          SizedBox(
            height: height(context) > 800
                ? getHeight(5, context)
                : getHeight(5, context),
            child: Column(
              children: [
                Text(
                  getTitleName(
                    data.chartTitle!,
                    data.sensorName!,
                  ),
                  style: TextStyle(
                      fontSize: getWidth(1.3, context),
                      fontFamily: 'Segoe UI',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: getHeight(2, context),
                  child: Row(
                    children: List.generate(
                      data.chartSampleData!.length,
                      (index) {
                        final JustTheController controller =
                            JustTheController();
                        return Expanded(
                          child: MouseRegion(
                            onHover: (e) {
                              controller.attach(
                                  showTooltip: (
                                      {autoClose = true,
                                      immediately = false}) async {},
                                  hideTooltip: ({immediately = true}) async {});
                              controller.showTooltip(
                                  autoClose: true, immediately: false);
                            },
                            child: GestureDetector(
                              onLongPress: () {
                                controller.attach(
                                    showTooltip: (
                                        {autoClose = true,
                                        immediately = false}) async {},
                                    hideTooltip: (
                                        {immediately = true}) async {});
                                controller.showTooltip(
                                    autoClose: true, immediately: false);
                              },
                              child: JustTheTooltip(
                                controller: controller,
                                content: AppConfig.getHoverInnerWidget(
                                    "",
                                    [
                                      KeyValueClass(
                                        key: "Date",
                                        value: AppConfig.getFormattedOnlyDate(
                                          data.chartSampleData![index].x
                                              .toString(),
                                        ),
                                      ),
                                      KeyValueClass(
                                        key: "Time",
                                        value: AppConfig.getFormattedOnlyTime(
                                          data.chartSampleData![index].x
                                              .toString(),
                                        ),
                                      ),
                                      KeyValueClass(
                                        key: "Value",
                                        value:
                                            "${data.chartSampleData![index].y}",
                                      ),
                                    ],
                                    context),
                                child: Container(
                                  width: getWidth(3, context),
                                  decoration: BoxDecoration(
                                    color: getBarColor(
                                        data.chartSampleData![index],
                                        data.sensorName!),
                                    /*borderRadius: BorderRadius.circular(
                                  getWidth(
                                    1,
                                    context,
                                  ),
                                ),*/
                                  ),
                                  /*margin: EdgeInsets.symmetric(
                                horizontal: getWidth(
                                  0.05,
                                  context,
                                ),
                              ),*/
                                  /*child: FittedBox(
                                child: Transform.rotate(
                                  angle: -pi / 2,
                                  child: Text(
                                    " ${AppConfig.getFormattedByFormat(data.chartSampleData![index].x!.toString(), "hh:mm a")} ",
                                    style: FSMResources.FSMTextStyle(
                                      context: context,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ),*/
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          true);
    } else {
      return TrendsList(
          SizedBox(
            height: height(context) > 800
                ? getHeight(20, context)
                : getHeight(40, context),
            child: SfCartesianChart(
              title: ChartTitle(
                text: getTitleName(data.chartTitle!, data.sensorName!),
                textStyle: FSMResources.FSMTextStyle(
                  context: context,
                  size: AppConfig.FONT_SIZE_H7,
                ),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryYAxis: NumericAxis(
                  minimum: minimumValue,
                  maximum: maximumValue,
                  labelFormat: r'{value}',
                  axisLine: const AxisLine(width: 0),
                  axisLabelFormatter: (value) {
                    return ChartAxisLabel(
                      value.text,
                      FSMResources.FSMTextStyle(
                        context: context,
                        color: data.high != null && data.low != null
                            ? double.parse(value.text) >= data.high! ||
                                    double.parse(value.text) <= data.low!
                                ? Colors.red
                                : Colors.green
                            : Colors.grey,
                        type: TextStyleType.regular,
                        size: AppConfig.FONT_SIZE_H9,
                      ),
                    );
                  }),
              enableAxisAnimation: true,
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipSettings: InteractiveTooltip(
                    format: 'point.y ${getUnit(data.chartTitle!)}'),
              ),
              primaryXAxis: DateTimeAxis(
                  minimum: data.chartSampleData!.first.x,
                  majorGridLines: const MajorGridLines(width: 0),
                  // labelFormat: r'{value}',
                  axisLabelFormatter: (value) {
                    return ChartAxisLabel(
                      DateFormat("hh:mm").format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse("${value.value}"))),
                      // AppConfig.getFormattedByFormat(
                      //     value.value.toString(), "hh:mm"),
                      FSMResources.FSMTextStyle(
                        context: context,
                        color: Colors.grey,
                        type: TextStyleType.regular,
                        size: AppConfig.FONT_SIZE_H9,
                      ),
                    );
                  }),
              series: [
                LineSeries<ChartSampleData, DateTime>(
                  emptyPointSettings:
                      EmptyPointSettings(mode: EmptyPointMode.zero),
                  dataSource: data.chartSampleData!,
                  xValueMapper: (charts, i) => (charts.x as DateTime),
                  yValueMapper: (charts, i) => charts.y,
                  width: getWidth(0.2, context),
                  legendItemText: getTitleName(
                    data.chartTitle!,
                    data.sensorName!,
                  ).substring(
                    0,
                    getTitleName(
                      data.chartTitle!,
                      data.sensorName!,
                    ).indexOf(" "),
                  ),
                )
              ],
            ),
          ),
          false);
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

  Color getBarColor(ChartSampleData data, String sensorName) {
    if (sensorName.contains("motion")) {
      if (data.y! > AppConfig.RODENT_LEVEL) {
        return Colors.red.withOpacity(double.parse("${data.y!}"));
      } else {
        return Colors.green
            .withOpacity(double.parse("${data.y == 0.0 ? '0.1' : data.y!}"));
      }
    }
    if (sensorName.contains("door")) {
      if (data.y! > AppConfig.DOOR_LEVEL) {
        return Colors.green.withOpacity(double.parse("${data.y!}") <= 1.0
            ? double.parse("${data.y!}")
            : 1.0);
      } else {
        return Colors.red
            .withOpacity(double.parse("${data.y == 0.0 ? '0.1' : data.y!}"));
      }
    }
    if (sensorName.contains("smoke")) {
      if (data.y! > AppConfig.SMOKE_HIGH) {
        return Colors.red.withOpacity(double.parse("${data.y!}"));
      } else {
        return Colors.green
            .withOpacity(double.parse("${data.y == 0.0 ? '0.1' : data.y!}"));
      }
    }

    return Colors.red;
  }

  getSensorChildName(TabMenus menus) {}

  List<String> getFieldList(TabMenus type) {
    switch (type) {
      case TabMenus.ALL:
        return ["temperature", "eco2", "humidity"];
      case TabMenus.DOORS:
        return ["value"];
      case TabMenus.TEMPERATURE:
        return [];
      case TabMenus.HUMDITY:
        return [];
      case TabMenus.CO2:
        return [];
      case TabMenus.RODENTS:
        return ["value"];
      case TabMenus.GAS:
        return ["gas"];
      case TabMenus.OXYGEN:
        return ["oxygen"];
      case TabMenus.SMOKE:
        return ["value"];
      case TabMenus.AIRFLOW:
        return ["airflow"];
    }
  }

  String getTitleName(String s, String sensorName) {
    switch (s) {
      case "bat_soc":
        return "Battery ${sensorName.substring(0, sensorName.indexOf("-"))}-${sensorName.substring(sensorName.length - 4, sensorName.length)}";
      case "eco2":
        return "CO2 ${sensorName.substring(0, sensorName.indexOf("-"))}-${sensorName.substring(sensorName.length - 4, sensorName.length)}";
      case "value":
        return sensorName;
      default:
        return "${s.capitalize} ${sensorName.substring(0, sensorName.indexOf("-"))}-${sensorName.substring(sensorName.length - 4, sensorName.length)}";
    }
  }

  void updateDropDownItem(DropDownPair? value, BuildContext context) {
    selectedDropDownPair = value!;
    widgetsItem = [];
    update();
    getData(context);
  }

  String getUnit(String type) {
    switch (type) {
      case "temperature":
        return "\u00B0C";
      case "eco2":
        return "ppm";
      case "humidity":
        return "%";
      case "bat_soc":
        return "%";
      case "value":
        return "";
      case "gas":
        return "ppm";
      case "oxygen":
        return "%";
      case "airflow":
        return "L/min";
      default:
        return "";
    }
  }
}

class DropDownPair {
  String title;
  String key;

  DropDownPair(this.title, this.key);

  @override
  bool operator ==(dynamic other) =>
      other != null && other is DropDownPair && title == other.title;
}

class TrendsList {
  Widget widget;
  bool isSmall;

  TrendsList(this.widget, this.isSmall);
}
