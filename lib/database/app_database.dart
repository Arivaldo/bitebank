import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    debugPrint('Path do db: $path');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
      debugPrint('DB Criado com sucesso!');
    }, version: 1);
  });
}


Future<int> save(Contact contato) {
  return createDatabase().then((db) {
    final	Map<String,	dynamic>	contactMap	=	Map();
    contactMap['name'] = contato.name;
    contactMap['account_number'] = contato.accountNumber;
    return db.insert('contacts', contactMap);
  });
}

void findAll()  {

}
