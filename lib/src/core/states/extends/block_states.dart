import 'package:json_form_builder/src/core/states/base/state.dart';

class BlockState {

  final State _state;

  const BlockState({ required State state }) : _state = state;


  Future<void> init () async {

    // await Future.delayed(const Duration(seconds: 3));

  }


}


