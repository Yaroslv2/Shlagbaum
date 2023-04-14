import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/home_page_sevice.dart';
import 'package:shlagbaum/models/car_number.dart';
import 'package:shlagbaum/models/response.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageService _service;
  HomePageBloc(HomePageService service)
      : _service = service,
        super(HomePageState.initial()) {
    on<_LoadingPageEvent>(_loadingPage);
    on<_DeleteGuestEvent>(_deleteGuest);
  }

  Future _loadingPage(
      _LoadingPageEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(state: homeState.loading));

    final MyResponse response = await _service.loadingData();
    if (response.statusCode == 200) {
      List<GuestCarNumber> list = [];
      list.addAll(
        List<GuestCarNumber>.from(
          response.body["guests"].map((i) => GuestCarNumber.fromJson(i)),
        ),
      );
      emit(state.copyWith(
        state: homeState.sussess,
        numbers: list,
      ));
    } else {
      emit(state.copyWith(
        state: homeState.error,
        errorMessage: response.errorMessage,
      ));
    }
  }

  Future _deleteGuest(
      _DeleteGuestEvent event, Emitter<HomePageState> emit) async {
    var response = await _service.deleteGuest(state.numbers[event.guestIndex]);

    if (response.statusCode == 200) {
      var list = state.numbers;
      list.removeAt(event.guestIndex);
      emit(state.copyWith(
        state: homeState.sussess,
        numbers: list,
        needRefresh: true,
      ));
    } else {
      emit(state.copyWith(
        state: homeState.errorMessage,
        errorMessage: response.errorMessage,
      ));
    }
  }
}
