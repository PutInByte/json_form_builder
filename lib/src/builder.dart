import 'package:flutter/material.dart';
import 'package:json_form_builder/src/models/json_model.dart';

import 'addons/model_generate_addon.dart';
import 'drawers/drawer.dart';

class JsonFormBuilder extends StatefulWidget {

  const JsonFormBuilder({ Key? key, required this.data }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<StatefulWidget> createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {


  Map<String, dynamic> get _data => widget.data;

  late final JsonModel _jsonModel;

  @override
  void initState() {
    super.initState();

    _jsonModel = ModelGenerateAddon(json: _data).generate();

  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return ContentDrawer(
      jsonModel: _jsonModel,
    );

  }






}
