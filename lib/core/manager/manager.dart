/// Core Managers
///
/// Centralized management for all application services:
/// - Firebase: Push notifications, analytics, crashlytics, remote config
/// - Environment: Environment variables and configuration
/// - Routing: Navigation and routing management
/// - UI: Loading indicators, modals, and toast notifications
/// - Storage: Simple, secure, and biometric storage
library manager;

// Firebase services
export 'firebase/firebase_manager.dart';

// Environment configuration
export 'environment/environment_manager.dart';

// Routing
export 'routing/route_manager.dart';

// UI managers
export 'ui/loading_manager.dart';
export 'ui/modal_manager.dart';
export 'ui/toast_manager.dart';

// Storage manager
export 'storage/storage_manager.dart';
