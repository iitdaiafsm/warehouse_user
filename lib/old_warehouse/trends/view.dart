import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../helper/routes.dart';
import '../utils/app_config.dart';
import '../utils/app_size.dart';
import '../utils/colors.dart';
import '../utils/fsm_resource.dart';
import '../utils_widgets/flutter_bounce.dart';
import 'logic.dart';

class TrendsPage extends StatelessWidget {
  TrendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<TrendsLogic>(
              init: TrendsLogic(),
              initState: (state) {
                state.controller?.getData(context);
              },
              didChangeDependencies: (state) {
                state.controller?.getData(context);
              },
              builder: (logic) {
                var smallList = logic.widgetsItem
                    .where((element) => element.isSmall)
                    .toList();
                var largeList = logic.widgetsItem
                    .where((element) => !element.isSmall)
                    .toList();

                Get.log("Big List Length : ${largeList.length}");
                Get.log("Small List Length : ${smallList.length}");
                return SizedBox(
                  width: width(context),
                  height: height(context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: width(context),
                          margin: EdgeInsets.all(
                              getWidth(AppConfig.DEFAULT_PADDING, context)),
                          decoration: BoxDecoration(
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                  color: appPrimaryColor,
                                  offset: const Offset(0, 0),
                                  blurRadius: getWidth(1, context))
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(getWidth(1, context)),
                              topRight: Radius.circular(getWidth(1, context)),
                            ),
                          ),
                          padding: EdgeInsets.all(getWidth(1, context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: getWidth(20, context),
                                alignment: Alignment.centerLeft,
                                child: Bounce(
                                  child: CircleAvatar(
                                    radius: getWidth(1.4, context),
                                    backgroundColor: appPrimaryColor,
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: getWidth(1.8, context),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.rootDelegate
                                        .backUntil(Routes.DASHBOARD_PAGE);
                                  },
                                ),
                              ),
                              Text(
                                "Trends",
                                style: FSMResources.FSMTextStyle(
                                  color: appPrimaryColor,
                                  size: AppConfig.FONT_SIZE_H1,
                                  type: TextStyleType.bold,
                                  context: context,
                                ),
                              ),
                              Container(
                                width: getWidth(20, context),
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Last : ",
                                      style: FSMResources.FSMTextStyle(
                                        context: context,
                                        size: AppConfig.FONT_SIZE_H6,
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: DropdownButton<DropDownPair>(
                                        value: logic.selectedDropDownPair,
                                        icon: Icon(
                                          Icons.arrow_downward_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        style: FSMResources.FSMTextStyle(
                                            context: context,
                                            color: appPrimaryColor,
                                            type: TextStyleType.bold),
                                        onChanged: (value) {
                                          logic.updateDropDownItem(
                                              value, context);
                                        },
                                        items: List.generate(
                                          logic.dropDownList.length,
                                          (index) =>
                                              DropdownMenuItem<DropDownPair>(
                                            value: logic.dropDownList[index],
                                            child: Text(
                                              logic.dropDownList[index].title,
                                              style: FSMResources.FSMTextStyle(
                                                context: context,
                                                size: AppConfig.FONT_SIZE_H6,
                                                color: appPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        logic.widgetsItem.isNotEmpty
                            ? Column(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: List.generate(
                                      largeList.length,
                                      (index) => Container(
                                        width:
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? width(context) * 0.31
                                                : width(context) * 0.48,
                                        margin: EdgeInsets.all(
                                            getWidth(0.5, context)),
                                        padding: EdgeInsets.all(
                                            getWidth(0.5, context)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            getWidth(1, context),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey,
                                              blurRadius:
                                                  getWidth(0.5, context),
                                            ),
                                          ],
                                        ),
                                        child: largeList[index].widget,
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: List.generate(
                                      smallList.length,
                                      (index) => Container(
                                        width:
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? width(context) * 0.31
                                                : width(context) * 0.48,
                                        margin: EdgeInsets.all(
                                            getWidth(0.5, context)),
                                        padding: EdgeInsets.all(
                                            getWidth(0.5, context)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            getWidth(1, context),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey,
                                              blurRadius:
                                                  getWidth(0.5, context),
                                            ),
                                          ],
                                        ),
                                        child: smallList[index].widget,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Lottie.asset("asset/loading.json",
                                    height: height(context) * 0.6),
                              ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      onWillPop: () async {
        Get.rootDelegate.backUntil(Routes.DASHBOARD_PAGE);
        return Future.value(true);
      },
    );
  }
}
