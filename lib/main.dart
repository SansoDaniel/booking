import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_architecture/core/manager/environment/environment_manager.dart';
import 'package:project_architecture/core/manager/routing/middleware/middleware_setup.dart';
import 'package:project_architecture/core/manager/routing/route_manager.dart'
    show router;
import 'package:project_architecture/core/manager/storage/storage.dart';
import 'package:project_architecture/dI_setup.dart';
import 'package:project_architecture/injection_container.dart' as ic;
import 'package:toastification/toastification.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handling for Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log error in debug mode
    if (kDebugMode) {
      FlutterError.presentError(details);
    } else {
      // In production, log to analytics/crashlytics
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
      // TODO: Send to crashlytics/sentry
      // FirebaseCrashlytics.instance.recordFlutterError(details);
    }
  };

  // Global error handling for errors outside Flutter (platform errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('Platform Error: $error');
      debugPrint('Stack trace: $stack');
    } else {
      // In production, log to analytics/crashlytics
      debugPrint('Platform Error: $error');
      // TODO: Send to crashlytics/sentry
      // FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  // Run app in error zone to catch all uncaught errors
  runZonedGuarded(
    () async {
      ic.configureDependencies(EnvironmentManager.environment);
      declarationInjection();
      final storage = ic.sl<StorageManager>();
      await storage.initialize();

      // Setup navigation middleware
      setupNavigationMiddleware();

      runApp(const MyApp());
    },
    (error, stack) {
      // Catch all uncaught errors in the zone
      if (kDebugMode) {
        debugPrint('Uncaught Error: $error');
        debugPrint('Stack trace: $stack');
      } else {
        // In production, log to analytics/crashlytics
        debugPrint('Uncaught Error: $error');
        // TODO: Send to crashlytics/sentry
        // FirebaseCrashlytics.instance.recordError(error, stack);
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ToastificationWrapper(
        config: ToastificationConfig(),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
