part of 'change_user_info_cubit.dart';

abstract class ChangeUserInfoState extends Equatable {
  const ChangeUserInfoState();

  @override
  List<Object> get props => [];
}

class ChangeUserInfoWaitingUser extends ChangeUserInfoState {}

class ChangeUserInfoLoading extends ChangeUserInfoState {}

class ChangeUserInfoFailure extends ChangeUserInfoState {
  String errorMessage;
  ChangeUserInfoFailure({required this.errorMessage});
}

class ChangeUserInfoSuccess extends ChangeUserInfoState {}
