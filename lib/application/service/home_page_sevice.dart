import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
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
    final token = _storage.getTokenInStorage();

    var params = {
      "token": token,
    };
    var response;
    try {
      response = await _dio.post(
        loadingHomePageRoute,
        data: json.encode(params),
      );
      if (response.data["error"]) {
        result = MyResponse.withError(response.data["error"], 0);
      } else {
        
        result = MyResponse(response.data, response.statusCode);
      }
    } catch (errorMessage) {
      result = MyResponse.withError("$errorMessage", response.statusCode);
    }
    return result;
  }
}
