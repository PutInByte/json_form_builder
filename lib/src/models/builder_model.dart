
class BuilderModel {

  final int id;
  final int? order;
  final int colSpan;
  final int itemOrder;
  final int version;
  final String type;
  final String title;
  final bool isSeparated;
  final List<dynamic> conditionFields;
  final List<dynamic> conditionValues;


  const BuilderModel({
    required this.id,
    this.order,
    required this.colSpan,
    required this.itemOrder,
    required this.type,
    required this.title,
    required this.version,
    required this.isSeparated,
    required this.conditionFields,
    required this.conditionValues,
  });


  factory BuilderModel.fromJson(Map<String, dynamic> json) {
    return BuilderModel(
      id: json["id"],
      order: json["order"] ?? 0,
      colSpan: json["colSpan"],
      itemOrder: json["itemOrder"],
      type: json["type"],
      title: json["title"] ?? "",
      version: json["version"],
      isSeparated: json["isSeparated"],
      conditionFields: json["conditionFields"] ?? [],
      conditionValues: json["conditionValues"] ?? [],
    );
  }


}