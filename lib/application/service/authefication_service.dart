import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shlagbaum/models/response.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: url,
      contentType: "application/json",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );
  final Storage _storage = Storage();

  Future<bool> loginWithToken() async {
    bool result;
    final String token;
    if (!(await _storage.isHaveToken())) {
      return false;
    } else {
      token = await _storage.getTokenInStorage();
      if (Jwt.isExpired(token)) {
        return false;
      }
    }

    var params = {
      "token": token,
    };

    var response;
    try {
      response = await _dio.post(
        loginWithTokenRoute,
        data: json.encode(params),
      );
      if (response.data["error"] == null) {
        result = true;
      } else {
        result = false;
      }
    } catch (errorMessage) {
      result = false;
    }
    return result;
  }

  Future logout() async {
    _storage.deleteToken();
  }
}
