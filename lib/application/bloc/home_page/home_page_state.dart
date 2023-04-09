part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  homeState? state;
  List<CarNumber> numbers;
  String? errorMessage;

  HomePageState({
    this.state,
    required this.numbers,
    this.errorMessage,
  });

  factory HomePageState.initial() => HomePageState(numbers: const []);

  HomePageState copyWith({
    homeState? state,
    List<CarNumber>? numbers,
    String? errorMessage,
  }) =>
      HomePageState(
        state: state ?? this.state,
        numbers: numbers ?? this.numbers,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        state,
        numbers,
        errorMessage,
      ];
}

enum homeState {
  loading,
  sussess,
  error,
}