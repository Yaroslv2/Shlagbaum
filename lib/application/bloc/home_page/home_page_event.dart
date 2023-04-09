part of 'home_page_bloc.dart';

abstract class HomePageEvent {
  const HomePageEvent();

  factory HomePageEvent.lodingPage() = _LoadingPageEvent;
}

class _LoadingPageEvent extends HomePageEvent {
  _LoadingPageEvent();
}
