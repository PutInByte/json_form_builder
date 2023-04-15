
import 'package:flutter/material.dart';
import 'builder_event_config.dart';
import 'pager_config.dart';


class BuilderConfig {

  final PagerConfig pagerConfig;
  final BuilderEventConfig eventConfig;

  const BuilderConfig({
    this.pagerConfig = const PagerConfig(),
    this.eventConfig = const BuilderEventConfig(),
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
