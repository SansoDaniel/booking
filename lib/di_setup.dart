import 'package:project_architecture/core/accessibility/focus_registry.dart';
import 'package:project_architecture/core/api_center/api_center.dart';
import 'package:project_architecture/core/manager/manager.dart';
import 'package:project_architecture/injection_container.dart' show sl;

///Here add all the dependencyInjection
///
///
void declarationInjection() {
  /// Core services - Singletons that persist throughout app lifecycle
  sl.registerLazySingleton<FocusRegistry>(() => FocusRegistry());
  sl.registerLazySingleton<ApiCenter>(() => ApiCenter());
  sl.registerLazySingleton<LoadingManager>(() => LoadingManager());
  sl.registerLazySingleton<ModalManager>(() => ModalManager());
  sl.registerLazySingleton<FirebaseManager>(() => FirebaseManager());
  sl.registerLazySingleton<StorageManager>(() => StorageManager());

  /// Services - Business logic layer
  // sl.registerFactory<LoginService>(
  //   () => LoginService(
  //     apiCenter: sl<ApiCenter>(),
  //     loadingManager: sl<LoadingManager>(),
  //     modalManager: sl<ModalManager>(),
  //   ),
  // );

  /// Features
  /// This will resetting when the principal view is disposed and will create
  /// a new one the next time the feature is open
  // sl.registerLazySingleton<LoginInterceptor>(() => LoginInterceptor());
  // sl.registerLazySingleton<SplashInterceptor>(() => SplashInterceptor());
  // sl.registerLazySingleton<DashboardInterceptor>(() => DashboardInterceptor());
  // sl.registerLazySingleton<HomeInterceptor>(() => HomeInterceptor());
  // sl.registerLazySingleton<SettingsInterceptor>(() => SettingsInterceptor());
}
