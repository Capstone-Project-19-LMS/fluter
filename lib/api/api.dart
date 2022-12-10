import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';

const url = '13.213.47.36';

Future<http.Response> tryRegister(name, email, password) {
  Map data = {
    'name': name,
    'email': email,
    'password': password,
  };
  return http.post(
    Uri.http(url, 'customer/register'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}
