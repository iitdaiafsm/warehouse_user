import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/helper/styles.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

import '../../widgets/flutter_map.dart';
import '../../widgets/google_map.dart';
import '../../widgets/heading_widget.dart';
import '../../widgets/warehouse_list.dart';

class WarehouseScreen extends StatelessWidget {
  const WarehouseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      smallScreen: Container(
        width: width(context),
        height: height(context),
        padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadingWidget(
              title: "Smart Warehouse",
            ),
            if (width(context) > height(context))
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        GetBuilder<WarehouseController>(
                          init: WarehouseController(),
                          id: "map",
                          builder: (controller) {
                            controller.htmlId = String.fromCharCodes(
                                List.generate(
                                    12, (index) => Random().nextInt(33) + 89));
                            return Expanded(
                              child: AspectRatio(
                                aspectRatio: 1.459,
                                child: kIsWeb
                                    ? GoogleMap(
                                        controller: controller,
                                        htmlId: controller.htmlId,
                                      )
                                    : FlutterMap(
                                        controller: controller,
                                      ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: AppMethods.DEFAULT_PADDING * 6,
                        ),
                      ],
                    ),
                    if (width(context) > height(context))
                      SizedBox(
                        width: AppMethods.DEFAULT_PADDING,
                      ),
                    if (width(context) > height(context))
                      GetBuilder<WarehouseController>(
                        init: WarehouseController(),
                        id: "list",
                        builder: (controller) {
                          return Expanded(
                            child: WarehouseListWidget(
                              controller: controller,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            if (width(context) <= height(context))
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.4,
                      width: width(context),
                      child: GetBuilder<WarehouseController>(
                        init: WarehouseController(),
                        id: "map",
                        builder: (controller) {
                          controller.htmlId = String.fromCharCodes(
                              List.generate(
                                  12, (index) => Random().nextInt(33) + 89));
                          return kIsWeb
                              ? GoogleMap(
                                  controller: controller,
                                  htmlId: controller.htmlId,
                                )
                              : FlutterMap(
                                  controller: controller,
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING,
                    ),
                    GetBuilder<WarehouseController>(
                      init: WarehouseController(),
                      id: "list",
                      builder: (controller) {
                        return Expanded(
                          child: Container(
                            width: width(context),
                            child: WarehouseListWidget(
                              controller: controller,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
