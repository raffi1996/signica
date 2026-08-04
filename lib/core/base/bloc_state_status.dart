enum BlocStateStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == BlocStateStatus.initial;

  bool get isLoading => this == BlocStateStatus.loading;

  bool get isSuccess => this == BlocStateStatus.success;

  bool get isError => this == BlocStateStatus.error;
}
