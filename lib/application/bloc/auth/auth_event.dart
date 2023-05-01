part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();

  factory AuthEvent.loadingApp() => _LoadingApp();
  factory AuthEvent.login() = _Login;
  factory AuthEvent.logout() => _Logout();
}

class _LoadingApp extends AuthEvent {
  _LoadingApp();
}

class _Login extends AuthEvent {}

class _Logout extends AuthEvent {
  _Logout();
}
