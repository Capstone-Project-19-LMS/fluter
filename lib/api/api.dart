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

Future<http.Response> tryVerif(email, code) {
  Map data = {
    'email': email,
    'code': code,
  };
  return http.post(
    Uri.http(url, 'customer/verifikasi'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}

Future<http.Response> tryLogin(email, password) {
  Map data = {
    'email': email,
    'password': password,
  };
  return http.post(
    Uri.http(url, 'customer/login'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}

Future<http.Response> tryLogout(token) {
  return http.post(
    Uri.http(url, 'customer/logout'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
}
