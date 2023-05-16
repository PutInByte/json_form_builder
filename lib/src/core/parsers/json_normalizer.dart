


class JsonNormalizer {

  const JsonNormalizer();

  static Map<String, dynamic> normalize(Map<String, dynamic> json) {

    json = json[ "data" ];

    Map<String, dynamic> data = { };

    data[ "panels" ] = json[ "view" ][ "panels" ];
    data[ "separators" ] = json[ "view" ][ "separators" ];
    data[ "blocks" ] = json[ "view" ][ "blocks" ];
    data[ "fields" ] = _parseFields(json);

    return data;
  }

  static List<Map<String, dynamic>> _parseFields(Map<String, dynamic> json) {

    List<Map<String, dynamic>> data = [];

    List<Map<String, dynamic>> fields = json[ "view" ][ "fields" ];
    List<Map<String, dynamic>> fieldsData = json[ "fields" ];
    List<Map<String, dynamic>> fieldsDepend = json[ "depend" ];


    for (int i = 0; i < fields.length; i++ ) {

      for (int j = 0; j < fieldsData.length; j++ ) {

        if (fields[ i ][ "name" ] == fieldsData[ j ][ "name" ]) {

          data.add({ ...fields[ i ], ...fieldsData[ j ] });
          break;

        }

      }

    }


    for (int i = 0; i < fields.length; i++ ) {
      for (int j = 0; j < fieldsDepend.length; j++ ) {

        if (fields[ i ][ "name" ] == fieldsDepend[ j ][ "sourceFieldName" ]) {

          data.add({ ...fields[ i ], ...fieldsDepend[ j ] });

          break;

        }

      }
    }


    return data;

  }

}