import '../utils/chart_sample_data.dart';

class TrendDataModel {
  String? header;
  List<Data>? data;

  TrendDataModel({this.header, this.data});

  TrendDataModel.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['header'] = header;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sensorName;
  String? chartTitle;
  double? high;
  double? low;
  List<ChartSampleData>? chartSampleData;

  Data({
    this.sensorName,
    this.chartTitle,
    this.chartSampleData,
    this.high,
    this.low,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sensorName = json['sensor_name'];
    chartTitle = json['chart_title'];
    low = json['low'];
    high = json['high'];
    if (json['chart_sample_data'] != null) {
      chartSampleData = <ChartSampleData>[];
      json['chart_sample_data'].forEach((v) {
        chartSampleData!.add(ChartSampleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sensor_name'] = sensorName;
    data['chart_title'] = chartTitle;
    data['low'] = low;
    data['high'] = high;
    if (chartSampleData != null) {
      data['chart_sample_data'] =
          chartSampleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
