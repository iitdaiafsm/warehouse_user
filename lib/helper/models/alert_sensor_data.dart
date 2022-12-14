class AlertSensorData {
  String? name;
  String? iconPath;
  String? time;
  String? value;
  String? message;
  String? type;

  AlertSensorData({
    this.name,
    this.iconPath,
    this.time,
    this.value,
    this.message,
    this.type,
  });

  AlertSensorData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconPath = json['icon_path'];
    time = json['time'];
    value = json['value'];
    message = json['message'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon_path'] = iconPath;
    data['time'] = time;
    data['value'] = value;
    data['message'] = message;
    data['type'] = type;
    return data;
  }
}
