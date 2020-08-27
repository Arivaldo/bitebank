import 'dart:convert';
import 'dart:io';
import 'package:bytebank/http/logging_inteceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

const baseUrl = 'http://pc.matrix.net:8080/transactions';

Future<List<Transaction>> findAll() async {
  debugPrint('chamou findAll');
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get(baseUrl)
      .timeout(Duration(seconds: 5));
  debugPrint('response.body: ${response.body}');
  List<dynamic> transactionJson = jsonDecode(response.body);
  List<Transaction> transacoes = transactionJson
      .map((e) => Transaction(
          value: e['value'],
          contact: Contact(
              name: e['contact']['name'],
              accountNumber: e['contact']['accountNumber'])))
      .toList();
  debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>');
  debugPrint(transacoes.toString());
  return transacoes;
}

Future<Transaction> save(Transaction transaction) {
  Client client =
  HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  client.post(baseUrl, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return null;
}
