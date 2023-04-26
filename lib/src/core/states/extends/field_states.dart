import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/core/states/base/state.dart';


class FieldState {

  final BuilderState _state;

  const FieldState({ required BuilderState state }) : _state = state;



  Future<void> init () async {

    final List<Map<String, dynamic>> fields = _state.jsonFields;

    final List<Map<String, dynamic>> parsedFields = [ ];


    for (int i = 0; i < fields.length; i++) {

      // List<Widget>? children = _state.separatorWidgets( blocks[ i ][ "id" ] as int );

      parsedFields.add(
        <String, dynamic>{
          "id": fields[ i ][ "id" ] as int,
          "parent": fields[ i ][ "dependId" ] as int,
          "hidden": false,
          "widget": PagerCardLayout( title: "$i", children: const [ ] ),
        },
      );


    }

    _state.fields = parsedFields;

  }






}


