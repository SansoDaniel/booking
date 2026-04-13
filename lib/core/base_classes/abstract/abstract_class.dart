import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_architecture/injection_container.dart';

abstract class AppInterceptor {
  const AppInterceptor();
}

abstract class AppState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

abstract class AppConsumerState<
  T extends ConsumerStatefulWidget,
  S extends AppInterceptor
>
    extends ConsumerState<T> {
  final S interceptor = sl<S>();

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(afterInit);
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration timeStamp) => onReady(),
    );
  }

  void afterInit() {}

  void onReady() {}

  @override
  void dispose() {
    sl.resetLazySingleton(instance: S);
    super.dispose();
  }
}
