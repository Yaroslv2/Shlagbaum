import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/car_number.dart';
import 'package:shlagbaum/models/response.dart';

class HomePageService {
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

  Future<MyResponse> loadingData() async {
    MyResponse result;

    if (!(await _storage.isHaveToken())) {
      return MyResponse.withError("Непредвиденная ошибка", 0);
    }
    final token = await _storage.getTokenInStorage();

    var params = {
      "token": token,
    };
    var response;
    try {
      response = await _dio.post(
        loadingHomePageRoute,
        data: json.encode(params),
      );
      if (response.data["error"] != null) {
        result = MyResponse.withError(response.data["error"], 0);
      } else {
        result = MyResponse(response.data, response.statusCode);
      }
    } catch (errorMessage) {
      result = MyResponse.withError("$errorMessage", response.statusCode);
    }
    return result;
  }

  Future<MyResponse> deleteGuest(GuestCarNumber guest) async {
    MyResponse result;

    final token = await _storage.getTokenInStorage();

    var params = {
      "token": token,
      "guest_id": guest.id,
    };

    var response;
    try {
      response = await _dio.post(
        deleteGuestRoute,
        data: json.encode(params),
      );
      if (response.data["error"] == null) {
        result = MyResponse(response.data, response.statusCode);
      }
      else {
        result = MyResponse.withError(response.data["error"], response.statusCode);
      }
    } catch (e) {
      result = MyResponse.withError("$e", response.statusCode);
    }
    return result;
  }
}
