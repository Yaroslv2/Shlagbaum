import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/home_page_sevice.dart';
import 'package:shlagbaum/models/car_number.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageService _service;
  HomePageBloc(HomePageService service)
      : _service = service,
        super(HomePageState.initial()) {
    on<_LoadingPageEvent>(_loadingPage);
  }

  Future _loadingPage(
      _LoadingPageEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(state: homeState.loading));

    final response = await _service.loadingData();
    if (response.statusCode == 200) {
      List<CarNumber> list = state.numbers;
      list.addAll(
        List<CarNumber>.from(
          response.body["carNumbers"].map((i) => CarNumber.fromJson(i)),
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
}
