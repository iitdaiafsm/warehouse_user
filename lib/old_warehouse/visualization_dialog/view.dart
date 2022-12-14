import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'logic.dart';

class VisualizationDialogPage extends StatelessWidget {
  Map<String, dynamic> map;
  VisualizationDialogPage({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisualizationDialogLogic>(
      init: VisualizationDialogLogic(),
      didChangeDependencies: (state) {
        state.controller!.getAllHistoryOfSensor(
            map['name'], map['field'], map['type'], context);
      },
      builder: (logic) {
        return Card(
          child: logic.dialogWidget,
        );
        /*return SfLinearGauge(
            showTicks: false,
            interval: 30,
            labelOffset: 0,
            axisTrackStyle: const LinearAxisTrackStyle(
                thickness: 75, color: Colors.transparent),
            labelFormatterCallback: (String label) {
              switch (label) {
                case '0':
                  return '00:00';
                case '30':
                  return '06:00';
                case '60':
                  return '12:00';
                case '90':
                  return '18:00';
                case '100':
                  return ' ';
              }
              return label;
            },
            markerPointers: List<LinearWidgetPointer>.generate(
              24,
              (int index) => _buildLinearWidgetPointer(
                  index * 4,
                  logic.inActiveHours.contains(index)
                      ? _getInActivePointerColor(
                          const Color(0xFF05C3DD),
                          0.7,
                      Colors.white)
                      : const Color(0xFF05C3DD)),
            ));*/
      },
    );
  }

  Color _getInActivePointerColor(Color color, double factor,
      [Color mix = Colors.black]) {
    return color == Colors.transparent
        ? color
        : Color.fromRGBO(
            ((1 - factor) * color.red + factor * mix.red).toInt(),
            ((1 - factor) * color.green + factor * mix.green).toInt(),
            ((1 - factor) * color.blue + factor * mix.blue).toInt(),
            1);
  }

  ///Create Linear widget pointer
  LinearWidgetPointer _buildLinearWidgetPointer(double value, Color color) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      child: Container(
        height: 75,
        width: 11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
      ),
    );
  }
}
