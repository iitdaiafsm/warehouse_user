import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warehouse_user/helper/models/warehouse_model.dart';
import 'package:warehouse_user/helper/shared_files.dart';

import 'models/godown_model.dart';

class FirebaseHelper {
  late FirebaseFirestore _firebaseFirestore;
  final String _WAREHOUSE_COLLECTION = "Warehouse";
  final String _GODOWN_COLLECTION = "Godown";

  FirebaseHelper() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  void addDummyData() async {
    GodownModel godownModel = GodownModel(
        id: "${Random().nextInt(100)}",
        warehouseId: "68",
        createdAt: "${DateTime.now()}",
        lastEditAt: "${DateTime.now()}",
        name: "8A",
        column: 3,
        row: 4,
        isDeleted: false,
        leftOuterSensor: [
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
        ],
        leftInnerSensor: [
          SensorData(name: "none", lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
          SensorData(name: "none", lastEditAt: "${DateTime.now()}"),
        ],
        topInnerSensor: [
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
        ],
        topOuterSensor: [
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
              name: "/devices/swsn/WFP-788992/6",
              type: AppMethods.SENSOR_TYPE_DOOR,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/6",
              type: AppMethods.SENSOR_TYPE_DOOR,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
        ],
        bottomInnerSensor: [
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
        ],
        rightOuterSensor: [
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
        ],
        rightInnerSensor: [
          SensorData(name: "none", lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/2",
              type: AppMethods.SENSOR_TYPE_AMBIENT,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/1",
              type: AppMethods.SENSOR_TYPE_CO2,
              lastEditAt: "${DateTime.now()}"),
          SensorData(name: "none", lastEditAt: "${DateTime.now()}"),
        ],
        centerSensor: [
          SensorData(
              name: "/devices/swsn/WFP-788992/3",
              type: AppMethods.SENSOR_TYPE_AIRFLOW,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/5",
              type: AppMethods.SENSOR_TYPE_OXYGEN,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/3",
              type: AppMethods.SENSOR_TYPE_AIRFLOW,
              lastEditAt: "${DateTime.now()}"),
        ],
        bottomOuterSensor: [
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
          SensorData(
              name: "/devices/swsn/WFP-788992/6",
              type: AppMethods.SENSOR_TYPE_DOOR,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
              name: "/devices/swsn/WFP-788992/6",
              type: AppMethods.SENSOR_TYPE_DOOR,
              lastEditAt: "${DateTime.now()}"),
          SensorData(
            name: "/devices/swsn/WFP-788992/4",
            lastEditAt: "${DateTime.now()}",
            type: AppMethods.SENSOR_TYPE_RODENT,
          ),
        ]);
    _firebaseFirestore.collection(_GODOWN_COLLECTION).add(godownModel.toJson());
  }

  /*void addDummyData() async {
    //EID GAH, AHLE HADEES, Sikandrabad, Uttar Pradesh 203205
    WarehouseModel warehouseModel = WarehouseModel(
      id: "${Random().nextInt(100)}",
      name: "Damodar Cold Storage & Ice Factory",
      state: "Uttar Pradesh",
      city: "Sikandrabad",
      latitude: 28.4839991,
      longitude: 77.4906282,
      hostName: "wfp-smartwarehouse.in",
      measurement: "mqtt_consumer",
      refreshTime: 10,
      humidityLower: 20,
      humidityHigher: 70,
      temperatureLower: 27,
      temperatureHigher: 39,
      co2Lower: 500,
      co2Higher: 1500,
      smokeLevel: 0.1,
      airflowLevel: 1,
      gasLower: 0,
      gasHigher: 10,
      batteryLevel: 25,
      oxygenLevel: 20.75,
      doorLevel: 0.8,
      rodentLevel: 0.5,
      doorTimeStart: "${DateTime(DateTime.now().year, 1, 1, 7, 0)}",
      doorTimeEnd: "${DateTime(DateTime.now().year, 1, 1, 18, 0)}",
      createdAt: "${DateTime.now()}",
      lastEditAt: "${DateTime.now()}",
      isDeleted: false,
    );
    _firebaseFirestore
        .collection(_WAREHOUSE_COLLECTION)
        .add(warehouseModel.toJson());
  }*/

  Future<List<WarehouseModel>> getWarehouses() async {
    List<WarehouseModel> warehouses = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(_WAREHOUSE_COLLECTION)
        .where(
          'is_deleted',
          isEqualTo: false,
        )
        .orderBy("state", descending: false)
        .get();
    for (var item in querySnapshot.docs) {
      warehouses.add(
        WarehouseModel.fromJson(
          item.data(),
        ),
      );
    }
    return warehouses;
  }

  Future<List<GodownModel>> getGodowns() async {
    List<GodownModel> godown = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(_GODOWN_COLLECTION)
        .where(
          'is_deleted',
          isEqualTo: false,
        )
        .orderBy("name", descending: false)
        .get();
    for (var item in querySnapshot.docs) {
      godown.add(
        GodownModel.fromJson(
          item.data(),
        ),
      );
    }
    return godown;
  }
}
