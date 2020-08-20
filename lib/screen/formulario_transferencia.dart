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
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: 'Número da Conta',
                dica: '0000'),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: 'Valor',
                dica: '00.0',
                icone: Icons.monetization_on),
            RaisedButton(
              child: Text('Confirmar'),
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