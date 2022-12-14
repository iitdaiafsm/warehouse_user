class DummyMeasurementDataModel {
  GridData? gridData;
  List<FansData>? fansData;
  DoorsData? doorsData;
  Measurement? measurement;
  List<SensorData>? topMotionDetectorValues;
  List<SensorData>? leftMotionDetectorValues;
  List<SensorData>? bottomMotionDetectorValues;
  List<SensorData>? rightMotionDetectorValues;
  List<SensorData>? smokeValues;
  List<AirflowData>? airFlows;
  List<SensorData>? gasValues;
  List<SensorData>? oxygenValues;

  DummyMeasurementDataModel({
    this.gridData,
    this.fansData,
    this.doorsData,
    this.measurement,
    this.topMotionDetectorValues,
    this.leftMotionDetectorValues,
    this.smokeValues,
    this.airFlows,
    this.gasValues,
    this.oxygenValues,
    this.bottomMotionDetectorValues,
    this.rightMotionDetectorValues,
  });

  DummyMeasurementDataModel.fromJson(Map<String, dynamic> json) {
    gridData =
        json['grid_data'] != null ? GridData.fromJson(json['grid_data']) : null;
    if (json['fans_data'] != null) {
      fansData = <FansData>[];
      json['fans_data'].forEach((v) {
        fansData!.add(FansData.fromJson(v));
      });
    }
    if (json['airflow'] != null) {
      airFlows = <AirflowData>[];
      json['airflow'].forEach((v) {
        airFlows!.add(AirflowData.fromJson(v));
      });
    }
    if (json['top_motion'] != null) {
      topMotionDetectorValues = <SensorData>[];
      json['top_motion'].forEach((v) {
        topMotionDetectorValues!.add(SensorData.fromJson(v));
      });
    }
    if (json['left_motion'] != null) {
      leftMotionDetectorValues = <SensorData>[];
      json['left_motion'].forEach((v) {
        leftMotionDetectorValues!.add(SensorData.fromJson(v));
      });
    }
    if (json['bottom_motion'] != null) {
      bottomMotionDetectorValues = <SensorData>[];
      json['bottom_motion'].forEach((v) {
        bottomMotionDetectorValues!.add(SensorData.fromJson(v));
      });
    }
    if (json['right_motion'] != null) {
      rightMotionDetectorValues = <SensorData>[];
      json['right_motion'].forEach((v) {
        rightMotionDetectorValues!.add(SensorData.fromJson(v));
      });
    }

    if (json['smoke'] != null) {
      smokeValues = <SensorData>[];
      json['smoke'].forEach((v) {
        smokeValues!.add(SensorData.fromJson(v));
      });
    }
    if (json['gas'] != null) {
      gasValues = <SensorData>[];
      json['gas'].forEach((v) {
        gasValues!.add(SensorData.fromJson(v));
      });
    }
    if (json['oxygen'] != null) {
      oxygenValues = <SensorData>[];
      json['oxygen'].forEach((v) {
        oxygenValues!.add(SensorData.fromJson(v));
      });
    }
    doorsData = json['doors_data'] != null
        ? DoorsData.fromJson(json['doors_data'])
        : null;
    measurement = json['measurement'] != null
        ? Measurement.fromJson(json['measurement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gridData != null) {
      data['grid_data'] = gridData!.toJson();
    }
    if (fansData != null) {
      data['fans_data'] = fansData!.map((v) => v.toJson()).toList();
    }
    if (airFlows != null) {
      data['airflow'] = airFlows!.map((v) => v.toJson()).toList();
    }
    if (doorsData != null) {
      data['doors_data'] = doorsData!.toJson();
    }
    if (measurement != null) {
      data['measurement'] = measurement!.toJson();
    }
    if (topMotionDetectorValues != null) {
      data['top_motion'] =
          topMotionDetectorValues!.map((v) => v.toJson()).toList();
    }
    if (leftMotionDetectorValues != null) {
      data['left_motion'] =
          leftMotionDetectorValues!.map((v) => v.toJson()).toList();
    }
    if (rightMotionDetectorValues != null) {
      data['right_motion'] =
          rightMotionDetectorValues!.map((v) => v.toJson()).toList();
    }
    if (bottomMotionDetectorValues != null) {
      data['bottom_motion'] =
          bottomMotionDetectorValues!.map((v) => v.toJson()).toList();
    }
    if (smokeValues != null) {
      data['smoke'] = smokeValues!.map((v) => v.toJson()).toList();
    }
    if (gasValues != null) {
      data['gas'] = gasValues!.map((v) => v.toJson()).toList();
    }
    if (oxygenValues != null) {
      data['oxygen'] = oxygenValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GridData {
  int? rows;
  int? columns;

  GridData({this.rows, this.columns});

  GridData.fromJson(Map<String, dynamic> json) {
    rows = json['rows'];
    columns = json['columns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rows'] = rows;
    data['columns'] = columns;
    return data;
  }
}

class FansData {
  double? top;
  double? left;
  double? right;
  double? bottom;
  bool? isRunning;

  FansData({this.top, this.left, this.right, this.bottom, this.isRunning});

  FansData.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    left = json['left'];
    right = json['right'];
    bottom = json['bottom'];
    isRunning = json['isRunning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['top'] = top;
    data['left'] = left;
    data['right'] = right;
    data['bottom'] = bottom;
    data['isRunning'] = isRunning;
    return data;
  }
}

class DoorsData {
  List<LeftDoors>? leftDoors;
  List<LeftDoors>? rightDoors;
  List<LeftDoors>? topDoors;
  List<LeftDoors>? bottomDoors;

  DoorsData({this.leftDoors, this.rightDoors, this.topDoors, this.bottomDoors});

  DoorsData.fromJson(Map<String, dynamic> json) {
    if (json['left_doors'] != null) {
      leftDoors = <LeftDoors>[];
      json['left_doors'].forEach((v) {
        leftDoors!.add(LeftDoors.fromJson(v));
      });
    }
    if (json['right_doors'] != null) {
      rightDoors = <LeftDoors>[];
      json['right_doors'].forEach((v) {
        rightDoors!.add(LeftDoors.fromJson(v));
      });
    }
    if (json['top_doors'] != null) {
      topDoors = <LeftDoors>[];
      json['top_doors'].forEach((v) {
        topDoors!.add(LeftDoors.fromJson(v));
      });
    }
    if (json['bottom_doors'] != null) {
      bottomDoors = <LeftDoors>[];
      json['bottom_doors'].forEach((v) {
        bottomDoors!.add(LeftDoors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leftDoors != null) {
      data['left_doors'] = leftDoors!.map((v) => v.toJson()).toList();
    }
    if (rightDoors != null) {
      data['right_doors'] = rightDoors!.map((v) => v.toJson()).toList();
    }
    if (topDoors != null) {
      data['top_doors'] = topDoors!.map((v) => v.toJson()).toList();
    }
    if (bottomDoors != null) {
      data['bottom_doors'] = bottomDoors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeftDoors {
  bool? isRunning;
  double? battery;
  String? time;
  String? name;
  String? id;

  LeftDoors(
      {this.isRunning, this.battery, this.time, this.name, required this.id});

  LeftDoors.fromJson(Map<String, dynamic> json) {
    isRunning = json['isRunning'];
    battery = json['battery'];
    time = json['time'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isRunning'] = isRunning;
    data['battery'] = battery;
    data['time'] = time;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class AirflowData {
  double? air;
  double? temperature;
  double? battery;
  String? time;
  String? name;
  String? id;

  AirflowData(
      {this.air,
      this.temperature,
      this.time,
      this.battery,
      this.name,
      required this.id});

  AirflowData.fromJson(Map<String, dynamic> json) {
    air = json['air'];
    temperature = json['temperature'];
    battery = json['battery'];
    time = json['time'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air'] = air;
    data['temperature'] = temperature;
    data['battery'] = battery;
    data['time'] = time;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Measurement {
  List<LeftMeasurement>? leftMeasurement;
  List<LeftMeasurement>? topMeasurement;
  List<LeftMeasurement>? rightMeasurement;
  List<LeftMeasurement>? bottomMeasurement;

  Measurement(
      {this.leftMeasurement,
      this.topMeasurement,
      this.rightMeasurement,
      this.bottomMeasurement});

  Measurement.fromJson(Map<String, dynamic> json) {
    if (json['left_measurement'] != null) {
      leftMeasurement = <LeftMeasurement>[];
      json['left_measurement'].forEach((v) {
        leftMeasurement!.add(LeftMeasurement.fromJson(v));
      });
    }
    if (json['top_measurement'] != null) {
      topMeasurement = <LeftMeasurement>[];
      json['top_measurement'].forEach((v) {
        topMeasurement!.add(LeftMeasurement.fromJson(v));
      });
    }
    if (json['right_measurement'] != null) {
      rightMeasurement = <LeftMeasurement>[];
      json['right_measurement'].forEach((v) {
        rightMeasurement!.add(LeftMeasurement.fromJson(v));
      });
    }
    if (json['bottom_measurement'] != null) {
      bottomMeasurement = <LeftMeasurement>[];
      json['bottom_measurement'].forEach((v) {
        bottomMeasurement!.add(LeftMeasurement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leftMeasurement != null) {
      data['left_measurement'] =
          leftMeasurement!.map((v) => v.toJson()).toList();
    }
    if (topMeasurement != null) {
      data['top_measurement'] =
          topMeasurement!.map((v) => v.toJson()).toList();
    }
    if (rightMeasurement != null) {
      data['right_measurement'] =
          rightMeasurement!.map((v) => v.toJson()).toList();
    }
    if (bottomMeasurement != null) {
      data['bottom_measurement'] =
          bottomMeasurement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeftMeasurement {
  double? humidity;
  double? temperature;
  double? co2;
  double? battery;
  String? time;
  String? name;
  String? id;

  LeftMeasurement(
      {this.humidity,
      this.temperature,
      this.co2,
      this.battery,
      this.time,
      this.name,
      required this.id});

  LeftMeasurement.fromJson(Map<String, dynamic> json) {
    humidity = json['humidity'];
    temperature = json['temperature'];
    co2 = json['co2'];
    battery = json['battery'];
    time = json['time'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['humidity'] = humidity;
    data['temperature'] = temperature;
    data['co2'] = co2;
    data['battery'] = battery;
    data['time'] = time;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class SensorData {
  double? value;
  double? battery;
  String? time;
  String? name;
  String? id;

  SensorData(
      {this.value, this.battery, this.time, this.name, required this.id});

  SensorData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    battery = json['battery'];
    time = json['time'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['battery'] = battery;
    data['time'] = time;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
