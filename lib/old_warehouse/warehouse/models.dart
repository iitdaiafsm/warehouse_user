class FansData {
  double? top;
  double? bottom;
  double? left;
  double? right;
  bool isRunning;

  FansData({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.isRunning,
  });
}

class GridData{
  final int columns;
  final int rows;
  GridData({required this.columns, required this.rows});
}

class DoorData{
  bool isOpen;
  DoorData(this.isOpen);
}

class MeasurementData{
  final double humidity;
  final double temperature;
  final double coTwo;

  MeasurementData(this.humidity, this.temperature, this.coTwo);
}
