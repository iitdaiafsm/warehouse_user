class WarehouseModel {
  String? id;
  String? name;
  String? state;
  String? city;
  double? latitude;
  double? longitude;
  String? hostName;
  String? measurement;
  int? refreshTime;
  double? humidityLower;
  double? humidityHigher;
  double? temperatureLower;
  double? temperatureHigher;
  double? pressureLower;
  double? pressureHigher;
  double? co2Lower;
  double? co2Higher;
  double? gasLower;
  double? gasHigher;
  double? airflowLevel;
  double? oxygenLevel;
  double? batteryLevel;
  double? smokeLevel;
  double? rodentLevel;
  double? doorLevel;
  String? doorTimeStart;
  String? doorTimeEnd;
  String? createdAt;
  String? lastEditAt;
  bool? isDeleted;
  bool? haveAlert;

  WarehouseModel({
    this.id,
    this.name,
    this.state,
    this.city,
    this.latitude,
    this.longitude,
    this.hostName,
    this.measurement,
    this.refreshTime,
    this.humidityLower,
    this.humidityHigher,
    this.temperatureLower,
    this.temperatureHigher,
    this.pressureLower,
    this.pressureHigher,
    this.co2Lower,
    this.co2Higher,
    this.gasLower,
    this.gasHigher,
    this.airflowLevel,
    this.oxygenLevel,
    this.batteryLevel,
    this.smokeLevel,
    this.rodentLevel,
    this.doorLevel,
    this.doorTimeStart,
    this.doorTimeEnd,
    this.createdAt,
    this.lastEditAt,
    this.isDeleted,
    this.haveAlert = false,
  });

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    hostName = json['host_name'];
    measurement = json['measurement'];
    refreshTime = json['refresh_time'];
    humidityLower = double.parse("${json['humidity_lower']}");
    humidityHigher = double.parse("${json['humidity_higher']}");
    temperatureLower = double.parse("${json['temperature_lower']}");
    temperatureHigher = double.parse("${json['temperature_higher']}");
    pressureLower = double.parse("${json['pressure_lower'] ?? '0.0'}");
    pressureHigher = double.parse("${json['pressure_higher'] ?? '1500.0'}");
    co2Lower = double.parse("${json['co2_lower']}");
    co2Higher = double.parse("${json['co2_higher']}");
    gasLower = double.parse("${json['gas_lower']}");
    gasHigher = double.parse("${json['gas_higher']}");
    airflowLevel = double.parse("${json['airflow_level']}");
    oxygenLevel = double.parse("${json['oxygen_level']}");
    batteryLevel = double.parse("${json['battery_level']}");
    smokeLevel = double.parse("${json['smoke_level']}");
    rodentLevel = double.parse("${json['rodent_level']}");
    doorLevel = double.parse("${json['door_level']}");
    doorTimeStart = json['door_time_start'];
    doorTimeEnd = json['door_time_end'];
    createdAt = json['created_at'];
    lastEditAt = json['last_edit_at'];
    isDeleted = json['is_deleted'];
    haveAlert = json['alert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state'] = state;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['host_name'] = hostName;
    data['measurement'] = measurement;
    data['refresh_time'] = refreshTime;
    data['humidity_lower'] = humidityLower;
    data['humidity_higher'] = humidityHigher;
    data['temperature_lower'] = temperatureLower;
    data['temperature_higher'] = temperatureHigher;
    data['pressure_lower'] = pressureLower;
    data['pressure_higher'] = pressureHigher;
    data['co2_lower'] = co2Lower;
    data['co2_higher'] = co2Higher;
    data['gas_lower'] = gasLower;
    data['gas_higher'] = gasHigher;
    data['airflow_level'] = airflowLevel;
    data['oxygen_level'] = oxygenLevel;
    data['battery_level'] = batteryLevel;
    data['smoke_level'] = smokeLevel;
    data['rodent_level'] = rodentLevel;
    data['door_level'] = doorLevel;
    data['door_time_start'] = doorTimeStart;
    data['door_time_end'] = doorTimeEnd;
    data['created_at'] = createdAt;
    data['last_edit_at'] = lastEditAt;
    data['is_deleted'] = isDeleted;
    data['alert'] = haveAlert;
    return data;
  }
}
