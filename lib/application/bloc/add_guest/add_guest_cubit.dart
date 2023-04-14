import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';

part 'add_guest_state.dart';

class AddGuestCubit extends Cubit<AddGuestState> {
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
  Storage _storage = Storage();
  AddGuestCubit() : super(AddGuestWaitingUser());

  Future add(String guestName, String carNumber, bool oneTime) async {
    emit(AddGuestLoading());
    final token = await _storage.getTokenInStorage();
    var params = {
      "token": token,
      "guest_name": guestName,
      "car_num": carNumber,
      "one_time_visit": oneTime,
    };

    var response;
    try {
      response = await _dio.post(
        addNewGuestRoute,
        data: json.encode(params),
      );
      if (response.data["error"] != null) {
        emit(AddGuestFailure(errorMessage: response.data["error"]));
      } else {
        emit(AddGuestSuccess());
      }
    } catch (e) {
      emit(const AddGuestFailure(
          errorMessage: "Ошибка при подключении к серверу. Попробуйте позже"));
    }
  }
}
