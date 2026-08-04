sealed class AppError implements Exception {
  const AppError({required this.message, this.code});

  final String? message;
  final int? code;

  @override
  String toString() => message ?? 'Unknown Error';
}

final class UnknownError extends AppError {
  const UnknownError({super.code}) : super(message: 'Unknown error');
}
