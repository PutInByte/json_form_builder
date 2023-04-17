

typedef ChangedEvent = void Function(int index);

typedef ServerSideEvent = Future<void> Function( );

typedef FetchApi = Future<Map<String, dynamic>> Function( );

typedef PostApi = Future<void> Function( Map<String, dynamic> data );
