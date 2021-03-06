
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final String _tituloAppBar = 'Dashboard';

  Route _createRoute(Widget destino) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destino,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween();
          return SlideTransition();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem(
                  'Tranfer',
                  Icons.monetization_on,
                  onClick: () {
                    _showContactList(context);
                  },
                ),
                _FeatureItem(
                  'Transaction Feed',
                  Icons.description,
                  onClick: () {
                    _showTransactionList(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showTransactionList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ListaTransferencia(),
    ),
  );
}

void _showContactList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ContactsList(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {@required this.onClick})
      : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  this.icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  this.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          onTap: () {
            onClick();
          },
        ),
      ),
    );
  }
}
