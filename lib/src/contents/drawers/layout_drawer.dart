import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/addons/improve_scrolling_addon.dart';
import 'package:json_form_builder/src/contents/layouts/content_layout.dart';

class LayoutDrawer extends StatefulWidget {

  const LayoutDrawer({ Key? key, required this.children }) : super(key: key);

  final List<Widget> children;

  @override
  State<StatefulWidget> createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer> {

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return ImproveScrollAddon(
      scrollController: ScrollController(),
      child: ContentLayout(
        children: widget.children,
      )
    );


  }




}
