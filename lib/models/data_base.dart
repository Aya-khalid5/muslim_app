import 'package:sqflite/sqflite.dart';

Database? database;

create_database() async {
  database = await openDatabase("my_db.db", version: 1,
      onCreate: (Database db, int version) {
    db
        .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, time TEXT,date TEXT)')
        .then((onValue) {
      print("created table");
    });
  }, onOpen: (Database db) {
    print("database open");
    get_database(db);
  });
}

insert_database() {
  database?.rawInsert("INSERT INTO tasks ( title TEXT, time TEXT,date TEXT)");
}

get_database(Database db) {
  db.rawQuery("SELECT * FROM tasks").then((onValue) {});
}
