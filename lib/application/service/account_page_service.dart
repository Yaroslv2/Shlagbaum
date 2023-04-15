import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/response.dart';

class AccountPageService {
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

  Future<MyResponse> deleteAccount() async {
    MyResponse result;

    final token = await _storage.getTokenInStorage();

    var params = {"token": token};
    var response;
    try {
      response = await _dio.post(
        deleteAccountRoute,
        data: json.encode(params),
      );
      if (response.data["error"] == null) {
        result = MyResponse(response.data, response.statusCode);
      } else {
        result = MyResponse.withError(response.data["error"], 0);
      }
    } catch (e) {
      result = MyResponse.withError(
          "Что-то пошло не так, попробуйте позже", response.statusCode);
    }

    return result;
  }

  Future<MyResponse> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    MyResponse result;

    var params = {
      "token": await _storage.getTokenInStorage(),
      "old_psw": oldPassword,
      "new_psw": newPassword,
    };

    var response;
    try {
      response = await _dio.post(
        changePasswordRoute,
        data: json.encode(params),
      );
      if (response.data["error"] == null) {
        result = MyResponse(response.data, response.statusCode);
      } else {
        result = MyResponse.withError(response.data["error"], 0);
      }
    } catch (error) {
      result = MyResponse.withError(error as String, response.statusCode);
    }
    return result;
  }
}
