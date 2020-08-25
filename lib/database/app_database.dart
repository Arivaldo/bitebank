import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  debugPrint('Path do db: $path');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tableContactSql);
    debugPrint('DB Criado com sucesso!');
  }, version: 1);
}

