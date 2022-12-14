import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/shared_files.dart';
import 'package:warehouse_user/helper/styles.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

import '../../helper/routes.dart';
import '../../widgets/heading_widget.dart';
import '../../widgets/large_Godown_widget.dart';

class GodownScreen extends StatelessWidget {
  const GodownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      smallScreen: Container(
        width: width(context),
        height: height(context),
        padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
        child: SingleChildScrollView(
          child: GetBuilder<WarehouseController>(
              init: WarehouseController(),
              id: "godown-page",
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: controller.selectedWarehouse.name ?? "",
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING,
                    ),
                    LargeGodownWidget(
                      godowns: controller.godowns,
                      warehouseModel: controller.selectedWarehouse,
                      selectedGodown: (index) {
                        controller.selectedGodown = index;
                        // print(jsonEncode(controller.selectedGodown));
                        Get.rootDelegate.toNamed(Routes.SENSOR_PAGE);
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
