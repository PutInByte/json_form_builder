import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class PanelState {

  final State _state;

  PanelState({ required State state }) : _state = state;

  final List<BuilderModel> _panels = [ ];

  List<BuilderModel> get panels => _panels;



  Future<void> init () async {


    for (int index = 0; index < _state.panels.length; index++) {

      _panels.add(BuilderModel.fromJson(_state.panels[index]));

    }

  }



}


