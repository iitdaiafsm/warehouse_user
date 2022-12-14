import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:warehouse_user/helper/responsive_widget.dart';
import 'package:warehouse_user/helper/routes.dart';

import '../helper/shared_files.dart';
import '../helper/styles.dart';
import '../screens/warehouse/controller.dart';
import 'dark_divider.dart';
import 'expand_section.dart';
import 'flutter_bounce.dart';

class WarehouseListWidget extends StatelessWidget {
  final WarehouseController controller;

  const WarehouseListWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.3,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppMethods.DEFAULT_PADDING * 2),
          topRight: Radius.circular(width(context) > height(context)
              ? 0
              : AppMethods.DEFAULT_PADDING * 2),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppMethods.DEFAULT_PADDING * 2),
                topRight: Radius.circular(width(context) > height(context)
                    ? 0
                    : AppMethods.DEFAULT_PADDING * 2),
                bottomRight: Radius.circular(width(context) > height(context)
                    ? AppMethods.DEFAULT_PADDING * 2
                    : 0),
                bottomLeft: const Radius.circular(0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: AppMethods.DEFAULT_PADDING * 2,
            ),
            alignment: Alignment.center,
            child: Text(
              "Warehouses",
              style: textStyle(
                context: context,
                color: Theme.of(context).cardColor,
                isBold: true,
                fontSize: FontSize.H3,
              ),
            ),
          ),
          Expanded(
            child: controller.warehouses.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: AppMethods.DEFAULT_PADDING),
                    child: FittedBox(
                      child: Column(
                        children: [
                          Image.asset(
                            "asset/empty-warehouse.png",
                          ),
                          Text(
                            "No Warehouse Found",
                            style: textStyle(
                              context: context,
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Theme.of(context).focusColor,
                    width: width(context),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          controller.mapList.keys.length,
                          (index) => Column(
                            children: [
                              Bounce(
                                onPressed: () {
                                  controller.expand(index);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      AppMethods.DEFAULT_PADDING),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.mapList.keys.toList()[index]} (${controller.mapList[controller.mapList.keys.toList()[index]]?.length ?? 0})    ",
                                            style: textStyle(
                                              context: context,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              isBold: true,
                                            ),
                                          ),
                                          if (controller.warehouses
                                              .where((element) =>
                                                  element.state ==
                                                      controller.mapList.keys
                                                          .toList()[index] &&
                                                  (element.haveAlert != null &&
                                                      element.haveAlert!))
                                              .isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red[800],
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 2),
                                              child: Text(
                                                "Alert",
                                                style: textStyle(
                                                  context: context,
                                                  color: Colors.white,
                                                  isBold: true,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      FaIcon(
                                        controller.expandedIndex == index
                                            ? FontAwesomeIcons.chevronUp
                                            : FontAwesomeIcons.chevronDown,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ExpandedSection(
                                expand: controller.expandedIndex == index,
                                child: Column(
                                  children: List.generate(
                                    controller
                                            .mapList[controller.mapList.keys
                                                .toList()[index]]
                                            ?.length ??
                                        0,
                                    (indexInner) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Bounce(
                                          onPressed: () {
                                            controller.selectedWarehouse =
                                                controller.mapList[controller
                                                        .mapList.keys
                                                        .toList()[index]]![
                                                    indexInner];
                                            /*print(jsonEncode(
                                                controller.selectedWarehouse));*/
                                            // Get.toNamed(Routes.GODOWN_PAGE);
                                            if (controller
                                                    .selectedWarehouse.id ==
                                                "80") {
                                              Get.rootDelegate.toNamed(
                                                  Routes.WAREHOUSE_LIST_PAGE);
                                            } else {
                                              Get.rootDelegate
                                                  .toNamed(Routes.GODOWN_PAGE);
                                            }
                                          },
                                          child: Container(
                                            color: Theme.of(context).cardColor,
                                            width: width(context),
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppMethods.DEFAULT_PADDING *
                                                      2,
                                              vertical:
                                                  AppMethods.DEFAULT_PADDING,
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "asset/warehouse_icon.png",
                                                  height: 35,
                                                ),
                                                SizedBox(
                                                  width: AppMethods
                                                      .DEFAULT_PADDING,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${controller.mapList[controller.mapList.keys.toList()[index]]![indexInner].name}     ",
                                                            style: textStyle(
                                                              context: context,
                                                              isBold: true,
                                                              fontSize:
                                                                  FontSize.H5,
                                                            ),
                                                          ),
                                                          if (controller
                                                                  .mapList[
                                                                      controller
                                                                          .mapList
                                                                          .keys
                                                                          .toList()[index]]![
                                                                      indexInner]
                                                                  .haveAlert ??
                                                              false)
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .red[800],
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                              child: Text(
                                                                "Alert",
                                                                style:
                                                                    textStyle(
                                                                  context:
                                                                      context,
                                                                  color: Colors
                                                                      .white,
                                                                  isBold: true,
                                                                  fontSize:
                                                                      FontSize
                                                                          .H6,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "${controller.mapList[controller.mapList.keys.toList()[index]]![indexInner].city}",
                                                        style: textStyle(
                                                          context: context,
                                                          fontSize: FontSize.H6,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.chevronRight,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (indexInner !=
                                            (controller
                                                        .mapList[controller
                                                            .mapList.keys
                                                            .toList()[index]]
                                                        ?.length ??
                                                    0) -
                                                1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppMethods.DEFAULT_PADDING,
                                            ),
                                            child: const DividerWidget(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (index != controller.mapList.keys.length)
                                DividerWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
