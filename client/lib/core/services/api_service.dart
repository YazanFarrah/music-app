import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:client/config/api_paths.dart';
import 'package:client/core/utils/prints_utils.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class RestApiService {
  static Future<Map<String, String>> getHeaders() async {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<http.Response> get(String path,
      [Map<String, dynamic> queryParams = const {}]) async {
    printWarning(path);
    final url = Uri.parse('${ApiPaths.baseUrl}$path')
        .replace(queryParameters: queryParams);
    final headers = await getHeaders();

    printWarning("full url: $url");
    printError(headers);

    return retry(
      () => http.get(url, headers: headers).timeout(const Duration(seconds: 4)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 4,
    );
  }

  static Future<http.Response> post(String path,
      [Object? requestBody,
      Map<String, dynamic> queryParams = const {}]) async {
    final url = Uri.parse('${ApiPaths.baseUrl}$path');
    final headers = await getHeaders();
    printError("Headers: $headers");
    printWarning("full url: $url");

    return retry(
      () => http
          .post(url, headers: headers, body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 4)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 4,
    );
  }

  static Future<http.Response> put(String path,
      [Object? requestBody,
      Map<String, dynamic> queryParams = const {}]) async {
    final url = Uri.parse('${ApiPaths.baseUrl}$path');
    final headers = await getHeaders();
    printWarning("full url: $url");

    return retry(
      () => http
          .put(url, headers: headers, body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 4)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 4,
    );
  }

  static Future<http.Response> patch(String path,
      [Object? requestBody,
      Map<String, dynamic> queryParams = const {}]) async {
    final url = Uri.parse('${ApiPaths.baseUrl}$path');
    final headers = await getHeaders();
    printWarning("full url: $url");

    return retry(
      () => http
          .patch(url, headers: headers, body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 4)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 4,
    );
  }

  static Future<http.Response> delete(String path,
      [Object? requestBody,
      Map<String, dynamic> queryParams = const {}]) async {
    final url = Uri.parse('${ApiPaths.baseUrl}$path');
    final headers = await getHeaders();
    printWarning("full url: $url");
    printError(headers);

    return retry(
      () => http
          .delete(url, headers: headers, body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 4)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 4,
    );
  }
}
