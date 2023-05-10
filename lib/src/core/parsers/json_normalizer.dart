


class JsonNormalizer {

  JsonNormalizer({ required this.json });

  Map<String, dynamic> json;
  Map<String, dynamic> normalized = { };


  Map<String, dynamic> normalize() {

    json = json[ "data" ];

    _parsePanels();
    _parseBlocks();
    _parseSeparators();

    print(normalized);

    return normalized;
  }



  void _parsePanels() {

    normalized[ "panels" ] = [ ];

    for (int index = 0; index < json[ "view" ][ "panels"].length; index++ ) {

      normalized[ "panels" ].add(json[ "view" ][ "panels"][ index ]);

    }

  }



  Map<String, dynamic> _parseFields() {
    return { };
  }



  void _parseSeparators() {

    normalized[ "separators" ] = [ ];

    for (int index = 0; index < json[ "view" ][ "separators"].length; index++ ) {

      normalized[ "separators" ].add(json[ "view" ][ "separators"][ index ]);

    }

  }



  void _parseBlocks() {

    normalized[ "blocks" ] = [ ];

    for (int index = 0; index < json[ "view" ][ "blocks"].length; index++ ) {

      normalized[ "blocks" ].add(json[ "view" ][ "blocks"][ index ]);

    }


  }



}