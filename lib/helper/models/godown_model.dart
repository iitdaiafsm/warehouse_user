class GodownModel {
  String? id;
  String? warehouseId;
  String? name;
  int? row;
  int? column;
  String? createdAt;
  String? lastEditAt;
  bool? isDeleted;
  List<SensorData>? topOuterSensor;
  List<SensorData>? topInnerSensor;
  List<SensorData>? bottomOuterSensor;
  List<SensorData>? bottomInnerSensor;
  List<SensorData>? leftOuterSensor;
  List<SensorData>? leftInnerSensor;
  List<SensorData>? rightOuterSensor;
  List<SensorData>? rightInnerSensor;
  List<SensorData>? centerSensor;

  GodownModel({
    this.id,
    this.warehouseId,
    this.name,
    this.row,
    this.column,
    this.createdAt,
    this.lastEditAt,
    this.topOuterSensor,
    this.topInnerSensor,
    this.bottomOuterSensor,
    this.bottomInnerSensor,
    this.leftOuterSensor,
    this.leftInnerSensor,
    this.rightOuterSensor,
    this.rightInnerSensor,
    this.centerSensor,
    this.isDeleted,
  });

  GodownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseId = json['warehouse_id'];
    name = json['name'];
    row = json['row'];
    column = json['column'];
    createdAt = json['created_at'];
    lastEditAt = json['last_edit_at'];
    isDeleted = json['is_deleted'];
    if (json['top_outer_sensor'] != null) {
      topOuterSensor = <SensorData>[];
      json['top_outer_sensor'].forEach((v) {
        topOuterSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['top_inner_sensor'] != null) {
      topInnerSensor = <SensorData>[];
      json['top_inner_sensor'].forEach((v) {
        topInnerSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['bottom_outer_sensor'] != null) {
      bottomOuterSensor = <SensorData>[];
      json['bottom_outer_sensor'].forEach((v) {
        bottomOuterSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['bottom_inner_sensor'] != null) {
      bottomInnerSensor = <SensorData>[];
      json['bottom_inner_sensor'].forEach((v) {
        bottomInnerSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['left_outer_sensor'] != null) {
      leftOuterSensor = <SensorData>[];
      json['left_outer_sensor'].forEach((v) {
        leftOuterSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['left_inner_sensor'] != null) {
      leftInnerSensor = <SensorData>[];
      json['left_inner_sensor'].forEach((v) {
        leftInnerSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['right_outer_sensor'] != null) {
      rightOuterSensor = <SensorData>[];
      json['right_outer_sensor'].forEach((v) {
        rightOuterSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['right_inner_sensor'] != null) {
      rightInnerSensor = <SensorData>[];
      json['right_inner_sensor'].forEach((v) {
        rightInnerSensor!.add(SensorData.fromJson(v));
      });
    }
    if (json['center_sensor'] != null) {
      centerSensor = <SensorData>[];
      json['center_sensor'].forEach((v) {
        centerSensor!.add(SensorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['warehouse_id'] = warehouseId;
    data['name'] = name;
    data['row'] = row;
    data['column'] = column;
    data['created_at'] = createdAt;
    data['last_edit_at'] = lastEditAt;
    data['is_deleted'] = isDeleted;
    if (topOuterSensor != null) {
      data['top_outer_sensor'] =
          topOuterSensor!.map((v) => v.toJson()).toList();
    }
    if (topInnerSensor != null) {
      data['top_inner_sensor'] =
          topInnerSensor!.map((v) => v.toJson()).toList();
    }
    if (bottomOuterSensor != null) {
      data['bottom_outer_sensor'] =
          bottomOuterSensor!.map((v) => v.toJson()).toList();
    }
    if (bottomInnerSensor != null) {
      data['bottom_inner_sensor'] =
          bottomInnerSensor!.map((v) => v.toJson()).toList();
    }
    if (leftOuterSensor != null) {
      data['left_outer_sensor'] =
          leftOuterSensor!.map((v) => v.toJson()).toList();
    }
    if (leftInnerSensor != null) {
      data['left_inner_sensor'] =
          leftInnerSensor!.map((v) => v.toJson()).toList();
    }
    if (rightOuterSensor != null) {
      data['right_outer_sensor'] =
          rightOuterSensor!.map((v) => v.toJson()).toList();
    }
    if (rightInnerSensor != null) {
      data['right_inner_sensor'] =
          rightInnerSensor!.map((v) => v.toJson()).toList();
    }
    if (centerSensor != null) {
      data['center_sensor'] = centerSensor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SensorData {
  String? name;
  int? position;
  String? lastEditAt;
  double? temperature;
  double? pressure;
  double? humidity;
  double? co2;
  double? battery;
  String? time;
  double? value;
  double? air;
  String? version;
  double? gas;
  double? altitude;
  double? aqi;
  double? tvoc;
  bool? doorOpen;
  bool? smokeEnable;
  double? oxygen;
  bool? rodentEnable;
  String? type;

  SensorData({
    this.name,
    this.position,
    this.lastEditAt,
    this.temperature,
    this.humidity,
    this.co2,
    this.battery,
    this.time,
    this.value,
    this.air,
    this.version = "v1",
    this.pressure,
    this.gas,
    this.altitude,
    this.aqi,
    this.tvoc,
    this.doorOpen,
    this.smokeEnable,
    this.oxygen,
    this.rodentEnable,
    this.type,
  });

  SensorData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
    lastEditAt = json['last_edit_at'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    co2 = json['co2'];
    battery = json['battery'];
    time = json['time'];
    value = json['value'];
    air = json['air'];
    version = json['version'];
    pressure = json['pressure'];
    gas = json['gas'];
    altitude = json['altitude'];
    aqi = json['aqi'];
    tvoc = json['tvoc'];
    doorOpen = json['doorOpen'];
    smokeEnable = json['smokeEnable'];
    oxygen = json['oxygen'];
    rodentEnable = json['rodentEnable'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (position != null) data['position'] = position;
    if (lastEditAt != null) data['last_edit_at'] = lastEditAt;
    if (temperature != null) data['temperature'] = temperature;
    if (humidity != null) data['humidity'] = humidity;
    if (co2 != null) data['co2'] = co2;
    if (battery != null) data['battery'] = battery;
    if (time != null) data['time'] = time;
    if (value != null) data['value'] = value;
    if (air != null) data['air'] = air;
    if (version != null) data['version'] = version;
    if (pressure != null) data['pressure'] = pressure;
    if (gas != null) data['gas'] = gas;
    if (altitude != null) data['altitude'] = altitude;
    if (aqi != null) data['aqi'] = aqi;
    if (tvoc != null) data['tvoc'] = tvoc;
    if (doorOpen != null) data['doorOpen'] = doorOpen;
    if (smokeEnable != null) data['smokeEnable'] = smokeEnable;
    if (oxygen != null) data['oxygen'] = oxygen;
    if (rodentEnable != null) data['rodentEnable'] = rodentEnable;
    if (type != null) data['type'] = type;
    return data;
  }
}

class SensorModel {
  String? name;
  int? position;
  String? lastEditAt;
  List<double>? data;

  SensorModel({this.name, this.position, this.lastEditAt, this.data});

  SensorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
    lastEditAt = json['last_edit_at'];
    data = json['data'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['position'] = position;
    data['last_edit_at'] = lastEditAt;
    data['data'] = this.data;
    return data;
  }
}
