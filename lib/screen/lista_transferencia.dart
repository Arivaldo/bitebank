import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario_transferencia.dart';

class ListaTransferencia extends StatefulWidget {
  final List _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferências')),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) =>
              ItemTransferencia(widget._transferencias[indice])),
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
                widget._transferencias.add(tranferenciaRecebida);
              });
            }
          });
        },
      ),
    );
  }
}


class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        ));
  }
}