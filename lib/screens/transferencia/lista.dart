import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario.dart';

class ListaTransferencia extends StatefulWidget {

  final TransactionWebClient _client = TransactionWebClient();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencia> {
  static const _tituloAppBar = 'Transactions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Transaction>>(
          future: widget._client.findAll(),
          //Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Progresso();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return CenteredMessage(
                  'Erro no Servidor',
                  icon: Icons.error,
                );
              }
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, indice) =>
                        ItemTransferencia(snapshot.data[indice]));
              } else {
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
              }
            }
            return Text('Unknown Error');
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormularioTransferencia()));
          future.then((tranferenciaRecebida) {
            debugPrint(
                'Transfarencia recebida no ListaTransferencias: $tranferenciaRecebida');
            if (tranferenciaRecebida != null) {
              setState(() {
                //
              });
            }
          });
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transaction _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.value.toString()),
      subtitle: Text(_transferencia.contact.accountNumber.toString()),
    ));
  }
}
