import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/contents/components/pager_empty_card_layout.dart';
import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class BlockState {

  final BuilderState _state;

  BlockState({ required BuilderState state }) : _state = state;





  Future<void> init () async {

    final List<Map<String, dynamic>> panels = _state.getPanels;
    final List<Map<String, dynamic>> blocks = [ ];


    for (int i = 0; i < panels.length; i++) {


      List<Map<String, dynamic>>? blocksByPanel = _state.block( i );


      if (blocksByPanel.isEmpty) {

          blocks.add(
            <String, dynamic>{
              'hidden': true,
              'parent': panels[ i ][ "id" ],
              'widget': const PagerEmptyCardLayout( ),
            },
          );

          continue;
        }


      for (int j = 0; j < blocks.length; j++)  {


        blocks.add(
            <String, dynamic>{
              "id": blocksByPanel[ j ][ "id" ] as int,
              "parent": blocksByPanel[ i ][ "id" ] as int,
              "hidden": blocks.isEmpty,
              "widget": PagerCardLayout( title: "title $j", children: const [ ] ),
            },
        );

      }


    }


    _state.blocks = blocks;

  }






}


