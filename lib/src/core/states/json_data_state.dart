import 'package:flutter/cupertino.dart';
import 'package:json_form_builder/src/models/json_block_model.dart';
import 'package:json_form_builder/src/models/json_panel_model.dart';

class JsonDataState extends ChangeNotifier {


  JsonDataState( { Key? key, required this.data });


  final Map<String, dynamic> data;
  final List<JsonPanelModel> panels = [];
  final List<JsonBlockModel> blocks = [];


  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;


  Future<void> init () async {

    if (_isInitialized) return;

    // await Future.delayed(const Duration(seconds: 3));

    panels.addAll((data['data'] as List).map<JsonPanelModel>((panel) => JsonPanelModel.fromJson(panel)).toList());

    // blocks.addAll(panels.map((e) => e.blocks.map((e) => JsonBlockModel.fromJson(e)).toList()));

    _isInitialized = true;

  }



}


