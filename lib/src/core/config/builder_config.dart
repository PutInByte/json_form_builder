
import 'package:flutter/material.dart';
import 'event_config.dart';
import 'theme_config.dart';
import 'pager_config.dart';


class BuilderConfig extends ChangeNotifier {

  final PagerConfig pagerConfig;
  final EventConfig eventConfig;
  final ThemeConfig themeConfig;

  BuilderConfig({
    this.pagerConfig = const PagerConfig(),
    this.eventConfig = const EventConfig(),
    this.themeConfig = const ThemeConfig(),
  });

}
