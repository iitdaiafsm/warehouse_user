import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

double width(BuildContext context) => MediaQuery.of(context).size.width;

double height(BuildContext context) => MediaQuery.of(context).size.height;

double getFontSize(double size, BuildContext context) {
  var _screenWidth = MediaQuery.of(context).size.width;
  return _screenWidth * (size) / 100;
}

double getWidth(double size, BuildContext context) {
  var _screenWidth = MediaQuery.of(context).size.width;
  return _screenWidth * (size) / 100;
}

double getHeight(double size, BuildContext context) {
  var _screenWidth = MediaQuery.of(context).size.width;
  return _screenWidth * (size) / 100;
}

double getRelativeSize(double size1, double size2) {
  return size1 * (size2) / 100;
}
