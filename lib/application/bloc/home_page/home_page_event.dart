part of 'home_page_bloc.dart';

abstract class HomePageEvent {
  const HomePageEvent();

  factory HomePageEvent.lodingPage() = _LoadingPageEvent;
  factory HomePageEvent.deleteGuest({required int guestIndex}) =
      _DeleteGuestEvent;
}

class _LoadingPageEvent extends HomePageEvent {
  _LoadingPageEvent();
}

class _DeleteGuestEvent extends HomePageEvent {
  int guestIndex;
  _DeleteGuestEvent({required this.guestIndex});
}
