import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
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
  ChangePasswordCubit() : super(ChangePasswordWaitingUser());

  Future updatePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoading());

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
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFailure(errorMessage: response.data["error"]));
      }
    } catch (e) {
      emit(ChangePasswordFailure(errorMessage: e as String));
    }
  }
}
