part of 'account_page_bloc.dart';

class AccountPageState extends Equatable {
  accountState? state;
  String? phone;
  String? name;
  String? lastname;
  String? carNumber;
  String? carType;
  int? pole;
  bool? needRefresh;
  String? errorMessage;

  AccountPageState({
    this.state,
    this.phone,
    this.name,
    this.lastname,
    this.carNumber,
    this.pole,
    this.carType,
    this.needRefresh,
    this.errorMessage,
  });

  factory AccountPageState.initial() =>
      AccountPageState(state: accountState.loading, needRefresh: false);

  AccountPageState copyWith({
    accountState? state,
    String? phone,
    String? name,
    String? lastname,
    String? carNumber,
    String? carType,
    int? pole,
    bool? needRefresh,
    String? errorMessage,
  }) =>
      AccountPageState(
        state: state ?? this.state,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        carNumber: carNumber ?? this.carNumber,
        carType: carType ?? this.carType,
        pole: pole ?? this.pole,
        needRefresh: needRefresh ?? this.needRefresh,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        state,
        phone,
        name,
        lastname,
        carNumber,
        carType,
        pole,
        needRefresh,
      ];
}

enum accountState { sussess, loading, error, errorMessage }
