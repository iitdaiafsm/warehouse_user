import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/main/logic.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/warehouse_global_controller.dart';

import '../../helper/routes.dart';
import '../utils_widgets/flutter_bounce.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainLogic>(
          init: MainLogic(),
          builder: (logic) {
            return LayoutBuilder(builder: (context, constraints) {
              width(context) => constraints.maxWidth;
              height(context) => constraints.maxHeight;
              return Container(
                width: width(context),
                height: height(context),
                padding: EdgeInsets.all(
                    getWidth(AppConfig.DEFAULT_PADDING / 2, context)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height(context) * 0.05,
                        child: FittedBox(
                          child: Text(
                            "SMART Warehouse",
                            style: FSMResources.FSMTextStyle(
                              color: appTextDarkColor,
                              size: AppConfig.FONT_SIZE_H1,
                              type: TextStyleType.bold,
                              context: context,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width(context) < height(context)
                            ? width(context)
                            : height(context) * 0.91,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getWidth(0.6, context),
                            ),
                            border: Border.all(
                              color: appTextDarkColor,
                              width: getWidth(0.05, context),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(-3, 3),
                                color: appTextDarkColor,
                                // spreadRadius: getWidth(0.1),
                                blurRadius: getWidth(0.2, context),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: getWidth(5, context)),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(getWidth(0.6, context)),
                            child: Stack(
                              children: [
                                Container(
                                  width: height(context),
                                  height: height(context),
                                  color: Colors.white,
                                  child: Image.asset(
                                    "asset/india_map.png",
                                    key: logic.globalKey,
                                  ),
                                ),
                                Positioned(
                                  left: logic.stackSize.width * 0.29,
                                  top: width(context) < height(context)
                                      ? (width(context)) * 0.27
                                      : logic.stackSize.height * 0.27,
                                  child: GetBuilder<WarehouseGlobalController>(
                                    init: WarehouseGlobalController(),
                                    id: "title",
                                    builder: (logic) {
                                      return Bounce(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: appWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getWidth(0.2, context),
                                              ),
                                              boxShadow: logic
                                                      .topLevelAlerts.isEmpty
                                                  ? null
                                                  : [
                                                      BoxShadow(
                                                        color:
                                                            appDangerTextColor,
                                                        blurRadius: getWidth(
                                                            logic.blinkAnimation
                                                                    .value /
                                                                2,
                                                            context),
                                                        offset:
                                                            const Offset(0, 0),
                                                        spreadRadius: getWidth(
                                                            logic.blinkAnimation
                                                                    .value /
                                                                2,
                                                            context),
                                                      )
                                                    ],
                                              border: Border.all()),
                                          padding: EdgeInsets.all(
                                            getWidth(0.2, context),
                                          ),
                                          child: Text(
                                            "FCI Pusa Delhi",
                                            style: FSMResources.FSMTextStyle(
                                              context: context,
                                              color: appTextDarkColor,
                                              size: AppConfig.FONT_SIZE_H9,
                                              type: TextStyleType.bold,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.rootDelegate.toNamed(
                                              Routes.WAREHOUSE_LIST_PAGE);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          }),
    );
  }
}
