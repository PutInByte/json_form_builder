

class BuilderState {

  BuilderState({ this.data = const [] });

  List<Map<String, dynamic>> data;

  List<Map<String, dynamic>> get panels => data;

  List<Map<String, dynamic>> Function(int index) get block => (index) {


    print( data[ index ][ "items" ] );


    return data[ index ][ "items" ] ?? [ ];
  };

}
