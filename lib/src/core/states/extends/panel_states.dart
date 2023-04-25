import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/dependencies/stepper/addons/stepper_step_addon.dart';
import 'package:json_form_builder/src/models/builder_model.dart';

class PanelState {

  final BuilderState _state;

  PanelState({ required BuilderState state }) : _state = state;


  Future<void> init () async {

    final List<Map<String, dynamic>> panels = [ ];


    for (int index = 0; index < _state.panels.length; index++) {

        panels.add({
          'id': _state.panels[ index ][ "id" ],
          "hidden": _state.block( index ).isEmpty,
          'panel': BuilderModel.fromJson( _state.panels[ index ] ),
          'widget': StepperStep( title: _state.panels[ index ][ "title" ] ),
        });

    }

    _state.panels = panels;

  }



}


