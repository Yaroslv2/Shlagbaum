import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/response.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
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
  LoginPageCubit() : super(LoginPageWaitUser());

  Future Login(String phone, String password) async {
    emit(LoginPageLoading());

    var params = {
      "password": password,
      "phone": phone,
    };

    var response;
    try {
      response = await _dio.post(
        loginWithPasswordRoute,
        data: json.encode(params),
      );
      if (response.data["error"] != null) {
        emit(LoginPageFailure(errorMessage: response.data["error"]));
      } else {
        emit(LoginPageSuccess());
        if (response.data["token"] != null) {
          _storage.putTokenInStorage(response.data["token"]);
        } else {
          emit(LoginPageFailure(errorMessage: "Что-то пошло не так..."));
        }
      }
    } catch (errorMessage) {
      emit(LoginPageFailure(errorMessage: errorMessage.toString()));
    }
  }
}
