import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _tokenKey = "token";

  Future<bool> isHaveToken() async {
    final storage = await SharedPreferences.getInstance();
    final result = storage.get(_tokenKey);
    if (result == null) storage.remove(_tokenKey);
    return (result == null) || (result == "") ? false : true;
  }

  Future<String> getTokenInStorage() async {
    final storage = await SharedPreferences.getInstance();
    final result = storage.getString(_tokenKey) as String;
    return result;
  }

  Future<void> putTokenInStorage(String token) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(_tokenKey, token);
  }

  Future<void> deleteToken() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(_tokenKey);
  }
}
