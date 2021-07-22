import 'dart:io';

import 'package:my_contacts/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static final int _version = 2;
  static final String _tableName = 'contacts';
  static final String _dbName = 'contacts.db';

  static final String _columnId = 'id';
  static final String _columnName = 'name';
  static final String _columnPhone = 'phoneNumber';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      Directory docDirectory = await getApplicationDocumentsDirectory();
      String _path = docDirectory.path + _dbName;

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnName TEXT, $_columnPhone TEXT, createdAt TEXT, updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Save Contact
  static Future<int> insert(Contact contact) async {
    try {
      var res = await _db.insert(_tableName, contact.toMap());
      print(res);
      return res;
    } catch (e) {
      return e;
    }
  }

  // Get Contacts
  static Future<List<Map<String, dynamic>>> getContacts() async {
    final res = await _db.query(
      _tableName,
    );
    return res;
  }

  // Search Contact
  static Future<List<Map<String, dynamic>>> searchContacts(
      String keyword) async {
    var res = await _db.query(_tableName,
        where: "name || phoneNumber LIKE ?", whereArgs: ["%$keyword%"]);
    return res;
  }

  //Update Contact
  static Future<int> update(Contact contact) async {
    return await _db.update(_tableName, contact.toMap(),
        where: '$_columnId = ?', whereArgs: [contact.id]);
  }

  // Delete Contact
  static Future<int> delete(int id) async {
    return await _db
        .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future close() async {
    return _db.close();
  }
}
