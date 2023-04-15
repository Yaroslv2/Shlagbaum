import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/service/account_page_service.dart';
import 'package:shlagbaum/application/service/storage.dart';
import 'package:shlagbaum/models/response.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  final AuthBloc _authBloc;
  final Storage _storage = Storage();
  final AccountPageService _service;
  AccountPageBloc(AuthBloc bloc, AccountPageService servise)
      : _authBloc = bloc,
        _service = servise,
        super(AccountPageState.initial()) {
    on<_AccountPageLoadingEvent>(_loadingPage);
    on<_AccountPageDeleteAccountEvent>(_deleteAccount);
    on<_AccountPageLogoutEvent>(_logout);
  }

  Future _loadingPage(
      _AccountPageLoadingEvent event, Emitter<AccountPageState> emit) async {
    if ((await _storage.isHaveToken())) {
      final token = Jwt.parseJwt(await _storage.getTokenInStorage());
      emit(state.copyWith(
        state: accountState.sussess,
        phone: token["phone"],
        name: token["name"],
        lastname: token["last_name"],
        carNumber: token["car_num"],
      ));
    } else {
      emit(state.copyWith(
        state: accountState.error,
        errorMessage: "Что-то пошло не так...",
      ));
    }
  }

  Future _deleteAccount(_AccountPageDeleteAccountEvent event,
      Emitter<AccountPageState> emit) async {
    MyResponse response = await _service.deleteAccount();

    if (response.statusCode == 200) {
      _authBloc.add(AuthEvent.logout());
    } else {
      emit(state.copyWith(
        errorMessage: response.errorMessage,
        state: accountState.errorMessage,
      ));
    }
  }

  Future _logout(
      _AccountPageLogoutEvent event, Emitter<AccountPageState> emit) async {
    _authBloc.add(AuthEvent.logout());
  }
}
