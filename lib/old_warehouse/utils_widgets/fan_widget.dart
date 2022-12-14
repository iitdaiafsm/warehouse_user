import 'package:flutter/material.dart';

import '../utils/app_size.dart';

class FanWidgetPage extends StatefulWidget {
  bool shouldRotate = true;

  FanWidgetPage({Key? key, required this.shouldRotate}) : super(key: key);
  @override
  _FanWidgetPageState createState() => _FanWidgetPageState();
}

class _FanWidgetPageState extends State<FanWidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.shouldRotate) {
      animationController.stop();
    }
    return AnimatedBuilder(
      animation: animationController,
      child: Padding(
        padding: EdgeInsets.all(
          getWidth(0.5, context),
        ),
        child: Image.asset(
          "asset/fan_low.png",
          width: getWidth(3, context),
          height: getWidth(3, context),
          fit: BoxFit.contain,
        ),
      ),
      builder: (BuildContext? context, Widget? _widget) {
        return Transform.rotate(
          angle: animationController.value * 10,
          child: _widget,
        );
      },
    );
  }
}
