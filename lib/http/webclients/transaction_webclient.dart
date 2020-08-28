import 'dart:convert';
import 'dart:io';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    debugPrint('chamou findAll');

    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    debugPrint('response.body: ${response.body}');
    List<dynamic> transactionJson = jsonDecode(response.body);
    List<Transaction> transacoes =
        transactionJson.map((e) => Transaction.fromJson(e)).toList();
    debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>');
    debugPrint(transacoes.toString());
    return transacoes;
  }

  Future<Transaction> save(Transaction transaction) async {
    var jsonTransaction = transaction.toJson();

    Response response = await client.post(baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          'password': '1000'
        },
        body: jsonTransaction);
    var respJson = jsonDecode(response.body);
    var transacaoRegistrada = Transaction.fromJson(respJson);
    return transacaoRegistrada;
  }
}
