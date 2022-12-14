import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'app_config.dart';
import 'app_size.dart';

class MyToolTip{
  static late  SuperTooltip tooltip;

  static void showToolTip(String title,List<KeyValueClass> keyValueList, BuildContext context){
    tooltip = SuperTooltip(
        popupDirection: TooltipDirection.right,
        content: AppConfig.getHoverInnerWidget(
            title,
            keyValueList,
            context),
        dismissOnTapOutside: true,
        borderWidth: getWidth(0.1, context),
        maxWidth: getWidth(30, context));

    tooltip.show(context);
  }

  static void hideToolTip(){
    tooltip.close();
  }
}