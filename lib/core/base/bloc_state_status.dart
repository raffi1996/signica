enum BlocStateStatus {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == BlocStateStatus.loading;
}
