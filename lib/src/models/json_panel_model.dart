
class JsonPanelModel {


  final int id;
  final String type;
  final String name;
  final int order;
  final List<Map<String, dynamic>> blocks;


  const JsonPanelModel({
    required this.id,
    required this.type,
    required this.name,
    required this.order,
    required this.blocks,
  });


  factory JsonPanelModel.fromJson(Map<String, dynamic> json) {
    return JsonPanelModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      order: json['order'],
      blocks: (json['items'] as List).map<Map<String, dynamic>>((item) => item).toList(),
      // blocks: (json['items'] as List).map<JsonBlockModel>((item) => JsonBlockModel.fromJson(item)).toList(),
    );
  }


}