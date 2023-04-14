import 'package:flutter/material.dart';
import 'package:json_form_builder/src/dependencies/pager/pager_drawer.dart';

class ContentDrawer extends StatefulWidget {

  const ContentDrawer({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentDrawerState();
}

class _ContentDrawerState extends State<ContentDrawer> {

  @override
  Widget build(BuildContext context) {

    return const PagerDrawer();

  }


}
