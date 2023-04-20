import 'state.dart';
import 'package:flutter/foundation.dart';
import 'package:json_form_builder/src/core/states/extends/block_states.dart';
import 'package:json_form_builder/src/core/states/extends/panel_states.dart';
import 'package:json_form_builder/src/core/states/extends/separator_states.dart';


class GlobalState extends ChangeNotifier {


  static final GlobalState instance = GlobalState._privateConstructor();

  GlobalState._privateConstructor();

  factory GlobalState() => instance;


  final State _state = State();

  late final PanelState _panelState = PanelState(state: _state);
  late final BlockState _blockState = BlockState(state: _state);
  late final SeparatorState _separatorState = SeparatorState(state: _state);


  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  PanelState get panelState => _panelState;
  BlockState get blockState => _blockState;
  SeparatorState get separatorState => _separatorState;


  Future<void> init (Map<String, dynamic> value) async {

    if (_isInitialized) return;

    _state.data = value["data"];

    await Future.wait([
      _panelState.init(),
      _blockState.init(),
      _separatorState.init(),
    ]);


    _isInitialized = true;

  }


}
