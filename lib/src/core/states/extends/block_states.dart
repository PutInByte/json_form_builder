import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class BlockState {

  final State _state;

  BlockState({ required State state }) : _state = state;


  final List<Map<String, dynamic>> _blocks = [ ];

  List<Map<String, dynamic>> get blocks => _blocks;


  Future<List<Map<String, dynamic>>> init () async {

    _blocks.clear();

    for (int index = 0; index < _state.panels.length; index++) {

      _blocks.add({
        'index': index,
        'blocks': _state.block(index).map((e) => BuilderModel.fromJson(e)).toList(),
      });

    }

    return _blocks;

  }


}


