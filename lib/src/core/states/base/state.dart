

import 'package:flutter/material.dart';

class BuilderState {

  BuilderState({ this.data = const [ ] });



  List<Map<String, dynamic>> data;

  List<Map<String, dynamic>> get panels => data;

  List<Map<String, dynamic>> Function(int index) get block => (index) => data[ index ][ "items" ].cast<Map<String, dynamic>>( ) ?? <Map<String, dynamic>>[ ];


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



  /// Returns a full list of data.

  List<Map<String, dynamic>> get getPanels => _panels.where( ( panel ) => !panel[ "hidden" ] ).toList();

  List<Map<String, dynamic>> get getBlocks => _blocks.where( ( block ) => !block[ "hidden" ] ).toList();

  List<Map<String, dynamic>> get getSeparators => _separators.where( ( sep ) => !sep[ "hidden" ] ).toList();



  /// Returns a single panel for the given one data id.

  Map<String, dynamic> Function( int id ) get getOnePanel => ( id ) => _panels.firstWhere( ( panel ) => panel[ "id" ] == id );

  Map<String, dynamic> Function( int id ) get getOneBlock => ( id ) => _blocks.firstWhere( ( block ) => block[ "id" ] == id );

  Map<String, dynamic> Function( int id ) get getOneSeparator => ( id ) => _blocks.firstWhere( ( sep ) => sep[ "id" ] == id );



  /// Returns a list of blocks for the given all data id.

  List<Map<String, dynamic>> Function( int id ) get getBlocksByPanel => ( id ) => _blocks.where( ( block ) => block[ "parent" ] == id && !block[ "hidden" ] ).toList();

  List<Map<String, dynamic>> Function( int id ) get getSeparatorsByPanel => ( id ) => _separators.where( ( sep ) => sep[ "parent" ] == id && !sep[ "hidden" ] ).toList();

  List<Map<String, dynamic>> Function( int id ) get getBlocksBySeparator => ( id ) => _blocks.where( ( block ) => block[ "parent" ] == id && !block[ "hidden" ] ).toList();



  /// Returns a list of widgets for the given widgets id.

  List<Widget> Function( int id ) get panelWidgets => ( id ) => getBlocksByPanel( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();

  List<Widget> Function( int id ) get separatorWidgets => ( id ) => getBlocksBySeparator( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();

  List<Widget> Function( int id ) get blockWidgets => ( id ) => getBlocksByPanel( id ).map<Widget>(( block ) => block[ "widget" ] ).toList();




  List<Map<String, dynamic>> get _panels => _content[ "panels" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get _blocks => _content[ "blocks" ] ?? <Map<String, dynamic>>[ ];

  List<Map<String, dynamic>> get _separators => _content[ "separators" ] ?? <Map<String, dynamic>>[ ];

  final Map<String, List<Map<String, dynamic>>> _content = {
    "panels": [ ],
    "blocks": [ ],
    "separators": [ ],
  };



  void clear( ) async {

    // data.clear();

    _content[ "panels" ]?.clear();

    _content[ "blocks" ]?.clear();

    _content[ "separators" ]?.clear();

  }


}
