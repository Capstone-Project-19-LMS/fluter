import 'dart:convert';
import 'package:http/http.dart' as https;
import 'dart:io';

const url = 'gencer.live';

Future<https.Response> tryRegister(name, email, password) {
  Map data = {
    'name': name,
    'email': email,
    'password': password,
  };
  return https.post(
    Uri.https(url, 'customer/register'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}

Future<https.Response> tryVerif(email, code) {
  Map data = {
    'email': email,
    'code': code,
  };
  return https.post(
    Uri.https(url, 'customer/verifikasi'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}

Future<https.Response> tryLogin(email, password) {
  Map data = {
    'email': email,
    'password': password,
  };
  return https.post(
    Uri.https(url, 'customer/login'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.accessControlAllowOriginHeader: "*",
    },
    body: json.encode(data),
  );
}

Future<https.Response> tryLogout(token) {
  return https.post(
    Uri.https(url, 'customer/logout'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
}

Future<https.Response> getAllData(token) async {
  return https.get(
    Uri.https(url, 'customer/course/get_all'),
    headers: {
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
}

Future<https.Response> getCourseHistory(token) {
  return https.get(
    Uri.https(url, 'customer/course/history'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );


}
