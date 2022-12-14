import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_user/old_warehouse/utils/app_config.dart';
import 'package:warehouse_user/old_warehouse/utils/app_size.dart';
import 'package:warehouse_user/old_warehouse/utils/colors.dart';
import 'package:warehouse_user/old_warehouse/utils/fsm_resource.dart';
import 'package:warehouse_user/old_warehouse/utils_widgets/flutter_bounce.dart';
import 'package:webviewx/webviewx.dart';

import '../../helper/routes.dart';
import 'logic.dart';

class StreamPage extends StatelessWidget {
  StreamPage({Key? key}) : super(key: key);

  final logic = Get.put(StreamLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
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
                      Bounce(
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
                            Get.rootDelegate.backUntil(Routes.DASHBOARD_PAGE);
                          }),
                      Text(
                        "Stream Pusa FCI",
                        style: FSMResources.FSMTextStyle(
                          color: appPrimaryColor,
                          size: AppConfig.FONT_SIZE_H1,
                          type: TextStyleType.bold,
                          context: context,
                        ),
                      ),
                      Opacity(
                        opacity: 0,
                        child: Bounce(
                            child: CircleAvatar(
                              radius: getWidth(1.4, context),
                              backgroundColor: appPrimaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: getWidth(1.8, context),
                                ),
                              ),
                            ),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: WebViewX(
                    initialContent: ''''<body>	
                  <p style="text-align: center; font: medium;color: blueviolet;"><strong><u>CCTV CAMERA CTO-Pusa</u></strong></p>

                  <iframe width="640" height="480" src="https://rtsp.me/embed/4n9e4DRd/" frameborder="0" allowfullscreen=""></iframe>
	    <iframe width="640" height="480" src="https://rtsp.me/embed/DHikQ6sf/" frameborder="0" allowfullscreen=""></iframe>
	    <iframe width="640" height="480" src="https://rtsp.me/embed/tEddtnsf/" frameborder="0" allowfullscreen=""></iframe>
 	    <iframe width="640" height="480" src="https://rtsp.me/embed/fRrsQAbr/" frameborder="0" allowfullscreen=""></iframe>
	    <iframe width="640" height="480" src="https://rtsp.me/embed/NBffQYiZ/" frameborder="0" allowfullscreen=""></iframe>
	    <iframe width="640" height="480" src="https://rtsp.me/embed/E77nGS4A/" frameborder="0" allowfullscreen=""></iframe>
                  <iframe width="640" height="480" src="https://rtsp.me/embed/inKanabS/" frameborder="0" allowfullscreen=""></iframe>
                  <iframe width="640" height="480" src="https://rtsp.me/embed/ni2GsESR/" frameborder="0" allowfullscreen=""></iframe>
                  <iframe width="640" height="480" src="https://rtsp.me/embed/eaSBheSZ/" frameborder="0" allowfullscreen=""></iframe>
                  <iframe width="640" height="480" src="https://rtsp.me/embed/DRBEk5Dh/" frameborder="0" allowfullscreen=""></iframe>
                  <iframe width="640" height="480" src="https://rtsp.me/embed/yniz7f3z/" frameborder="0" allowfullscreen=""></iframe>
	    <iframe width="640" height="480" src="https://rtsp.me/embed/yaf9YyiT/" frameborder="0" allowfullscreen=""></iframe>





</body>''',
                    initialSourceType: SourceType.html,
                    height: height(context),
                    width: width(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          Get.rootDelegate.backUntil(Routes.DASHBOARD_PAGE);
          return Future.value(true);
        });
  }
}
