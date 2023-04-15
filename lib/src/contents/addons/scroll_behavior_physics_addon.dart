

import 'package:flutter/material.dart';

class NoBouncingScrollBehavior extends ScrollBehavior {

  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.macOS) {
      return const ClampingScrollPhysics();
    }
    return super.getScrollPhysics(context);
  }

}