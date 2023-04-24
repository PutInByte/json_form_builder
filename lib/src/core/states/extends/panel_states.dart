import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/dependencies/stepper/addons/stepper_step_addon.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class PanelState {

  final State _state;

  PanelState({ required State state }) : _state = state;


  final List<Map<String, dynamic>> _panels = [ ];

  List<Map<String, dynamic>> get panels => _panels;



  Future<List<Map<String, dynamic>>> init () async {

    _panels.clear();


    for (int index = 0; index < _state.panels.length; index++) {

      _panels.add({
        'id': _state.panels[ index ][ "id" ],
        'index': index,
        'panel': BuilderModel.fromJson( _state.panels[ index ] ),
        'widget': StepperStep( title: _state.panels[ index ][ "title" ] )
      });

    }


    return _panels;

  }



}


