import 'package:flutter/material.dart';

import '../helper/styles.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width(context),
      color: Theme.of(context).shadowColor,
    );
  }
}
