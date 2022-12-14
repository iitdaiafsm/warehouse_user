import 'dart:async';

import 'package:get/get.dart';
import 'package:influxdb_client/api.dart';
import 'package:warehouse_user/old_warehouse/model/dummy_measurement_model.dart';
import 'package:warehouse_user/old_warehouse/warehouse_global_controller.dart';

import 'utils/app_config.dart';

class InfluxDataService extends GetxService {
  late InfluxDBClient influxDBClient;
  late QueryService queryService;
  late Timer _timer;
  late WarehouseGlobalController warehouseGlobalController;
  late DummyMeasurementDataModel warehouse1A;

  Future<InfluxDataService> init() async {
    warehouseGlobalController = Get.put(WarehouseGlobalController());
    warehouse1A = warehouseGlobalController.measurementList[0];
    influxDBClient = InfluxDBClient(
      url: AppConfig.INFLUXDB_URL,
      token: AppConfig.INFLUXDB_TOKEN,
      org: AppConfig.INFLUXDB_ORG,
      bucket: 'vibes',
    );
    queryService = influxDBClient.getQueryService();
    _getInfluxData1A();
    getInfluxData();
    return this;
  }

  @override
  void onClose() {
    _timer.cancel();
  }

  void getInfluxData() async {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      try {
        DateTime time = DateTime.parse("2022-05-18T13:51:13.634283435Z");
        // Get.log("Time : ${time.toString()}");

        DateTime currentTime = DateTime.now();
        // Get.log("UTC Time : ${currentTime.toUtc().toLocal()}");
      } catch (e) {
        Get.log("Error $e");
      }
      _getInfluxData1A();
    });
  }

  void _getInfluxData1A() async {
    var recordStream = await queryService.query('''
  from(bucket: "vibes")
  |> range(start: -1m)
  |> filter(fn: (r) => r["_measurement"] == "mqtt_consumer")
  |> filter(fn: (r) => r["topic"] == "/devices/vibes/WFP-3647704" or r["topic"] == "/devices/vibes/airflow-44179350484C" or r["topic"] == "/devices/vibes/airflow-4417935048BC" or r["topic"] == "/devices/vibes/airflow-4417935048D4" or r["topic"] == "/devices/vibes/ambient-441793504860" or r["topic"] == "/devices/vibes/ambient-4417935048B0" or r["topic"] == "/devices/vibes/ambient-4417935048B8" or r["topic"] == "/devices/vibes/ambient-4417935048D8" or r["topic"] == "/devices/vibes/ambient-4417935048EC" or r["topic"] == "/devices/vibes/ambient-441793504908" or r["topic"] == "/devices/vibes/door-E0E2E6A18298" or r["topic"] == "/devices/vibes/door-E0E2E6A182FC" or r["topic"] == "/devices/vibes/gas-4417935048D0" or r["topic"] == "/devices/vibes/motion-441793504888" or r["topic"] == "/devices/vibes/motion-441793504894" or r["topic"] == "/devices/vibes/motion-44179350489C" or r["topic"] == "/devices/vibes/motion-4417935048AC" or r["topic"] == "/devices/vibes/motion-4417935048C4" or r["topic"] == "/devices/vibes/motion-4417935048F8" or r["topic"] == "/devices/vibes/motion-4417935052F0" or r["topic"] == "/devices/vibes/motion-E0E2E6A18300" or r["topic"] == "/devices/vibes/oxygen-441793504858" or r["topic"] == "/devices/vibes/smoke-E0E2E6A18224" or r["topic"] == "/devices/vibes/smoke-E0E2E6A18260")
  |> filter(fn: (r) => r["_field"] == "temperature" or r["_field"] == "bat_soc" or r["_field"] == "eco2" or r["_field"] == "humidity" or r["_field"] == "value" or r["_field"] == "airflow" or r["_field"] == "gas" or r["_field"] == "oxygen")
  |> filter(fn: (r) => r["host"] == "wfp-smartwarehouse.in")
  |> yield(name: "last")
  ''');

    var recordList = await recordStream.toList();
    // Get.log(recordList.length.toString());
    for (var element in recordList) {
      // Get.log("Data --> $element");
      if (element['topic'] == '/devices/vibes/ambient-4417935048D8') {
        warehouse1A.measurement!.leftMeasurement![0].name =
            "ambient-4417935048D8";
        // warehouse1A.measurement!.leftMeasurement![0].time = element['_time'];
        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.leftMeasurement![0].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.leftMeasurement![0].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.leftMeasurement![0].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.leftMeasurement![0].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.leftMeasurement![0].temperature != 0 ||
            warehouse1A.measurement!.leftMeasurement![0].co2 != 0 ||
            warehouse1A.measurement!.leftMeasurement![0].humidity != 0) {
          warehouse1A.measurement!.leftMeasurement![0].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/ambient-441793504908') {
        warehouse1A.measurement!.leftMeasurement![1].name =
            "ambient-441793504908";
        // warehouse1A.measurement!.leftMeasurement![1].time = element['_time'];
        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.leftMeasurement![1].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.leftMeasurement![1].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.leftMeasurement![1].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.leftMeasurement![1].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.leftMeasurement![1].temperature != 0 ||
            warehouse1A.measurement!.leftMeasurement![1].co2 != 0 ||
            warehouse1A.measurement!.leftMeasurement![1].humidity != 0) {
          warehouse1A.measurement!.leftMeasurement![1].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/ambient-441793504860') {
        warehouse1A.measurement!.leftMeasurement![2].name =
            "ambient-441793504860";

        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.leftMeasurement![2].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.leftMeasurement![2].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.leftMeasurement![2].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.leftMeasurement![2].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.leftMeasurement![2].temperature != 0 ||
            warehouse1A.measurement!.leftMeasurement![2].co2 != 0 ||
            warehouse1A.measurement!.leftMeasurement![2].humidity != 0) {
          warehouse1A.measurement!.leftMeasurement![2].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/ambient-4417935048B8') {
        warehouse1A.measurement!.rightMeasurement![0].name =
            "ambient-4417935048B8";
        // warehouse1A.measurement!.rightMeasurement![0].time = element['_time'];
        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.rightMeasurement![0].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.rightMeasurement![0].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.rightMeasurement![0].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.rightMeasurement![0].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.rightMeasurement![0].temperature != 0 ||
            warehouse1A.measurement!.rightMeasurement![0].co2 != 0 ||
            warehouse1A.measurement!.rightMeasurement![0].humidity != 0) {
          warehouse1A.measurement!.rightMeasurement![0].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/ambient-4417935048EC') {
        warehouse1A.measurement!.rightMeasurement![1].name =
            "ambient-4417935048EC";
        // warehouse1A.measurement!.rightMeasurement![1].time = element['_time'];
        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.rightMeasurement![1].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.rightMeasurement![1].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.rightMeasurement![1].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.rightMeasurement![1].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.rightMeasurement![1].temperature != 0 ||
            warehouse1A.measurement!.rightMeasurement![1].co2 != 0 ||
            warehouse1A.measurement!.rightMeasurement![1].humidity != 0) {
          warehouse1A.measurement!.rightMeasurement![1].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/ambient-4417935048B0') {
        warehouse1A.measurement!.rightMeasurement![2].name =
            "ambient-4417935048B0";
        // warehouse1A.measurement!.rightMeasurement![2].time = element['_time'];
        if (element['_field'] == 'temperature') {
          warehouse1A.measurement!.rightMeasurement![2].temperature =
              element['_value'];
        }
        if (element['_field'] == 'humidity') {
          warehouse1A.measurement!.rightMeasurement![2].humidity =
              element['_value'];
        }
        if (element['_field'] == 'eco2') {
          warehouse1A.measurement!.rightMeasurement![2].co2 = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.measurement!.rightMeasurement![2].battery =
              element['_value'];
        }
        if (warehouse1A.measurement!.rightMeasurement![2].temperature != 0 ||
            warehouse1A.measurement!.rightMeasurement![2].co2 != 0 ||
            warehouse1A.measurement!.rightMeasurement![2].humidity != 0) {
          warehouse1A.measurement!.rightMeasurement![2].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-4417935048F8') {
        warehouse1A.leftMotionDetectorValues![0].name = "motion-4417935048F8";
        warehouse1A.leftMotionDetectorValues![0].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.leftMotionDetectorValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.leftMotionDetectorValues![0].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-4417935052F0') {
        warehouse1A.leftMotionDetectorValues![1].name = "motion-4417935052F0";
        warehouse1A.leftMotionDetectorValues![1].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.leftMotionDetectorValues![1].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.leftMotionDetectorValues![1].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-44179350489C') {
        warehouse1A.topMotionDetectorValues![0].name = "motion-44179350489C";
        warehouse1A.topMotionDetectorValues![0].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.topMotionDetectorValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.topMotionDetectorValues![0].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-441793504888') {
        warehouse1A.topMotionDetectorValues![1].name = "motion-441793504888";
        warehouse1A.topMotionDetectorValues![1].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.topMotionDetectorValues![1].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.topMotionDetectorValues![1].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-4417935048AC') {
        warehouse1A.rightMotionDetectorValues![0].name = "motion-4417935048AC";
        warehouse1A.rightMotionDetectorValues![0].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.rightMotionDetectorValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.rightMotionDetectorValues![0].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-441793504894') {
        warehouse1A.rightMotionDetectorValues![1].name = "motion-441793504894";
        warehouse1A.rightMotionDetectorValues![1].time = element['_time'];
        if (element['_field'] == 'value') {
          // Get.log("Data for motion-441793504894 $element");
          warehouse1A.rightMotionDetectorValues![1].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.rightMotionDetectorValues![1].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-E0E2E6A18300') {
        warehouse1A.bottomMotionDetectorValues![0].name = "motion-E0E2E6A18300";
        warehouse1A.bottomMotionDetectorValues![0].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.bottomMotionDetectorValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.bottomMotionDetectorValues![0].battery =
              element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/motion-4417935048C4') {
        warehouse1A.bottomMotionDetectorValues![1].name = "motion-4417935048C4";
        warehouse1A.bottomMotionDetectorValues![1].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.bottomMotionDetectorValues![1].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.bottomMotionDetectorValues![1].battery =
              element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/smoke-E0E2E6A18260') {
        warehouse1A.smokeValues![0].name = "smoke-E0E2E6A18260";
        warehouse1A.smokeValues![0].time = element['_time'];
        if (element['_field'] == 'value') {
          warehouse1A.smokeValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.smokeValues![0].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/oxygen-441793504858') {
        warehouse1A.oxygenValues![0].name = "oxygen-441793504858";

        if (element['_field'] == 'oxygen') {
          warehouse1A.oxygenValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.oxygenValues![0].battery = element['_value'];
        }
        if (warehouse1A.oxygenValues![0].value != 0) {
          warehouse1A.oxygenValues![0].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/gas-4417935048D0') {
        warehouse1A.gasValues![0].name = "gas-4417935048D0";

        if (element['_field'] == 'gas') {
          warehouse1A.gasValues![0].value = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.gasValues![0].battery = element['_value'];
        }
        warehouse1A.gasValues![0].time = element['_time'];
      }
      if (element['topic'] == '/devices/vibes/airflow-4417935048D4') {
        warehouse1A.airFlows![0].name = "airflow-4417935048D4";

        if (element['_field'] == 'airflow') {
          // Get.log("Airflow Data : airflow-4417935048D4 ${element['_value']}");
          warehouse1A.airFlows![0].air = element['_value'];
        }
        if (element['_field'] == 'temperature') {
          warehouse1A.airFlows![0].temperature = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.airFlows![0].battery = element['_value'];
        }
        if (warehouse1A.airFlows![0].temperature != 0 ||
            warehouse1A.airFlows![0].air != 0) {
          warehouse1A.airFlows![0].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/airflow-4417935048BC') {
        warehouse1A.airFlows![1].name = "airflow-4417935048BC";
        // warehouse1A.airFlows![1].time = element['_time'];
        if (element['_field'] == 'airflow') {
          // Get.log("Airflow Data : airflow-4417935048BC ${element['_value']}");
          warehouse1A.airFlows![1].air = element['_value'];
        }
        if (element['_field'] == 'temperature') {
          warehouse1A.airFlows![1].temperature = element['_value'];
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.airFlows![1].battery = element['_value'];
        }
        if (warehouse1A.airFlows![1].temperature != 0 ||
            warehouse1A.airFlows![1].air != 0) {
          warehouse1A.airFlows![1].time = element['_time'];
        }
      }
      if (element['topic'] == '/devices/vibes/door-E0E2E6A18298') {
        if (element['_field'] == 'value') {
          // Get.log("Door left 1 : ${element['_value']}");
          warehouse1A.doorsData!.leftDoors![1].isRunning =
              element['_value'] > 0.8;
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.doorsData!.leftDoors![1].battery = element['_value'];
        }
      }
      if (element['topic'] == '/devices/vibes/door-E0E2E6A182FC') {
        if (element['_field'] == 'value') {
          // Get.log("Door left 0 : ${element['_value']}");
          warehouse1A.doorsData!.leftDoors![0].isRunning =
              element['_value'] > 0.8;
        }
        if (element['_field'] == 'bat_soc') {
          warehouse1A.doorsData!.leftDoors![0].battery = element['_value'];
        }
      }
      /*if(element['topic']=='/devices/vibes/ambient-4417935048B0'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.topMeasurement![0].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.topMeasurement![0].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.topMeasurement![0].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.topMeasurement![0].battery = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/ambient-4417935048B0'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.topMeasurement![1].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.topMeasurement![1].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.topMeasurement![1].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.topMeasurement![1].battery = element['_value'];
        }

      }
      if(element['topic']=='/devices/vibes/ambient-4417935048B8'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.bottomMeasurement![0].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.bottomMeasurement![0].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.bottomMeasurement![0].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.bottomMeasurement![0].battery = element['_value'];
        }

      }
      if(element['topic']=='/devices/vibes/ambient-4417935048D8'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.bottomMeasurement![1].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.bottomMeasurement![1].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.bottomMeasurement![1].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.bottomMeasurement![1].battery = element['_value'];
        }

      }
      if(element['topic']=='/devices/vibes/ambient-4417935048EC'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.leftMeasurement![0].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.leftMeasurement![0].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.leftMeasurement![0].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.leftMeasurement![0].battery = element['_value'];
        }

      }
      if(element['topic']=='/devices/vibes/ambient-441793504908'){
        if(element['_field']=='temperature'){
          warehouse1A.measurement!.rightMeasurement![0].temperature = element['_value'];
        }
        if(element['_field']=='humidity'){
          warehouse1A.measurement!.rightMeasurement![0].humidity = element['_value'];
        }
        if(element['_field']=='eco2'){
          warehouse1A.measurement!.rightMeasurement![0].co2 = element['_value'];
        }
        if(element['_field']=='bat_soc'){
          warehouse1A.measurement!.rightMeasurement![0].battery = element['_value'];
        }

      }
      if(element['topic']=='/devices/vibes/door-E0E2E6A18298'){
        if(element['_field']=='value'){
          Get.log("Door left 0 : ${element['_value']}");
          warehouse1A.doorsData!.leftDoors![0].isRunning = element['_value']==1.0;
        }
      }
      if(element['topic']=='/devices/vibes/door-E0E2E6A182FC'){
        if(element['_field']=='value'){
          warehouse1A.doorsData!.leftDoors![1].isRunning = element['_value']==1.0;
        }
      }
      if(element['topic']=='/devices/vibes/motion-441793504888'){
        if(element['_field']=='value'){
          warehouse1A.topMotionDetectorValues![0].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-441793504894'){
        if(element['_field']=='value'){
          warehouse1A.topMotionDetectorValues![1].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-44179350489C'){
        if(element['_field']=='value'){
          warehouse1A.topMotionDetectorValues![2].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-4417935048AC'){
        if(element['_field']=='value'){
          warehouse1A.topMotionDetectorValues![3].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-4417935048C4'){
        if(element['_field']=='value'){
          warehouse1A.leftMotionDetectorValues![0].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-4417935048F8'){
        if(element['_field']=='value'){
          warehouse1A.leftMotionDetectorValues![1].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-4417935052F0'){
        if(element['_field']=='value'){
          warehouse1A.leftMotionDetectorValues![2].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/motion-E0E2E6A18300'){
        if(element['_field']=='value'){
          warehouse1A.leftMotionDetectorValues![3].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/smoke-E0E2E6A18224'){
        if(element['_field']=='value'){
          warehouse1A.smokeValues![0].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/smoke-E0E2E6A18260'){
        if(element['_field']=='value'){
          warehouse1A.smokeValues![1].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/gas-4417935048D0'){
        if(element['_field']=='gas'){
          warehouse1A.gasValues![0].value = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/airflow-44179350484C'){
        if(element['_field']=='airflow'){
          warehouse1A.airFlows![0].air = element['_value'];
        }
        if(element['_field']=='temperature'){
          warehouse1A.airFlows![0].temperature = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/airflow-4417935048BC'){
        if(element['_field']=='airflow'){
          warehouse1A.airFlows![1].air = element['_value'];
        }
        if(element['_field']=='temperature'){
          warehouse1A.airFlows![1].temperature = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/airflow-4417935048D4'){
        if(element['_field']=='airflow'){
          warehouse1A.airFlows![2].air = element['_value'];
        }
        if(element['_field']=='temperature'){
          warehouse1A.airFlows![2].temperature = element['_value'];
        }
      }
      if(element['topic']=='/devices/vibes/oxygen-441793504858'){
        if(element['_field']=='oxygen'){
          warehouse1A.oxygenValues![0].value = element['_value'];
        }
      }*/
      warehouseGlobalController.setTopLevelAlerts(warehouse1A);
      warehouseGlobalController.update();
    }
  }
}
