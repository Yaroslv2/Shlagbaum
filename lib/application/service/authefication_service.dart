import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shlagbaum/models/response.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: url,
    contentType: "application/json",
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
  ));
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
      if (!response.data["error"]) {
        result = true;
      } else {
        result = false;
      }
    } catch (errorMessage) {
      result = false;
    }
    return result;
  }

  Future<MyResponse> loginWithPassword(String phone, String password) async {
    MyResponse result;

    var params = {
      "password": password,
      "phone": phone,
    };

    var response;
    try {
      response = _dio.post(
        loginWithPasswordRoute,
        data: json.encode(params),
      );

      if (response.data["error"]) {
        result =
            MyResponse.withError(response.data["error"], response.statusCode);
      } else {
        result = MyResponse(response.data, response.statusCode);
        if (response.data["token"]) {
          _storage.putTokenInStorage(response.data["token"]);
        }
      }
    } catch (errorMessage) {
      result = MyResponse.withError("$errorMessage", response.statusCode);
    }

    return result;
  }

  Future<MyResponse> registration(
    String password,
    String phone,
    String name,
    String lastname,
    String carNumber,
  ) async {
    MyResponse result;

    var params = {
      "password": password,
      "phone": phone,
      "name": name,
      "lastname": lastname,
      "car_num": carNumber,
    };

    var response;
    try {
      response = await _dio.post(
        registrtionRoute,
        data: json.encode(params),
      );
      if (response.data["error"]) {
        result = MyResponse.withError(response.data["error"], 0);
      } else {
        result = MyResponse(response.data, response.statusCode);
        if (response.data["token"]) {
          _storage.putTokenInStorage(response.data["token"]);
        }
      }
    } catch (errorMessage) {
      result = MyResponse.withError("$errorMessage", response.statusCode);
    }

    return result;
  }

  Future logout() async {
    _storage.deleteToken();
  }
}
