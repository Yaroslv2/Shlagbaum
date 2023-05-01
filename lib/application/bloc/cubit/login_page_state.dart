part of 'login_page_cubit.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();

  @override
  List<Object> get props => [];
}

class LoginPageWaitUser extends LoginPageState {}

class LoginPageLoading extends LoginPageState {}

class LoginPageSuccess extends LoginPageState {}

class LoginPageFailure extends LoginPageState {
  String errorMessage;
  LoginPageFailure({required this.errorMessage});
}
