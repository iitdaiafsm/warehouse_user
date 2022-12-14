import 'package:flutter/material.dart';
import 'package:warehouse_user/helper/styles.dart';

class StatusBarHeight extends StatelessWidget {
  Color? backgrounColor;
  StatusBarHeight({Key? key, this.backgrounColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: MediaQuery.of(context).viewPadding.top,
      color: backgrounColor ?? Theme.of(context).cardColor,
    );
  }
}
