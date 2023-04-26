import 'package:json_form_builder/src/core/states/base/state.dart';
import 'package:json_form_builder/src/dependencies/stepper/addons/stepper_step_addon.dart';

class PanelState {

  final BuilderState _state;

  const PanelState({ required BuilderState state }) : _state = state;


  Future<void> init () async {


    final List<Map<String, dynamic>> panels = _state.jsonPanels;
    final List<Map<String, dynamic>> parsedPanels = [ ];


    for (int index = 0; index < panels.length; index++) {


      List<Map<String, dynamic>> blocks = _state.jsonBlocksByPanel( panels[ index ][ "id" ] as int );


      parsedPanels.add({
        'id': panels[ index ][ "id" ],
        "hidden": blocks.isEmpty,
        "parent": null,
        'widget': StepperStep( title: panels[ index ][ "title" ] ),
      });


    }

    _state.panels = parsedPanels;

  }



}


