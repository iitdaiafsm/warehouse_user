import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/warehouse/view.dart';
import 'package:warehouse_user/old_warehouse/warehouse_global_controller.dart';

import '../../helper/routes.dart';
import '../utils/fsm_resource.dart';
import '../utils_widgets/flutter_bounce.dart';

class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: Container(
              height: height(context),
              color: appWhiteColor,
              padding: EdgeInsets.all(getWidth(2, context)),
              child: Column(
                children: [
                  Text(
                    "Menu",
                    style: FSMResources.FSMTextStyle(
                      context: context,
                      color: appPrimaryColor,
                      type: TextStyleType.bold,
                      size: AppConfig.FONT_SIZE_H3,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(0.5, context),
                  ),
                  Bounce(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.STREAM_PAGE);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: appWarehouseBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            getWidth(
                              0.5,
                              context,
                            ),
                          ),
                          border: Border.all(color: appPrimaryColor)),
                      padding: EdgeInsets.all(
                        getWidth(
                          1,
                          context,
                        ),
                      ),
                      width: getWidth(20, context),
                      alignment: Alignment.center,
                      child: Text(
                        "Live Stream",
                        style: FSMResources.FSMTextStyle(
                          context: context,
                          color: appPrimaryColor,
                          type: TextStyleType.italic,
                          size: AppConfig.FONT_SIZE_H5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(0.5, context),
                  ),
                  Bounce(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.TRENDS_PAGE);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: appWarehouseBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            getWidth(
                              0.5,
                              context,
                            ),
                          ),
                          border: Border.all(color: appPrimaryColor)),
                      padding: EdgeInsets.all(
                        getWidth(
                          1,
                          context,
                        ),
                      ),
                      width: getWidth(20, context),
                      alignment: Alignment.center,
                      child: Text(
                        "Trends",
                        style: FSMResources.FSMTextStyle(
                          context: context,
                          color: appPrimaryColor,
                          type: TextStyleType.italic,
                          size: AppConfig.FONT_SIZE_H5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: GetBuilder<WarehouseGlobalController>(
                  init: WarehouseGlobalController(),
                  builder: (logic) {
                    return logic.currentWarehouse != null
                        ? WarehousePage(
                            title: "SMART Warehouse",
                            dummyMeasurementDataModel: logic.currentWarehouse,
                            onBackPressed: () {
                              // Get.offNamed(Routes.WAREHOUSE_LIST_PAGE);
                              Get.rootDelegate
                                  .backUntil(Routes.WAREHOUSE_LIST_PAGE);
                            },
                            onDrawerPressed: () {
                              _scaffoldKey.currentState!.openEndDrawer();
                            },
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ),
        onWillPop: () async {
          // Get.offNamed(Routes.WAREHOUSE_LIST_PAGE);
          Get.rootDelegate.backUntil(Routes.WAREHOUSE_LIST_PAGE);
          return Future.value(true);
        });
  }
}
