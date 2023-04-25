import 'package:json_form_builder/src/core/states/base/state.dart';


class SeparatorState {

  final BuilderState _state;

  SeparatorState({required BuilderState state}) : _state = state;



  Future<void> init () async {

    final List<Map<String, dynamic>> panels = _state.getPanels;
    final List<Map<String, dynamic>> blocks = _state.getBlocks;
    final List<Map<String, dynamic>> separators = [ ];


    // for (int j = 0; j < blocks.length; j++)  {
    //
    //   _blocks.add({
    //     "id": blocks[ j ][ "id" ],
    //     "parent": _state.panels[ i ][ "id" ],
    //     "hidden": _state.block( i ).isEmpty,
    //     "block": BuilderModel.fromJson( blocks[ j ] ),
    //     "widget": PagerCardLayout( title: "title $j", children: const [ ] ),
    //   });
    //
    // }



    _state.separators = separators;


  }


}


