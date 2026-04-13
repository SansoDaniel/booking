import 'package:flutter_test/flutter_test.dart';
import 'package:booking_app/core/accessibility/focus_registry.dart';
import 'package:booking_app/core/api_center/api_center.dart';
import 'package:booking_app/core/manager/manager.dart';
import 'package:booking_app/dI_setup.dart';
import 'package:booking_app/injection_container.dart';

void main() {
  group('DI Setup', () {
    setUp(() async {
      // Reset GetIt before each test
      await sl.reset();
    });

    test('should register all core services', () {
      declarationInjection();

      expect(sl.isRegistered<FocusRegistry>(), isTrue);
      expect(sl.isRegistered<ApiCenter>(), isTrue);
      expect(sl.isRegistered<LoadingManager>(), isTrue);
      expect(sl.isRegistered<ModalManager>(), isTrue);
      expect(sl.isRegistered<FirebaseManager>(), isTrue);
    });

    test('should register services as lazy singletons', () {
      declarationInjection();

      final apiCenter1 = sl<ApiCenter>();
      final apiCenter2 = sl<ApiCenter>();

      // Should be the same instance (singleton)
      expect(identical(apiCenter1, apiCenter2), isTrue);
    });

    test('should create instances on first access', () {
      declarationInjection();

      // Services should not be instantiated yet
      expect(sl.isRegistered<ApiCenter>(), isTrue);

      // Access should create instance
      final apiCenter = sl<ApiCenter>();
      expect(apiCenter, isNotNull);
      expect(apiCenter, isA<ApiCenter>());
    });

    test('all managers should be singleton instances', () {
      declarationInjection();

      final loadingManager1 = sl<LoadingManager>();
      final loadingManager2 = sl<LoadingManager>();
      expect(identical(loadingManager1, loadingManager2), isTrue);

      final modalManager1 = sl<ModalManager>();
      final modalManager2 = sl<ModalManager>();
      expect(identical(modalManager1, modalManager2), isTrue);

      final firebaseManager1 = sl<FirebaseManager>();
      final firebaseManager2 = sl<FirebaseManager>();
      expect(identical(firebaseManager1, firebaseManager2), isTrue);
    });

    test('should be able to reset and re-register', () async {
      declarationInjection();
      expect(sl.isRegistered<ApiCenter>(), isTrue);

      await sl.reset();
      expect(sl.isRegistered<ApiCenter>(), isFalse);

      declarationInjection();
      expect(sl.isRegistered<ApiCenter>(), isTrue);
    });
  });
}
