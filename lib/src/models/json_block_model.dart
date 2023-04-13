
class JsonBlockModel {

  final int id;
  final String? type;
  final String name;
  final bool isSeparated;
  final String info;
  final items;


  const JsonBlockModel({
    required this.id,
    required this.type,
    required this.name,
    required this.isSeparated,
    required this.info,
    required this.items,
  });


  factory JsonBlockModel.fromJson(Map<String, dynamic> json) {
    return JsonBlockModel(
      id: json['id'],
      type: json['type'] ?? "",
      name: json['name'],
      isSeparated: json['isSeparated'],
      info: json['info'],
      items: json['items'],
    );
  }


}