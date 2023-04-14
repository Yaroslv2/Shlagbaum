part of 'add_guest_cubit.dart';

abstract class AddGuestState extends Equatable {
  const AddGuestState();

  @override
  List<Object> get props => [];
}

class AddGuestWaitingUser extends AddGuestState {}

class AddGuestLoading extends AddGuestState {}

class AddGuestFailure extends AddGuestState {
  final String errorMessage;

  const AddGuestFailure({required this.errorMessage});
}

class AddGuestSuccess extends AddGuestState {}