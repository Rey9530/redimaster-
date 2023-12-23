import 'dart:async';
import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import 'package:credimaster/src/utils/environment.dart';
import 'package:http/http.dart' as http;

class ConexionesProvider extends ChangeNotifier {
  Map<String, String> requestHeaders = {
    'Accept': '*/*',
    // 'Content-Type': 'application/json'
  };
  CodeResponseHttp errorConexion = CodeResponseHttp(
    body:
        ' { "status": 401, "message": "No se ha detectado conexión a internet", "info": {"data": null} }',
    statusCode: 401,
  );
  bool conected = true;
  ConexionesProvider() {
    verifyConection();
  }

  final String _baseUrl = BASE_URL;
  final String _endpint = END_POINT;
  final storage = const FlutterSecureStorage();

  get_(String endpoint,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final token = await storage.read(key: 'token') ?? '';
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
      'Authorization': "Bearer $token"
    };

    final url =
        Uri.http(_baseUrl, '$_endpint/$endpoint', {...?queryParameters});
    http.Response response;
    try {
      response = await http
          .get(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return CodeResponseHttp(
        body:
            ' { "status": 401, "message": "Tiempo de espera alcanzado", "info": {"data": null} }',
        statusCode: 401,
      );
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  post_(String endpoint, dynamic body,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.http(_baseUrl, '$_endpint/$endpoint');
    final token = await storage.read(key: 'token') ?? '0000';

    Map<String, String> headersRequest = {
      ...?headers,
      ...requestHeaders,
      'Authorization': "Bearer $token"
    };
    http.Response response;
    try {
      response = await http
          .post(url, body: body, headers: headersRequest)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return CodeResponseHttp(
        body:
            ' { "status": 401, "message": "WaitTimeReached", "info": {"data": null} }',
        statusCode: 401,
      );

      // throw ('Tiempo de espera alcanzado');
    } on SocketException {
      String body =
          ' { "status": 401, "message": "ServerError", "info": {"data": null} }';
      return CodeResponseHttp(
        body: body,
        statusCode: 401,
      );
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }

    return response;
  }

  put_(String endpoint, dynamic body,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.http(_baseUrl, '$_endpint/$endpoint');
    // Await the http get response, then decode the json-formatted response.
    final token = await storage.read(key: 'token') ?? '';
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
      'Authorization': "Bearer $token"
    };
    http.Response response;

    try {
      response = await http
          .put(url, body: body, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  delte_(String endpoint,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.http(_baseUrl, '$_endpint/$endpoint');
    // Await the http get response, then decode the json-formatted response.
    final token = await storage.read(key: 'token') ?? '';
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
      'Authorization': "Bearer $token"
    };
    http.Response response;

    try {
      response = await http
          .delete(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  verifyConection() async {
    return true;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   conected = true;
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   conected = true;
    //   // I am connected to a wifi network.
    // } else {
    //   conected = false;
    //   notifyListeners();
    // }
    // return conected;
  }
}
