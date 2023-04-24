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



  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;


  late final PanelState _panelState = PanelState(state: _state);
  late final BlockState _blockState = BlockState(state: _state);
  late final SeparatorState _separatorState = SeparatorState(state: _state);

  final List<Map<String, dynamic>> _panels = [ ];
  final List<Map<String, dynamic>> _blocks = [ ];
  final List<Map<String, dynamic>> _separators = [ ];


  PanelState get panelState => _panelState;
  BlockState get blockState => _blockState;
  SeparatorState get separatorState => _separatorState;

  List<Map<String, dynamic>> get panels => _panels;
  List<Map<String, dynamic>> get blocks => _blocks;
  List<Map<String, dynamic>> get separators => _separators;





  Future<void> init( Map<String, dynamic> data ) async {

    if (_isInitialized) return;

    _updateStates(data);

    await _initStates();


    _isInitialized = true;

  }



  Future<void> _updateStates( Map<String, dynamic> data ) async {
    _state.data = data[ "data" ];

    _panels.clear();
    _blocks.clear();
    _separators.clear();

  }


  Future<void> _initStates() async {
    _panels.addAll( await _panelState.init() );
    _blocks.addAll( await _blockState.init() );
    _separators.addAll( await _separatorState.init() );
  }

}
