part of 'main_bloc.dart';

final class MainState extends Equatable {
  final BlocStateStatus status;
  final String? errorMessage;

  const MainState({
    this.status = BlocStateStatus.initial,
    this.errorMessage,
  });

  MainState copyWith({BlocStateStatus? status, String? errorMessage}) {
    return MainState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
