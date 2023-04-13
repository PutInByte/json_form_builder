import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CardGridBuilder extends StatelessWidget {

  const CardGridBuilder({Key? key, required this.children }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    bool isDesktop = deviceScreenType == DeviceScreenType.desktop;
    bool isTablet = deviceScreenType == DeviceScreenType.tablet;

    return ResponsiveGridList(
      verticalGridMargin: isDesktop ? 32 : isTablet ? 16 : 12,
      horizontalGridSpacing: isDesktop ? 64 : isTablet ? 32 : 20,
      verticalGridSpacing: isDesktop ? 64 : isTablet ? 32 : 12,
      minItemWidth: 440,
      minItemsPerRow: isDesktop ? 1 : isTablet ? 2 : 1,
      listViewBuilderOptions: ListViewBuilderOptions(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true),
      children: children,
    );
  }
}
