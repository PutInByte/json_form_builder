import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/drawers/layout_drawer.dart';
import 'package:json_form_builder/src/contents/drawers/panel_drawer.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/models/json_model.dart';
import 'package:provider/provider.dart';
import 'contents/drawers/content_drawer.dart';
import 'contents/drawers/navigation_drawer.dart';

class JsonFormBuilder extends StatefulWidget {

  const JsonFormBuilder({ Key? key, required this.data }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<StatefulWidget> createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {


  late final JsonFormController controller;

  late final JsonModel _jsonModel;


  @override
  void initState() {
    super.initState();

    _jsonModel = JsonModel.fromJson( widget.data );
    controller = JsonFormController( data: _jsonModel );

  }


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => controller,
      child: const LayoutDrawer(
        navigatorDrawer: NavigatorDrawer(),
        contentDrawer: ContentDrawer(),
        panelDrawer: PanelDrawer(),
      ),
    );

  }


}
