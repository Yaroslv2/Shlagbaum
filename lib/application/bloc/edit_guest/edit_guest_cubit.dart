import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/server_info.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/car_number.dart';

part 'edit_guest_state.dart';

class EditGuestCubit extends Cubit<EditGuestState> {
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
  EditGuestCubit() : super(EditGuestWaitingUser());

  Future edit(int id, String name, String carNumber, bool oneTime) async {
    emit(EditGuestLoading());

    final token = await _storage.getTokenInStorage();

    var params = {
      "token": token,
      "guest_id": id,
      "changes": {
        "guest_name": name,
        "car_num": carNumber,
        "one_time_visit": oneTime,
      },
    };

    var response;
    try {
      response = await _dio.post(
        editGuestRoute,
        data: json.encode(params),
      );
      if (response.data["error"] != null) {
        emit(EditGuestFailure(errorMessage: response.data["error"]));
      } else {
        emit(EditGuestSuccess());
      }
    } catch (e) {
      emit(EditGuestFailure(errorMessage: "$e"));
    }
  }
}
