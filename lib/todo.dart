class Todo {
  int id;
  String description;
  String title;
  static const String TABLE_TODO = "todos";
  // static const String MAP_ID = "mapId";
  static const String MAP_TITLE = "mapTitle";
  static const String MAP_ID = "mapId";
  static const String MAP_DESCRIPTION = "mapDescription";
  static const String COL_ID = "id";
  static const String COL_NAME = "name";
  static const String COL_DESCRIPTION = "title";
  static const String CREATE_TABLE = '''CREATE TABLE $TABLE_TODO(
    $COL_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $COL_NAME TEXT,
    $COL_DESCRIPTION TEXT 
    )''';

  Todo({this.description, this.title, this.id});

  Map<String, dynamic> toMap() {
    return {
      // COL_ID: id,
      COL_NAME: title,
      COL_DESCRIPTION: description,
    };
  }
}
