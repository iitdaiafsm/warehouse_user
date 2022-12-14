import 'package:flutter/cupertino.dart';

import '../utils/app_size.dart';

class WheatWidget extends StatefulWidget {
  final int crossAxisCount;
  final int numberOfRows;
  final Size size;

  const WheatWidget(
      {Key? key,
      required this.crossAxisCount,
      required this.numberOfRows,
      required this.size})
      : super(key: key);

  @override
  State<WheatWidget> createState() => _WheatWidgetState();
}

class _WheatWidgetState extends State<WheatWidget> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   // alignment: Alignment.center,
    //   // color: appPrimaryColor,
    //   margin: EdgeInsets.symmetric(
    //       vertical:
    //           getRelativeSize(widget.size.height, 2),
    //       horizontal:
    //           getRelativeSize(widget.size.width, 3.5)),
    //   child: GridView.count(
    //     physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     crossAxisCount: widget.crossAxisCount,
    //     // crossAxisSpacing:
    //     //     getRelativeSize(widget.size.width, getWidth(0.6, context)),
    //     // mainAxisSpacing:
    //     //     getRelativeSize(widget.size.height, getHeight(0.6, context)),
    //     childAspectRatio:
    //         getRelativeSize(widget.size.width, 100) /
    //             getRelativeSize(widget.size.height, 100),
    //     children: List.generate(
    //       widget.numberOfRows * widget.crossAxisCount,
    //       (index) => Container(
    //         child: Image.asset(
    //           "asset/Grain.png",
    //         ),
    //         // color: appPrimaryColor,
    //       ),
    //     ),
    //   ),
    // );
    // return Wrap(
    //
    //   children: List.generate(widget.crossAxisCount, (index) => Image.asset("asset/grain_image.png")),
    // );
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getRelativeSize(widget.size.height, 4),
          horizontal: getRelativeSize(widget.size.width, 3.5)),
      child: Column(
        children: List.generate(
          widget.numberOfRows,
          (index) => Expanded(
              child: Row(
            children: List.generate(
              widget.crossAxisCount,
              (index) => Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getRelativeSize(widget.size.height, 10),
                      horizontal: getRelativeSize(widget.size.width, 10)),
                  // decoration: BoxDecoration(border: Border.all(),),
                  child: Image.asset("asset/Grain.png"),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
