import 'package:bytebank/components/editor.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {

  final Contact contact;
  final TransactionWebClient _client = TransactionWebClient();

  FormularioTransferencia({this.contact});

  @override
  _FormularioTransferenciaState createState() =>
      _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {

  TextEditingController _controladorCampoNumeroConta;
  TextEditingController _controladorCampoValor;
  static const _rotuloNumeroConta = 'Número da Conta';
  static const _rotuloCampoValor = 'Valor';
  static const _dicaCampoValor = '0.00';
  static const _dicaCampoNumeroConta = '0000';
  static const _textoBotaoConfirmar = 'Confirmar';
  String _tituloAppBar = 'Criando	transferência';

  @override
  void initState() {
    _controladorCampoNumeroConta = TextEditingController();
    _controladorCampoValor = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.contact.name,
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.contact.accountNumber.toString(),
                style: TextStyle(fontSize: 32.0),
              ),
            ),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                dica: _dicaCampoValor,
                icone: Icons.monetization_on),
            RaisedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) async{
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (valor != null && widget.contact != null) {
      var novaTrasnferencia =
          Transaction(value: valor, contact: widget.contact);
      debugPrint('Criando Transferência: $novaTrasnferencia');
      novaTrasnferencia = await widget._client.save(novaTrasnferencia);
      Navigator.pop(context, novaTrasnferencia);
    } else {
      var snackBar = SnackBar(
        content: Text('Valores Inválidos!'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    debugPrint('$this chamou o dispose');
    _controladorCampoNumeroConta.dispose();
    _controladorCampoValor.dispose();
    super.dispose();
  }
}
