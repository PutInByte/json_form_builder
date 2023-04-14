
import 'package:flutter/material.dart';
import 'package:json_form_builder/src/utils/pager_config.dart';


class BuilderConfig {

  final PagerConfig pagerConfig;

  const BuilderConfig({
    this.pagerConfig = const PagerConfig(),
  });


  static BuilderConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BuilderConfigScope>()!.config;
  }

}


class BuilderConfigScope extends InheritedWidget {

  const BuilderConfigScope({ Key? key, required this.config, required Widget child }) : super(key: key, child: child);

  final BuilderConfig config;

  @override
  bool updateShouldNotify(BuilderConfigScope oldWidget) => false;

}
