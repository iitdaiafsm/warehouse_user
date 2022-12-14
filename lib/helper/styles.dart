import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:warehouse_user/helper/responsive_widget.dart';

TextStyle textStyle({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool haveShadow = false,
  TextDecoration textDecoration = TextDecoration.none,
  bool isCard = false,
}) {
  return isCard
      ? GoogleFonts.lora(
          color: color ?? Theme.of(context).primaryColorDark,
          fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        )
      : GoogleFonts.openSans(
          color: color ?? Theme.of(context).primaryColorDark,
          fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        );
}

_getFontSize(FontSize fontSize, BuildContext context) {
  switch (fontSize) {
    case FontSize.H1:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          80;

    case FontSize.H2:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          90;

    case FontSize.H3:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          100;

    case FontSize.H4:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          110;

    case FontSize.H5:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          120;

    case FontSize.H6:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          130;
    case FontSize.H7:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          140;
    case FontSize.TITLE:
      return ((width(context) > height(context))
              ? width(context)
              : height(context)) /
          70;
  }
}

double width(BuildContext context) => MediaQuery.of(context).size.width;

double height(BuildContext context) => MediaQuery.of(context).size.height;

double getWidth(double size, BuildContext context) {
  double _width = MediaQuery.of(context).size.width;
  return _width * (size / 750);
}

double getHeight(double size, BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return _height * (size / 750);
}

enum FontSize {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  H7,
  TITLE,
}
