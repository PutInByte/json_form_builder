


import 'package:json_form_builder/src/models/json_model.dart';

class ModelGenerateAddon {

  const ModelGenerateAddon({ required this.json }) : super();

  final Map<String, dynamic> json;

  JsonModel generate() => JsonModel.fromJson(json);

}