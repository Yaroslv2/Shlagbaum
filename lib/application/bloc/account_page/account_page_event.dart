part of 'account_page_bloc.dart';

abstract class AccountPageEvent {
  const AccountPageEvent();

  factory AccountPageEvent.loadingPage() = _AccountPageLoadingEvent;
  factory AccountPageEvent.deleteAccount() = _AccountPageDeleteAccountEvent;
  factory AccountPageEvent.logout() = _AccountPageLogoutEvent;
}

class _AccountPageLoadingEvent extends AccountPageEvent {
  const _AccountPageLoadingEvent();
}

class _AccountPageDeleteAccountEvent extends AccountPageEvent {
  const _AccountPageDeleteAccountEvent();
}

class _AccountPageLogoutEvent extends AccountPageEvent {
  const _AccountPageLogoutEvent();
}
