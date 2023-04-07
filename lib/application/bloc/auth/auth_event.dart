part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();

  factory AuthEvent.loadingApp() => _LoadingApp();
  factory AuthEvent.login(
      {required String phoneNumber, required String password}) = _Login;
  factory AuthEvent.registration({
    required String name,
    required String lastname,
    required String phoneNumber,
    required String password,
    required String carNumber,
  }) = _Registration;
  factory AuthEvent.logout() => _Logout();
}

class _LoadingApp extends AuthEvent {
  _LoadingApp();
}

class _Login extends AuthEvent {
  String phoneNumber;
  String password;
  _Login({required this.phoneNumber, required this.password});
}

class _Registration extends AuthEvent {
  String name;
  String lastname;
  String phoneNumber;
  String password;
  String carNumber;
  _Registration({
    required this.name,
    required this.lastname,
    required this.phoneNumber,
    required this.password,
    required this.carNumber,
  });
}

class _Logout extends AuthEvent {
  _Logout();
}
