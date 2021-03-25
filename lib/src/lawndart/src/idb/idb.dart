export 'package:idb_sqflite/idb_sqflite.dart';

export 'stub.dart'
    if (dart.library.html) 'web.dart'
    if (dart.library.io) 'io.dart';
