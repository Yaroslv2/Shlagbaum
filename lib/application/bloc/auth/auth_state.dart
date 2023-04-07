part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  factory AuthState.initial() = UserInitial;
  factory AuthState.autheficated() = UserAutheficated;
  factory AuthState.notAutheficated() = UserNotAutheficated;
  factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.failure({required String message}) = AuthFailure;

  @override
  List<Object> get props => [];
}

class UserInitial extends AuthState {}

class UserAutheficated extends AuthState {}

class UserNotAutheficated extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String? message;
  const AuthFailure({required this.message});
}
