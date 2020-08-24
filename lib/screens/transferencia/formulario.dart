import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  _FormularioTransferenciaState createState() =>
      _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  TextEditingController _controladorCampoNumeroConta;

  TextEditingController _controladorCampoValor;
  static const _rotuloNumeroConta = 'Número da Conta';
  static const	_rotuloCampoValor	=	'Valor';
  static const	_dicaCampoValor	=	'0.00';
  static const	_rotuloCampoNumeroConta	=	'Número	da	conta';
  static const	_dicaCampoNumeroConta	=	'0000';
  static const	_textoBotaoConfirmar	=	'Confirmar';
  String	_tituloAppBar	=	'Criando	transferência';

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
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: _rotuloNumeroConta,
                dica: _dicaCampoNumeroConta),
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

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final novaTrasnferencia = Transferencia(valor, numeroConta);
      debugPrint('Criando Transferência: $novaTrasnferencia');
      Navigator.pop(context, novaTrasnferencia);
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