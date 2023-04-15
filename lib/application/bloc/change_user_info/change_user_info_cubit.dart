import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/bloc/account_page/account_page_bloc.dart';
import 'package:shlagbaum/application/service/account_page_service.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/response.dart';

part 'change_user_info_state.dart';

class ChangeUserInfoCubit extends Cubit<ChangeUserInfoState> {
  final Storage _storage = Storage();
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
  ChangeUserInfoCubit() : super(ChangeUserInfoWaitingUser());

  Future changes(
    String phone,
    String name,
    String lastname,
    String carNumber,
  ) async {
    emit(ChangeUserInfoLoading());

    var token = await _storage.getTokenInStorage();

    var params = {
      "token": token,
      "changes": {
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "car_num": carNumber,
      },
    };

    var response;
    try {
      response = await _dio.post(
        changeUserInfoRoute,
        data: json.encode(params),
      );
      if (response.data["error"] == null) {
        _storage.putTokenInStorage(response.data["token"]);
        emit(ChangeUserInfoSuccess());
      } else {
        emit(ChangeUserInfoFailure(errorMessage: response.data["error"]));
      }
    } catch (errorMessage) {
      emit(ChangeUserInfoFailure(errorMessage: "$errorMessage"));
    }
  }
}
