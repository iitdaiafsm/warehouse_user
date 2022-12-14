import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../model/dummy_measurement_model.dart';

class Prefs {
  late GetStorage _storage;
  final String _warehouseLocation = "warehouse_location";

  Prefs() {
    _storage = GetStorage();
  }

  Future<void> setSelectedWarehouseLocation(DummyMeasurementDataModel value) async {
    await _storage.write(_warehouseLocation, jsonEncode(value));
  }

  Future<DummyMeasurementDataModel> getSelectedWarehouseLocation() async{
   var value =  _storage.read<String?>(_warehouseLocation);
   if(value !=null){
     return DummyMeasurementDataModel.fromJson(jsonDecode(value));
   }else{
     return DummyMeasurementDataModel();
   }
  }
}
