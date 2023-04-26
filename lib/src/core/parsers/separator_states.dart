import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/core/parsers/parser_abstract.dart';
import 'package:json_form_builder/src/core/states/state.dart';


class SeparatorParser implements Parser {


  SeparatorParser({ required BuilderState state }): _state = state;

  late final BuilderState _state;


  @override
  Future<void> init () async {

    final List<Map<String, dynamic>> separators = _state.jsonSeparators;
    final List<Map<String, dynamic>> parsedSeparators = [ ];


    for (int i = 0; i < separators.length; i++)  {

      List<Widget>? children = _state.fieldWidgets( separators[ i ][ "id" ] as int );

      parsedSeparators.add({
        "id": separators[ i ][ "id" ],
        "parent": separators[ i ][ "dependId" ],
        "hidden": children.isEmpty,
        "widget": PagerCardLayout( title: "title $i", children: children ),
      });

    }


    _state.separators = parsedSeparators;

  }


}


