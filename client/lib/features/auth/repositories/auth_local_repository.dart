import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;
  final tokenKey = 'x-auth-token';

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token){
    if(token!=null){
      _sharedPreferences.setString(tokenKey, token);
    }
  }
  String? get getToken {
    return _sharedPreferences.getString(tokenKey);
  }
}
