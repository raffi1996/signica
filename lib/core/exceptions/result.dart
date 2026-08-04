import 'dart:developer';

import 'package:signica/core/exceptions/error_mapper.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success(value);

  factory Result.successVoid() => const Success<void>(null) as Result<T>;

  factory Result.errorString(String error, {StackTrace? stackTrace}) {
    return Error(Exception(error), stackTrace);
  }

  factory Result.error(Exception error, [StackTrace? stackTrace]) => Error(error, stackTrace);

  bool get isSuccess => this is Success<T>;

  bool get isError => this is Error<T>;

  T? get valueOrNull => switch (this) {
    Success(value: final v) => v,
    Error() => null,
  };

  Exception? get errorOrNull => switch (this) {
    Success() => null,
    Error(error: final e) => e,
  };

  R fold<R>({
    required R Function(T value) success,
    required R Function(Exception error, StackTrace? stackTrace) error,
  }) {
    return switch (this) {
      Success(value: final v) => success(v),
      Error(error: final e, stackTrace: final s) => error(e, s),
    };
  }

  Future<R> asyncFold<R>({
    required Future<R> Function(T value) success,
    required Future<R> Function(Exception error) error,
  }) async {
    return switch (this) {
      Success(value: final v) => await success(v),
      Error(error: final e) => await error(e),
    };
  }

  static Future<Result<T>> asyncHandle<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return Result<T>.success(response);
    } on Exception catch (e, stacktrace) {
      log(e.toString());
      return Result<T>.error(ErrorMapper.map(e), stacktrace);
    } catch (e, st) {
      log(e.toString());
      return Result<T>.error(Exception(e.toString()), st);
    }
  }

  static Result<T> handle<T>(T Function() call) {
    try {
      final response = call();
      return Result<T>.success(response);
    } on Exception catch (e, stacktrace) {
      log(e.toString());
      return Result<T>.error(ErrorMapper.map(e), stacktrace);
    } catch (e, st) {
      log(e.toString());
      return Result<T>.error(Exception(e.toString()), st);
    }
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error(this.error, this.stackTrace);

  final Exception error;
  final StackTrace? stackTrace;
}
