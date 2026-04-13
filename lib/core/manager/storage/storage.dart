/// Storage Management
///
/// Centralized storage management with three security levels:
/// - Simple Storage: SharedPreferences (unencrypted)
/// - Secure Storage: flutter_secure_storage (encrypted)
/// - Biometric Storage: Secure storage + biometric authentication
library storage;

export 'storage_manager.dart';
