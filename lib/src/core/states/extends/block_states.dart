import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class BlockState {

  final BuilderState _state;

  BlockState({ required BuilderState state }) : _state = state;


  final List<Map<String, dynamic>> _blocks = [ ];

  List<Map<String, dynamic>> get blocks => _blocks;



  Future<List<Map<String, dynamic>>> init () async {

    _blocks.clear();

    print(_state.panels);

    for (int index = 0; index < _state.panels.length; index++) {

      List<Map<String, dynamic>> blocks = _state.block( index );

      for (int i = 0; i < blocks.length; i++)  {

          blocks.add({
            "id": blocks[ i ][ "id" ],
            'parent': _state.panels[ index ][ "id" ],
            "block": BuilderModel.fromJson( blocks[ i ] ),
            'widget': PagerCardLayout( title: "title $i", children: const [ ] ),
          });

      }

    }

    return _blocks;

  }






}


