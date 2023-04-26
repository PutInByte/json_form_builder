import 'package:flutter/material.dart';
import 'package:json_form_builder/src/core/states/extends/field_states.dart';
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

  late final FieldState _fieldState = FieldState( state: _state );



  List<Map<String, dynamic>> get getPanels => _state.getPanels;

  List<Map<String, dynamic>> get getBlocks => _state.getBlocks;

  List<Map<String, dynamic>> get getSeparators => _state.getSeparators;

  List<Map<String, dynamic>> get getFields => _state.getFields;



  Map<String, dynamic> Function( int id ) get getOnePanel => ( id ) => _state.getOnePanel( id );

  Map<String, dynamic> Function( int id ) get getOneBlock => ( id ) => _state.getOneBlock( id );

  Map<String, dynamic> Function( int id ) get getOneSeparator => ( id ) => _state.getOneSeparator( id );

  Map<String, dynamic> Function( int id ) get getOneField => ( id ) => _state.getOneField( id );



  List<Map<String, dynamic>> Function( int id ) get getBlocksByPanel => ( id ) => _state.getBlocksByPanel( id );

  List<Map<String, dynamic>> Function( int id ) get getBlocksBySeparator => ( id ) => _state.getBlocksBySeparator( id );

  List<Map<String, dynamic>> Function( int id ) get getSeparatorsByBlock => ( id ) => _state.getSeparatorsByBlock( id );

  List<Map<String, dynamic>> Function( int id ) get getFieldsBySeparator => ( id ) => _state.getFieldsBySeparator( id );



  List<Widget> Function( int id ) get panelWidgets => ( id ) => _state.panelWidgets( id );

  List<Widget> Function( int id ) get separatorWidgets => ( id ) => _state.separatorWidgets( id );

  List<Widget> Function( int id ) get blockWidgets => ( id ) => _state.blockWidgets( id );

  List<Widget> Function( int id ) get fieldWidgets => ( id ) => _state.fieldWidgets( id );



  Future<void> init( Map<String, dynamic> data ) async {

    if ( _isInitialized ) return;

    _state.clear( );

    _state.data = data[ "data" ];

    await Future.wait([

      _fieldState.init(),

      _separatorState.init(),

      _blockState.init(),

      _panelState.init(),

    ]);

    _isInitialized = true;

  }



}
