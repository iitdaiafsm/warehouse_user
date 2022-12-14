import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';

import 'app_size.dart';
import 'colors.dart';

enum TextStyleType {
  regular,
  italic,
  bold,
}

class FSMResources {
  static String _FONT_FAMILY = "Ubuntu";
  // ignore: non_constant_identifier_names
  static TextStyle FSMTextStyle(
      {TextStyleType type = TextStyleType.regular,
      Color? color,
      double? size,
      bool? haveLineThrough,
      double? height,
      required BuildContext context}) {
    return TextStyle(
        decoration: haveLineThrough != null && haveLineThrough
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        color: color ?? appTextDarkColor,
        fontSize: size != null
            ? getFontSize(size, context)
            : getFontSize(AppConfig.FONT_SIZE_H3, context),
        height: height,
        fontFamily: _FONT_FAMILY,
        fontStyle: type == TextStyleType.regular
            ? FontStyle.normal
            : type == TextStyleType.italic
                ? FontStyle.italic
                : FontStyle.normal,
        fontWeight:
            type == TextStyleType.regular || type == TextStyleType.italic
                ? FontWeight.normal
                : FontWeight.bold);
  }
}
