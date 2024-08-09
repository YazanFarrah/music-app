import 'dart:io';

class ApiPaths {
  static String baseUrl =
      Platform.isAndroid ? 'https://4e1f-2a01-9700-354b-3400-48a8-4508-c839-33/' : 'http://127.0.0.1:8000/';
  static const String signup = 'auth/signup';
  static const String login = 'auth/login';
  static const String getUserData = 'auth/';
}
