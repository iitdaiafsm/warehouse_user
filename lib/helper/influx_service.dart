import 'dart:async';

import 'package:get/get.dart';
import 'package:influxdb_client/api.dart';
import 'package:warehouse_user/helper/models/godown_model.dart';
import 'package:warehouse_user/helper/models/warehouse_model.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

class InfluxService extends GetxService {
  late InfluxDBClient influxDBClient;
  late QueryService queryService;

  Future<InfluxService> init() async {
    influxDBClient = InfluxDBClient(
      url: "https://www.wfp-smartwarehouse.in:8086",
      token:
          "IQDuRsScn2SO48P_rmH3UQr1bcOlhuMhdsBrCvgXrrTVG814HAHEkqgtvbDPm6TRc5Zb6K3zHvS4hPEgGKGd-g==",
      org: "IITD-WFP",
      bucket: 'vibes',
    );
    queryService = influxDBClient.getQueryService();
    return this;
  }

  Future<void> generateQuery(
      WarehouseModel warehouseModel,
      List<GodownModel> godowns,
      Function(List<GodownModel>) updatedGodowns,
      Function(WarehouseModel) updatedWarehouse) async {
    var topic = "";
    List<SensorData> sensors = [];
    var warehouseGodown =
        godowns.where((element) => element.warehouseId == warehouseModel.id);

    for (var item in warehouseGodown) {
      sensors.addAll(item.centerSensor ?? []);
      sensors.addAll(item.leftInnerSensor ?? []);
      sensors.addAll(item.leftOuterSensor ?? []);
      sensors.addAll(item.bottomInnerSensor ?? []);
      sensors.addAll(item.bottomOuterSensor ?? []);
      sensors.addAll(item.rightInnerSensor ?? []);
      sensors.addAll(item.rightOuterSensor ?? []);
      sensors.addAll(item.topInnerSensor ?? []);
      sensors.addAll(item.topOuterSensor ?? []);
    }

    sensors = sensors.where((element) => element.name != "none").toList();
    if (sensors.isNotEmpty) {
      var namelist = sensors.map((e) => e.name);
      var topicJoin = namelist.join('" or r["topic"] == "');
      topic = 'r["topic"] == "$topicJoin"';
      var query = '''
  from(bucket: "swsn")
  |> range(start: -1h)
  |> filter(fn: (r) => r["_measurement"] == "${warehouseModel.measurement}")
  |> filter(fn: (r) => $topic)
  |> filter(fn: (r) => r["_field"] == "data_0" or r["_field"] == "data_1" or r["_field"] == "data_2" or r["_field"] == "data_3" or r["_field"] == "data_4" or r["_field"] == "data_5" or r["_field"] == "data_6" or r["_field"] == "data_7" or r["_field"] == "data_8" or r["_field"] == "data_9")
  |> filter(fn: (r) => r["host"] == "${warehouseModel.hostName}")
  |> yield(name: "last")
  ''';
      var sensorsValues = await getInfluxData(query, sensors);

      for (var sensorData in sensorsValues) {
        for (var item in warehouseGodown) {
          item = generateA(sensorData, item);
        }
      }
      for (var item in warehouseGodown) {
        warehouseModel = setAlerts(item, warehouseModel);
        WarehouseController warehouseController =
            Get.put(WarehouseController());
        warehouseController.setWarehouse(warehouseModel);
      }
      Timer.periodic(Duration(seconds: warehouseModel.refreshTime ?? 10),
          (timer) async {
        var sensorsValues = await getInfluxData(query, sensors);
        for (var sensorData in sensorsValues) {
          for (var item in warehouseGodown) {
            item = generateA(sensorData, item);
          }
        }
        for (var item in warehouseGodown) {
          // print(jsonEncode(item));
          warehouseModel = setAlerts(item, warehouseModel);
          WarehouseController warehouseController =
              Get.put(WarehouseController());
          warehouseController.setWarehouse(warehouseModel);
        }
        /*for (var item in warehouseGodown) {
              item.centerSensor
            .
          }*/
      });
    }
  }

  Future<List<SensorData>> getInfluxData(
      String query, List<SensorData> sensors) async {
    var recordStream = await queryService.query(query);
    var recordList = await recordStream.toList();
    List<SensorModel> sensorModelList = [];
    // print(jsonEncode(recordList));
    for (var element in recordList) {
      /*if (element["topic"] == "/devices/swsn/WFP-8560788/19") {
        print(jsonEncode(element));
      }*/
      var sensor =
          sensorModelList.where((value) => value.name == element['topic']);
      if (sensor.isEmpty) {
        SensorModel sensorModel = SensorModel(
            name: element["topic"],
            lastEditAt: "",
            position: 0,
            data: [
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
            ]);
        if (element["_field"] == "data_0" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![0] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_1" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![1] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_2" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![2] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_3" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![3] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_4" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![4] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_5" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![5] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_6" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![6] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_7" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![7] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        } else if (element["_field"] == "data_8" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensorModel.data![8] = double.parse("${element["_value"]}");
          sensorModel.lastEditAt = element["_time"];
        }
        sensorModelList.add(sensorModel);
      } else {
        // print("Found : ${element["topic"]}");
        if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_0" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![0] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_1" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![1] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_2" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![2] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_3" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![3] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_4" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![4] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_5" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![5] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_6" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![6] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_7" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![7] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        } else if (sensor.first.name == element["topic"] &&
            element["_field"] == "data_8" &&
            element["_value"] != null &&
            element["_value"] != AppMethods.ERROR_CODE) {
          sensor.first.data![8] = double.parse("${element["_value"]}");
          sensor.first.lastEditAt = element["_time"];
        }
      }
    }
    // print(jsonEncode(sensorModelList));
    for (var sensor in sensors) {
      var sensorModel =
          sensorModelList.where((element) => element.name == sensor.name);
      if (sensorModel.isNotEmpty) {
        if (sensorModel.first.data != null &&
            sensorModel.first.data!.isNotEmpty &&
            sensorModel.first.data!.length > 1) {
          if (sensorModel.first.data![1] == AppMethods.SENSOR_AMBIENT) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_AMBIENT;
            sensor.temperature = sensorModel.first.data![3];
            sensor.humidity = sensorModel.first.data![5];
            sensor.pressure = sensorModel.first.data![4];
            sensor.gas = sensorModel.first.data![6];
            sensor.altitude = sensorModel.first.data![7];
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_CO2) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_CO2;
            sensor.aqi = sensorModel.first.data![3];
            sensor.tvoc = sensorModel.first.data![4];
            sensor.co2 = sensorModel.first.data![5];
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_AIRFLOW) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_AIRFLOW;
            sensor.temperature = sensorModel.first.data![4];
            sensor.air = sensorModel.first.data![3];
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_RODENT) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_RODENT;
            sensor.rodentEnable = sensorModel.first.data![3] == 1;
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_OXYGEN) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_OXYGEN;
            sensor.oxygen = sensorModel.first.data![3];
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_DOOR) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_DOOR;
            sensor.doorOpen = sensorModel.first.data![3] == 1;
          } else if (sensorModel.first.data![1] == AppMethods.SENSOR_SMOKE) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_SMOKE;
            sensor.smokeEnable = sensorModel.first.data![3] == 1;
          } else if (sensorModel.first.data![1] ==
              AppMethods.SENSOR_PHOSPHENE) {
            sensor.time = sensorModel.first.lastEditAt;
            sensor.type = AppMethods.SENSOR_TYPE_PHOSPHENE;
            sensor.gas = sensorModel.first.data![3];
          }
        }
      }
    }
    return sensors;
  }

  GodownModel generateA(SensorData sensorData, GodownModel item) {
    if (item.topOuterSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.topOuterSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.topOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.topInnerSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.topInnerSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.topInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.rightOuterSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.rightOuterSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.rightOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.rightInnerSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.rightInnerSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.rightInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.bottomOuterSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.bottomOuterSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.bottomOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.bottomInnerSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.bottomInnerSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.bottomInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.leftOuterSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.leftOuterSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.leftOuterSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.leftInnerSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.leftInnerSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.leftInnerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    if (item.centerSensor
                ?.where((element) => element.name == sensorData.name) !=
            null &&
        (item.centerSensor
                ?.where((element) => element.name == sensorData.name))!
            .isNotEmpty) {
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .name ??= sensorData.name;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .position ??= sensorData.position;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .lastEditAt ??= sensorData.lastEditAt;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .temperature ??= sensorData.temperature;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .pressure ??= sensorData.pressure;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .humidity ??= sensorData.humidity;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .co2 ??= sensorData.co2;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .battery ??= sensorData.battery;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .time ??= sensorData.time;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .value ??= sensorData.value;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .air ??= sensorData.air;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .version ??= sensorData.version;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .gas ??= sensorData.gas;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .altitude ??= sensorData.altitude;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .aqi ??= sensorData.aqi;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .tvoc ??= sensorData.tvoc;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .doorOpen ??= sensorData.doorOpen;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .smokeEnable ??= sensorData.smokeEnable;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .oxygen ??= sensorData.oxygen;
      item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .rodentEnable ??= sensorData.rodentEnable;
      /*item.centerSensor
          ?.where((element) => element.name == sensorData.name)
          .first
          .type ??= sensorData.type;*/
    }
    //------------------
    // print(jsonEncode(item));
    // print("--------------------------");
    WarehouseController warehouseController = Get.put(WarehouseController());
    warehouseController.setGodowns(item);
    return item;
  }

  WarehouseModel setAlerts(GodownModel item, WarehouseModel warehouseModel) {
    // print(jsonEncode(warehouseModel));
    // print(jsonEncode(item));
    var _currentTime = DateTime.now();
    var time = DateTime(2022, 1, 1, _currentTime.hour, _currentTime.minute,
        _currentTime.second);
    // print(time);
    warehouseModel.haveAlert = false;
    if (item.topInnerSensor != null && item.topInnerSensor!.isNotEmpty) {
      warehouseModel = setDataAlert(item.topInnerSensor!, warehouseModel, time);
    }
    if (item.topOuterSensor != null && item.topOuterSensor!.isNotEmpty) {
      warehouseModel = setDataAlert(item.topOuterSensor!, warehouseModel, time);
    }
    if (item.rightInnerSensor != null && item.rightInnerSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.rightInnerSensor!, warehouseModel, time);
    }
    if (item.rightOuterSensor != null && item.rightOuterSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.rightOuterSensor!, warehouseModel, time);
    }
    if (item.bottomInnerSensor != null && item.bottomInnerSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.bottomInnerSensor!, warehouseModel, time);
    }
    if (item.bottomOuterSensor != null && item.bottomOuterSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.bottomOuterSensor!, warehouseModel, time);
    }
    if (item.leftInnerSensor != null && item.leftInnerSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.leftInnerSensor!, warehouseModel, time);
    }
    if (item.leftOuterSensor != null && item.leftOuterSensor!.isNotEmpty) {
      warehouseModel =
          setDataAlert(item.leftOuterSensor!, warehouseModel, time);
    }
    if (item.centerSensor != null && item.centerSensor!.isNotEmpty) {
      warehouseModel = setDataAlert(item.centerSensor!, warehouseModel, time);
    }
    // print(jsonEncode(warehouseModel));
    return warehouseModel;
  }

  WarehouseModel setDataAlert(
      List<SensorData> sensors, WarehouseModel warehouseModel, DateTime time) {
    for (var data in sensors) {
      if (data.type == AppMethods.SENSOR_TYPE_AMBIENT) {
        if (double.tryParse("${data.humidity}") != null &&
            double.tryParse("${warehouseModel.humidityHigher}") != null &&
            double.tryParse("${warehouseModel.humidityLower}") != null &&
            (double.parse("${data.humidity}") >=
                    double.parse("${warehouseModel.humidityHigher}") ||
                double.parse("${data.humidity}") <=
                    double.parse("${warehouseModel.humidityLower}"))) {
          // print("Alert : Humidity");
          warehouseModel.haveAlert = true;
          break;
        }
        if (double.tryParse("${data.co2}") != null &&
            double.tryParse("${warehouseModel.co2Higher}") != null &&
            double.tryParse("${warehouseModel.co2Lower}") != null &&
            (double.parse("${data.co2}") >=
                    double.parse("${warehouseModel.co2Higher}") ||
                double.parse("${data.co2}") <=
                    double.parse("${warehouseModel.co2Lower}"))) {
          // print("Alert : CO2");
          warehouseModel.haveAlert = true;
          break;
        }
        if (double.tryParse("${data.temperature}") != null &&
            double.tryParse("${warehouseModel.temperatureHigher}") != null &&
            double.tryParse("${warehouseModel.temperatureLower}") != null &&
            (double.parse("${data.temperature}") >=
                    double.parse("${warehouseModel.temperatureHigher}") ||
                double.parse("${data.temperature}") <=
                    double.parse("${warehouseModel.temperatureLower}"))) {
          // print("Alert : Temperature");
          warehouseModel.haveAlert = true;
          break;
        }
        if (double.tryParse("${data.pressure}") != null &&
            double.tryParse("${warehouseModel.pressureHigher}") != null &&
            double.tryParse("${warehouseModel.pressureLower}") != null &&
            (double.parse("${data.pressure}") >=
                    double.parse("${warehouseModel.pressureHigher}") ||
                double.parse("${data.pressure}") <=
                    double.parse("${warehouseModel.pressureLower}"))) {
          // print("Alert : Pressure");
          warehouseModel.haveAlert = true;
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_CO2) {
        if (double.tryParse("${data.co2}") != null &&
            double.tryParse("${warehouseModel.co2Higher}") != null &&
            double.tryParse("${warehouseModel.co2Lower}") != null &&
            (double.parse("${data.co2}") >=
                    double.parse("${warehouseModel.co2Higher}") ||
                double.parse("${data.co2}") <=
                    double.parse("${warehouseModel.co2Lower}"))) {
          // print("Alert : CO2");
          warehouseModel.haveAlert = true;
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_RODENT) {
        if (data.rodentEnable != null) {
          warehouseModel.haveAlert = data.rodentEnable;
          if (warehouseModel.haveAlert ?? false) {
            // print("Alert : Rodent");
          }
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_DOOR) {
        var haveNormal =
            time.isAfter(DateTime.parse(warehouseModel.doorTimeStart ?? "")) &&
                time.isBefore(DateTime.parse(warehouseModel.doorTimeEnd ?? ""));
        if (!haveNormal) {
          if (data.doorOpen != null) {
            warehouseModel.haveAlert = data.doorOpen;
            if (warehouseModel.haveAlert ?? false) {
              // print("Alert : Door");
            }
            break;
          }
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_AIRFLOW) {
        if (double.tryParse("${data.temperature}") != null &&
            double.tryParse("${warehouseModel.temperatureHigher}") != null &&
            double.tryParse("${warehouseModel.temperatureLower}") != null &&
            (double.parse("${data.temperature}") >=
                    double.parse("${warehouseModel.temperatureHigher}") ||
                double.parse("${data.temperature}") <=
                    double.parse("${warehouseModel.temperatureLower}"))) {
          // print("Alert : Temperature");
          warehouseModel.haveAlert = true;
          break;
        }
        if (double.tryParse("${data.air}") != null &&
            double.tryParse("${warehouseModel.airflowLevel}") != null &&
            (double.parse("${data.air}") >=
                double.parse("${warehouseModel.airflowLevel}"))) {
          // print("Alert : Air");
          warehouseModel.haveAlert = true;
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_OXYGEN) {
        if (double.tryParse("${data.oxygen}") != null &&
            double.tryParse("${warehouseModel.oxygenLevel}") != null &&
            double.parse("${data.oxygen}") <=
                double.parse("${warehouseModel.temperatureLower}")) {
          // print("Alert : Oxygen");
          warehouseModel.haveAlert = true;
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_SMOKE) {
        if (data.smokeEnable != null) {
          warehouseModel.haveAlert = data.smokeEnable;
          if (warehouseModel.haveAlert ?? false) {
            // print("Alert : Rodent");
          }
          break;
        }
      } else if (data.type == AppMethods.SENSOR_TYPE_PHOSPHENE) {
        if (double.tryParse("${data.gas}") != null &&
            double.tryParse("${warehouseModel.gasLower}") != null &&
            double.tryParse("${warehouseModel.gasHigher}") != null &&
            !(double.parse("${data.gas}") >=
                    double.parse("${warehouseModel.gasLower}") &&
                double.parse("${data.gas}") <=
                    double.parse("${warehouseModel.gasHigher}"))) {
          warehouseModel.haveAlert = true;
          break;
        }
      }
    }
    return warehouseModel;
  }
}
