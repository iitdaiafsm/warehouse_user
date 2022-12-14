import 'dart:ui';

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
        this.y,
        this.xValue,
        this.yValue,
        this.secondSeriesYValue,
        this.thirdSeriesYValue,
        this.pointColor,
        this.size,
        this.text,
        this.open,
        this.close,
        this.low,
        this.high,
        this.volume});

  /// Holds x value of the datapoint
   dynamic x;

  /// Holds y value of the datapoint
   num? y;

  /// Holds x value of the datapoint
   dynamic xValue;

  /// Holds y value of the datapoint
   num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
   num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
   num? thirdSeriesYValue;

  /// Holds point color of the datapoint
   Color? pointColor;

  /// Holds size of the datapoint
   num? size;

  /// Holds datalabel/text value mapper of the datapoint
   String? text;

  /// Holds open value of the datapoint
   num? open;

  /// Holds close value of the datapoint
   num? close;

  /// Holds low value of the datapoint
   num? low;

  /// Holds high value of the datapoint
   num? high;

  /// Holds open value of the datapoint
   num? volume;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x.toString();
    data['y'] = y.toString();
    return data;
  }
  ChartSampleData.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }
}