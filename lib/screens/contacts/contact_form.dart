import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  TextEditingController _nameController;

  TextEditingController _accountController;

  final ContactDao _dao = ContactDao();

  @override
  void initState() {
    _nameController = TextEditingController();
    _accountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: 'Account Number'),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    String name = _nameController.text;
                    String account = _accountController.text;
                    if (name != null && account != null) {
                      final Contact novoContato = Contact(
                          name: name, accountNumber: int.tryParse(account));
                      _dao.save(novoContato).then((id) {
                        debugPrint('O id do elemento salvo: $id');
                        Navigator.pop(context, novoContato);
                      });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
