import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_user/widgets/dotted_border/dotted_border.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String formatTime() {
    DateTime sensorDateTime = DateTime.parse(this).toLocal();
    final String formattedTime = DateFormat("hh:mm a").format(sensorDateTime);
    return formattedTime;
  }
}

extension WidgetExtension on Widget {
  Widget dottedBorder() {
    return DottedBorder(
      color: const Color(0xFF707070),
      strokeWidth: 0.5,
      dashPattern: const [4, 4],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: this,
      ),
    );
  }
}
