import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/helper/styles.dart';

import '../helper/responsive_widget.dart';

class HeadingWidget extends StatelessWidget {
  final String title;

  const HeadingWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppMethods.DEFAULT_PADDING,
      ),
      margin: EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING),
      width: width(context) * 0.33,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
          width: 3,
        ),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
              ResponsiveWidget.isLargeScreen(context) ? 50 : 25),
          bottomRight: Radius.circular(
              ResponsiveWidget.isLargeScreen(context) ? 50 : 25),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(-3, 3),
            color: Theme.of(context).primaryColorLight.withOpacity(0.28),
            blurRadius: 6,
          ),
        ],
      ),
      child: Text(
        title,
        style: textStyle(
          context: context,
          isBold: true,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
