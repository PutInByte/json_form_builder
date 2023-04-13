import 'package:json_form_builder/src/models/json_panel_model.dart';

class JsonModel {

  final List<JsonPanelModel> panels;

  const JsonModel({
    required this.panels,
  });

  factory JsonModel.fromJson(Map<String, dynamic> json) {
    return JsonModel(
      panels: (json['data'] as List).map((e) => JsonPanelModel.fromJson(e)).toList(),
    );
  }


}