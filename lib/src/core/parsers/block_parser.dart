import 'package:flutter/cupertino.dart';
import 'package:json_form_builder/src/contents/components/pager_card_folder.dart';
import 'package:json_form_builder/src/core/parsers/parser_abstract.dart';
import 'package:json_form_builder/src/core/states/state.dart';


class BlockParser implements Parser {


  BlockParser({ required BuilderState state }): _state = state;

  late final BuilderState _state;


  @override
  Future<void> init () async {

    final List<Map<String, dynamic>> blocks = _state.jsonBlocks;
    final List<Map<String, dynamic>> parsedBlocks = [ ];


    for (int i = 0; i < blocks.length; i++) {


      List<Widget>? children = _state.separatorWidgets( blocks[ i ][ "id" ] as int );


      parsedBlocks.add(
        <String, dynamic>{
          "id": blocks[ i ][ "id" ] as int,
          "parent": blocks[ i ][ "dependId" ] as int,
          "hidden": children.isEmpty,
          "widget": PagerCardLayoutFolder( children: children ),
        },
      );


    }


    _state.blocks = parsedBlocks;

  }



}


