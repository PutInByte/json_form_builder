import 'package:json_form_builder/src/core/states/base/state.dart';

class SeparatorState {

  final BuilderState _state;

  SeparatorState({required BuilderState state}) : _state = state;


  final List<Map<String, dynamic>> _separator = [ ];

  List<Map<String, dynamic>> get separator => _separator;


  Future<List<Map<String, dynamic>>> init () async {


    return [];

  }


}


