
class JsonBlockModel {

  final int id;
  final String type;
  final String title;
  final int order;
  final items;


  const JsonBlockModel({
    required this.id,
    required this.type,
    required this.title,
    required this.items,
    required this.order,
  });


  factory JsonBlockModel.fromJson(Map<String, dynamic> json) {
    return JsonBlockModel(
      id: json['id'],
      type: json['type'] ?? "seperator",
      title: json['title']  ?? "",
      order: json['order'],
      items: json['items'],
    );
  }


}