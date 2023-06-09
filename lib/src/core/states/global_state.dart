import 'package:flutter/material.dart';
import 'package:json_form_builder/src/core/parsers/block_parser.dart';
import 'package:json_form_builder/src/core/parsers/field_states.dart';
import 'package:json_form_builder/src/core/parsers/panel_parser.dart';
import 'package:json_form_builder/src/core/parsers/separator_states.dart';
import 'state.dart';


class GlobalState extends ChangeNotifier {

  final BuilderState _state = BuilderState();

  factory GlobalState() => instance;
  static final GlobalState instance = GlobalState._privateConstructor();

  GlobalState._privateConstructor();



  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;



  late final PanelParser _panelState = PanelParser( state: _state );

  late final BlockParser _blockState = BlockParser( state: _state );

  late final SeparatorParser _separatorState = SeparatorParser( state: _state );

  late final FieldParser _fieldState = FieldParser( state: _state );



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

    _state.data = data;

    await Future.wait([

      _fieldState.init(),

      _separatorState.init(),

      _blockState.init(),

      _panelState.init(),

    ]);

    _isInitialized = true;

  }



}
