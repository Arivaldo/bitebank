import 'dart:convert';
import 'dart:io';
import 'package:bytebank/http/logging_inteceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

const baseUrl = 'http://pc.matrix.net:8080/transactions';

final Client client =
HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

