import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/addons/improve_scrolling_addon.dart';
import 'package:json_form_builder/src/contents/drawers/panel_drawer.dart';
import '../addons/layout_addon.dart';
import 'content_drawer.dart';
import 'navigation_drawer.dart';

class LayoutDrawer extends StatefulWidget {

  const LayoutDrawer({
    Key? key,
    required this.contentDrawer,
    required this.panelDrawer,
    required this.navigatorDrawer
  }) : super(key: key);

  final ContentDrawer contentDrawer;
  final PanelDrawer panelDrawer;
  final NavigatorDrawer navigatorDrawer;

  @override
  State<StatefulWidget> createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer> {


  @override
  Widget build(BuildContext context) {

    return ImproveScrollAddon(
      scrollController: ScrollController(),
      child: LayoutAddon(
        navigatorDrawer: widget.navigatorDrawer,
        panelDrawer: widget.panelDrawer,
        contentDrawer: widget.contentDrawer,
      )
    );

  }


}
