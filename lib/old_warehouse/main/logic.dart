import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  GlobalKey globalKey = GlobalKey();
  Size? containerSize;
  Size stackSize = const Size(0, 0);
  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      var size = globalKey.currentContext!.size!;
      stackSize = size;
      update();
    });
    super.onInit();
  }
  // final controller = MapController(location: LatLng(21.9149, 78.0281), zoom: 5);
  //
  //
  //
  // bool darkMode = false;
  //
  // final markers = [
  //   LatLng(28.633893259957013, 77.15658411147837),
  // ];
  //
  // // void gotoDefault() {
  // //   controller.center = LatLng(35.68, 51.41);
  // //
  // //   update();
  // // }
  //
  // // void onDoubleTap() {
  // //   if (controller.zoom < 20.61111) {
  // //     controller.zoom += 0.5;
  // //     Get.log(controller.zoom.toString());
  // //   }
  // //   update();
  // // }
  //
  // // Offset? dragStart;
  // // double scaleStart = 1.0;
  //
  // // void onScaleStart(ScaleStartDetails details) {
  // //   dragStart = details.focalPoint;
  // //   scaleStart = 1.0;
  // // }
  //
  // Widget buildMarkerWidget(Offset pos, Color color, BuildContext context) {
  //   return Positioned(
  //     left: pos.dx - 16,
  //     top: pos.dy - 16,
  //     // width: 30,
  //     // height: 30,
  //     child: Bounce(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: appWhiteColor,
  //           borderRadius: BorderRadius.circular(
  //             getWidth(0.2, context),
  //           ),
  //           border: Border.all()
  //         ),
  //         padding: EdgeInsets.all(
  //           getWidth(0.2, context),
  //         ),
  //         child: Text("FCI Push Delhi",style: FSMResources.FSMTextStyle(context: context,color: appTextDarkColor,size: AppConfig.FONT_SIZE_H7),),
  //       ),
  //       onPressed: () {
  //         Get.toNamed(Routes.WAREHOUSE_LIST_PAGE);
  //       },
  //     ),
  //   );
  // }
  //
  // // void onScaleUpdate(ScaleUpdateDetails details) {
  // //   final scaleDiff = details.scale - scaleStart;
  // //   scaleStart = details.scale;
  // //
  // //   if (scaleDiff > 0) {
  // //     if (controller.zoom < 20.61111) {
  // //       controller.zoom += 0.5;
  // //       Get.log(controller.zoom.toString());
  // //     }
  // //     update();
  // //   } else if (scaleDiff < 0) {
  // //     controller.zoom -= 0.02;
  // //     // if(controller.zoom < 20.61111){
  // //     //   controller.zoom += 0.5;
  // //     Get.log(controller.zoom.toString());
  // //     // }
  // //     update();
  // //   } else {
  // //     final now = details.focalPoint;
  // //     final diff = now - dragStart!;
  // //     dragStart = now;
  // //     controller.drag(diff.dx, diff.dy);
  // //     update();
  // //   }
  // // }

}
