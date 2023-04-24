import 'package:flutter/material.dart';
import 'state.dart';
import 'package:json_form_builder/src/core/states/extends/block_states.dart';
import 'package:json_form_builder/src/core/states/extends/panel_states.dart';
import 'package:json_form_builder/src/core/states/extends/separator_states.dart';


class GlobalState extends ChangeNotifier {

  factory GlobalState() => instance;

  static final GlobalState instance = GlobalState._privateConstructor();
  GlobalState._privateConstructor();


  final BuilderState _state = BuilderState();


  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  late final PanelState _panelState = PanelState( state: _state );
  late final BlockState _blockState = BlockState( state: _state );
  late final SeparatorState _separatorState = SeparatorState( state: _state );


  final Map<String, List<Map<String, dynamic>>> _content = {
    "panels": [ ],
    "blocks": [ ],
    "separators": [ ],
  };


  List<Map<String, dynamic>> get panels => _content[ "panels" ]!;
  List<Map<String, dynamic>> get separators => _content[ "separators" ]!;


  List<Map<String, dynamic>> Function( int id ) get block => ( id ) => _content[ "blocks" ]?.where(( block ) => block[ "parent" ] == id ).toList() ?? [ ];

  List<Widget> Function( int id ) get blockWidgets => ( id ) => block( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();



  Future<void> init( Map<String, dynamic> data ) async {

    if ( _isInitialized ) return;


    _updateStates( );

    await _initStates( data );

    // await _collect( );

    _isInitialized = true;

  }


  void _updateStates( ) {

    _content[ "panels" ]?.clear();
    _content[ "blocks" ]?.clear();
    _content[ "separators" ]?.clear();

  }


  Future<void> _initStates( Map<String, dynamic> data ) async {

    _state.data = data[ "data" ];

    _content[ "panels" ]?.addAll( await _panelState.init() );

    _content[ "blocks" ]?.addAll( await _blockState.init() );

    _content[ "separators" ]?.addAll( await _separatorState.init() );

  }


}
