part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  homeState? state;
  List<GuestCarNumber> numbers;
  String? errorMessage;
  bool? needRefresh;

  HomePageState({
    this.state,
    required this.numbers,
    this.errorMessage,
    this.needRefresh,
  });

  factory HomePageState.initial() =>
      HomePageState(numbers: [], needRefresh: false);

  HomePageState copyWith({
    homeState? state,
    List<GuestCarNumber>? numbers,
    String? errorMessage,
    bool? needRefresh,
  }) =>
      HomePageState(
        state: state ?? this.state,
        numbers: numbers ?? this.numbers,
        errorMessage: errorMessage ?? this.errorMessage,
        needRefresh: needRefresh ?? this.needRefresh,
      );

  @override
  List<Object?> get props => [
        state,
        numbers,
        errorMessage,
        needRefresh,
      ];
}

enum homeState { loading, sussess, error, errorMessage }
