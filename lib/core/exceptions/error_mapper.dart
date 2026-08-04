class ErrorMapper {
  const ErrorMapper();

  /// Maps low-level exceptions to domain-specific [AppError] subclasses.
  static Exception map(Exception e) {
    // TODO(signica): map SDK/plugin exceptions to AppError subclasses as features are added.
    return e;
  }
}
