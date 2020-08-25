import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {

  static final String tableContactSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contato);

    return db.insert('contacts', contactMap);
  }

  Map<String, dynamic> _toMap(Contact contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contato.name;
    contactMap['account_number'] = contato.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return _toList(maps);
  }

  List<Contact> _toList(List<Map<String, dynamic>> maps) {
    return maps
      .map((item) => Contact(
          id: item['id'],
          name: item['name'],
          accountNumber: item['account_number']))
      .toList();
  }
}
