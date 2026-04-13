import 'package:flutter/foundation.dart';

/// Extension methods for Future to handle common patterns
extension FutureTryCatch<T> on Future<T> {
  /// Execute a Future with try-catch handling
  ///
  /// Example:
  /// ```dart
  /// fetchUser().tryCatch(
  ///   onSuccess: (user) => print('User: ${user.name}'),
  ///   onError: (error, stack) => print('Error: $error'),
  ///   onFinally: () => print('Done'),
  /// );
  /// ```
  Future<void> tryCatch({
    void Function(T data)? onSuccess,
    void Function(Object error, StackTrace stackTrace)? onError,
    void Function()? onFinally,
  }) async {
    try {
      final T result = await this;
      onSuccess?.call(result);
    } catch (error, stackTrace) {
      if (onError != null) {
        onError(error, stackTrace);
      } else if (kDebugMode) {
        debugPrint('❌ Unhandled error in Future: $error');
        debugPrint('Stack trace: $stackTrace');
      }
    } finally {
      onFinally?.call();
    }
  }

  /// Execute a Future and return a Result with success/failure
  ///
  /// Example:
  /// ```dart
  /// final result = await fetchUser().asResult();
  /// if (result.isSuccess) {
  ///   print('User: ${result.data}');
  /// } else {
  ///   print('Error: ${result.error}');
  /// }
  /// ```
  Future<FutureResult<T>> asResult() async {
    try {
      final T result = await this;
      return FutureResult.success(result);
    } catch (error, stackTrace) {
      return FutureResult.failure(error, stackTrace);
    }
  }

  /// Execute a Future with timeout
  ///
  /// Example:
  /// ```dart
  /// final user = await fetchUser().withTimeout(
  ///   duration: Duration(seconds: 5),
  ///   onTimeout: () => User.empty(),
  /// );
  /// ```
  Future<T> withTimeout({
    required Duration duration,
    T Function()? onTimeout,
  }) {
    return timeout(
      duration,
      onTimeout: onTimeout,
    );
  }

  /// Retry a Future on failure with exponential backoff
  ///
  /// Example:
  /// ```dart
  /// final data = await fetchData().retry(
  ///   maxAttempts: 3,
  ///   delay: Duration(seconds: 1),
  /// );
  /// ```
  Future<T> retry({
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(Object error)? retryIf,
  }) async {
    var attempts = 0;

    while (true) {
      try {
        attempts++;
        return await this;
      } catch (error) {
        // Check if we should retry
        if (attempts >= maxAttempts) {
          rethrow;
        }

        // Check custom retry condition
        if (retryIf != null && !retryIf(error)) {
          rethrow;
        }

        if (kDebugMode) {
          debugPrint('⚠️ Attempt $attempts/$maxAttempts failed, retrying...');
        }

        // Exponential backoff
        await Future.delayed(delay * attempts);
      }
    }
  }

  /// Execute Future and ignore errors (returns null on error)
  ///
  /// Example:
  /// ```dart
  /// final user = await fetchUser().ignoreErrors();
  /// // user is null if error occurs
  /// ```
  Future<T?> ignoreErrors() async {
    try {
      return await this;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error ignored: $e');
      }
      return null;
    }
  }

  /// Execute Future with loading state management
  ///
  /// Example:
  /// ```dart
  /// bool isLoading = false;
  /// final user = await fetchUser().withLoading(
  ///   onLoadingChange: (loading) => setState(() => isLoading = loading),
  /// );
  /// ```
  Future<T> withLoading({
    required void Function(bool isLoading) onLoadingChange,
  }) async {
    try {
      onLoadingChange(true);
      return await this;
    } finally {
      onLoadingChange(false);
    }
  }

  /// Execute Future with delay
  ///
  /// Example:
  /// ```dart
  /// final user = await fetchUser().delayed(Duration(seconds: 2));
  /// ```
  Future<T> delayed(Duration duration) {
    return Future.delayed(duration, () => this).then((value) => value);
  }

  /// Map the result of a Future
  ///
  /// Example:
  /// ```dart
  /// final userName = await fetchUser().map((user) => user.name);
  /// ```
  Future<R> map<R>(R Function(T value) mapper) async {
    final result = await this;
    return mapper(result);
  }

  /// FlatMap the result of a Future
  ///
  /// Example:
  /// ```dart
  /// final posts = await fetchUser()
  ///   .flatMap((user) => fetchUserPosts(user.id));
  /// ```
  Future<R> flatMap<R>(Future<R> Function(T value) mapper) async {
    final result = await this;
    return await mapper(result);
  }
}

/// Result wrapper for Future operations
class FutureResult<T> {
  final T? data;
  final Object? error;
  final StackTrace? stackTrace;
  final bool isSuccess;

  const FutureResult._({
    required this.isSuccess,
    this.data,
    this.error,
    this.stackTrace,
  });

  /// Create a success result
  const FutureResult.success(T data)
      : this._(data: data, isSuccess: true);

  /// Create a failure result
  const FutureResult.failure(Object error, [StackTrace? stackTrace])
      : this._(error: error, stackTrace: stackTrace, isSuccess: false);

  /// Check if result is failure
  bool get isFailure => !isSuccess;

  /// Get data or throw error
  T get dataOrThrow {
    if (isSuccess) {
      return data as T;
    }
    throw error!;
  }

  /// Get data or return default
  T getOrElse(T defaultValue) {
    return isSuccess ? data as T : defaultValue;
  }

  /// Get data or compute default
  T getOrElseCompute(T Function() defaultValue) {
    return isSuccess ? data as T : defaultValue();
  }

  /// Map success value
  FutureResult<R> map<R>(R Function(T value) mapper) {
    if (isSuccess) {
      return FutureResult.success(mapper(data as T));
    }
    return FutureResult.failure(error!, stackTrace);
  }

  /// FlatMap success value
  FutureResult<R> flatMap<R>(FutureResult<R> Function(T value) mapper) {
    if (isSuccess) {
      return mapper(data as T);
    }
    return FutureResult.failure(error!, stackTrace);
  }

  /// Handle both success and failure
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Object error) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    }
    return onFailure(error!);
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'FutureResult.success($data)';
    }
    return 'FutureResult.failure($error)';
  }
}
