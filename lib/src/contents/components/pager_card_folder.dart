import 'package:flutter/material.dart';

class PagerCardLayoutFolder extends StatelessWidget {

  const PagerCardLayoutFolder({ Key? key, required this.children }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    // DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);
    // final double size = (deviceScreenType == DeviceScreenType.mobile) ? 16.0 : 32.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );

  }
}
