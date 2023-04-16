import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'package:responsive_builder/responsive_builder.dart';

// class ThemeUtils {
//
//   static getContentIndents(BuildContext context, BuilderThemeConfig config) {
//   }
//
// }

extension ThemeUtils on BuilderThemeConfig {


  double getVerticalContentIndent (context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    switch (deviceScreenType) {
      case DeviceScreenType.tablet: return contentTBIndents;
      case DeviceScreenType.mobile: return contentMBIndents;
      default: return contentTBIndents;
    }

  }

  double getHorizontalContentIndent (context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    switch (deviceScreenType) {
      case DeviceScreenType.desktop: return contentDTIndents;
      case DeviceScreenType.tablet: return contentTBIndents;
      default: return contentMBIndents;
    }

  }

}
