

import 'package:flutter/material.dart';

class BuilderState {


  BuilderState({ this.data = const { } });


  Map<String, dynamic> data;


  List<Map<String, dynamic>> get jsonPanels => data[ "panels" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get jsonBlocks => data[ "blocks" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get jsonSeparators => data[ "separators" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get jsonFields => data[ "fields" ] ?? <Map<String, dynamic>>[ ];



  List<Map<String, dynamic>> Function( int id ) get jsonBlocksByPanel => ( int id ) => jsonBlocks.where( ( block ) => block[ "dependId" ] == id ).toList();

  List<Map<String, dynamic>> Function( int id ) get jsonSeparatorsByBLock => ( int id ) => jsonSeparators.where( ( separator ) => separator[ "dependId" ] == id ).toList();

  List<Map<String, dynamic>> Function( int id ) get jsonFieldsBySeparator => ( int id ) => jsonFields.where( ( field ) => field[ "dependId" ] == id ).toList();




  /// Set the data.

  set panels( List<Map<String, dynamic>> data ) {
    _content[ "panels" ]?.clear();
    _content[ "panels" ]?.addAll(data);
  }

  set blocks( List<Map<String, dynamic>> data ) {
    _content[ "blocks" ]?.clear();
    _content[ "blocks" ]?.addAll(data);
  }

  set separators( List<Map<String, dynamic>> data ) {
    _content[ "separators" ]?.clear();
    _content[ "separators" ]?.addAll(data);
  }

  set fields( List<Map<String, dynamic>> data ) {
    _content[ "fields" ]?.clear();
    _content[ "fields" ]?.addAll(data);
  }


  /// Returns a full list of data.

  List<Map<String, dynamic>> get getPanels => _panels.where( ( panel ) => !panel[ "hidden" ] ).toList();

  List<Map<String, dynamic>> get getBlocks => _blocks.where( ( block ) => !block[ "hidden" ] ).toList();

  List<Map<String, dynamic>> get getSeparators => _separators.where( ( sep ) => !sep[ "hidden" ] ).toList();

  List<Map<String, dynamic>> get getFields => _fields.where( ( field ) => !field[ "hidden" ] ).toList();



  /// Returns a single panel for the given one data id.

  Map<String, dynamic> Function( int id ) get getOnePanel => ( id ) => _panels.firstWhere( ( panel ) => panel[ "id" ] == id );

  Map<String, dynamic> Function( int id ) get getOneBlock => ( id ) => _blocks.firstWhere( ( block ) => block[ "id" ] == id );

  Map<String, dynamic> Function( int id ) get getOneSeparator => ( id ) => _blocks.firstWhere( ( sep ) => sep[ "id" ] == id );

  Map<String, dynamic> Function( int id ) get getOneField => ( id ) => _blocks.firstWhere( ( field ) => field[ "id" ] == id );



  /// Returns a list of blocks for the given all data id.

  List<Map<String, dynamic>> Function( int id ) get getBlocksByPanel => ( id ) => _blocks.where( ( block ) => block[ "parent" ] == id && !block[ "hidden" ] ).toList();

  List<Map<String, dynamic>> Function( int id ) get getSeparatorsByBlock => ( id ) => _separators.where( ( sep ) => sep[ "parent" ] == id && !sep[ "hidden" ]).toList();

  List<Map<String, dynamic>> Function( int id ) get getBlocksBySeparator => ( id ) => _blocks.where( ( block ) => block[ "parent" ] == id && !block[ "hidden" ] ).toList();

  List<Map<String, dynamic>> Function( int id ) get getFieldsBySeparator => ( id ) => _fields.where( ( field ) => field[ "parent" ] == id && !field[ "hidden" ] ).toList();



  /// Returns a list of widgets for the given widgets id.

  List<Widget> Function( int id ) get panelWidgets => ( id ) => getBlocksByPanel( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();

  List<Widget> Function( int id ) get separatorWidgets => ( id ) => getSeparatorsByBlock( id ).map<Widget>(( sep ) => sep[ "widget" ] ).toList();

  List<Widget> Function( int id ) get blockWidgets => ( id ) => getBlocksByPanel( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();

  List<Widget> Function( int id ) get fieldWidgets => ( id ) => getFieldsBySeparator( id ).map<Widget>(( field ) => field[ "widget" ] ).toList();




  List<Map<String, dynamic>> get _panels => _content[ "panels" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get _blocks => _content[ "blocks" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get _separators => _content[ "separators" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get _fields => _content[ "fields" ] ?? <Map<String, dynamic>>[ ];


  final Map<String, List<Map<String, dynamic>>> _content = {
    "panels": [ ],
    "blocks": [ ],
    "separators": [ ],
    "fields": [ ],
  };


  void clear( ) async {

    // data.clear();

    _content[ "panels" ]?.clear();

    _content[ "blocks" ]?.clear();

    _content[ "separators" ]?.clear();

    _content[ "fields" ]?.clear();

  }


}
