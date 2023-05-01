import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shlagbaum/application/service/authefication_service.dart';
import 'package:shlagbaum/models/response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(AuthService service)
      : _authService = service,
        super(AuthState.initial()) {
    on<_LoadingApp>(_appLoading);
    on<_Login>(_userLogin);
    on<_Logout>(_userLogout);
  }

  Future _appLoading(_LoadingApp event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    final response = await _authService.loginWithToken();

    if (response) {
      emit(UserAutheficated());
    } else {
      emit(UserNotAutheficated());
    }
  }

  Future _userLogin(_Login event, Emitter<AuthState> emit) async {
    emit(UserAutheficated());
  }

  Future _userLogout(_Logout event, Emitter<AuthState> emit) async {
    _authService.logout();
    emit(UserNotAutheficated());
  }
}
