import 'package:json_form_builder/src/core/parsers/parser_abstract.dart';
import 'package:json_form_builder/src/core/states/state.dart';
import 'package:json_field_builder/json_field_builder.dart';


class FieldParser implements Parser {


  FieldParser({ required BuilderState state }): _state = state;

  late final BuilderState _state;
  final FieldBuilder builder = FieldBuilder.instance;


  @override
  Future<void> init () async {

    final List<Map<String, dynamic>> fields = _state.jsonFields;

    final List<Map<String, dynamic>> parsedFields = [ ];


    for (int i = 0; i < fields.length; i++) {

      parsedFields.add(
        <String, dynamic>{
          "id": fields[ i ][ "id" ] as int,
          "parent": fields[ i ][ "separatorId" ] as int,
          "hidden": false,
          "widget": builder.build(data: fields[ i ]),
        },
      );


    }

    _state.fields = parsedFields;

  }



}


