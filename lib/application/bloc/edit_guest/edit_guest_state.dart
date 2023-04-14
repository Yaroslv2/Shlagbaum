part of 'edit_guest_cubit.dart';

abstract class EditGuestState extends Equatable {
  const EditGuestState();

  @override
  List<Object> get props => [];
}

class EditGuestWaitingUser extends EditGuestState {}

class EditGuestLoading extends EditGuestState {}

class EditGuestSuccess extends EditGuestState {}

class EditGuestFailure extends EditGuestState {
  String errorMessage;
  EditGuestFailure({required this.errorMessage});
}
