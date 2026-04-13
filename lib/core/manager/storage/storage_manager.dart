import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage Manager with three security levels
///
/// This manager provides three types of storage:
/// - **Simple Storage**: SharedPreferences - Fast, unencrypted (for non-sensitive data)
/// - **Secure Storage**: flutter_secure_storage - Encrypted (for sensitive data)
/// - **Biometric Storage**: Secure storage + biometric authentication (for critical data)
///
/// Usage:
/// ```dart
/// final storage = StorageManager();
/// await storage.initialize();
///
/// // Simple storage
/// await storage.saveSimple('theme', 'dark');
/// final theme = await storage.readSimple('theme');
///
/// // Secure storage
/// await storage.saveSecure('token', 'abc123');
/// final token = await storage.readSecure('token');
///
/// // Biometric storage
/// await storage.saveBiometric('pin', '1234');
/// final pin = await storage.readBiometric('pin'); // Requires biometric auth
/// ```
class StorageManager {
  StorageManager._internal();
  static final StorageManager _instance = StorageManager._internal();
  factory StorageManager() => _instance;

  // Storage instances
  SharedPreferences? _prefs;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Initialization state
  bool _isInitialized = false;

  /// Check if manager is initialized
  bool get isInitialized => _isInitialized;

  // Biometric configuration prefix
  static const String _biometricPrefix = 'biometric_';

  /// Initialize the storage manager
  ///
  /// This must be called before using any storage methods
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      debugPrint('✅ StorageManager initialized');
    } catch (e) {
      debugPrint('❌ StorageManager initialization failed: $e');
      rethrow;
    }
  }

  /// Ensure manager is initialized before operations
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'StorageManager not initialized. Call initialize() first.',
      );
    }
  }

  // ============================================================================
  // SIMPLE STORAGE (SharedPreferences - Unencrypted)
  // ============================================================================

  /// Save a string value to simple storage
  Future<bool> saveSimple(String key, String value) async {
    _ensureInitialized();
    return await _prefs!.setString(key, value);
  }

  /// Save an int value to simple storage
  Future<bool> saveSimpleInt(String key, int value) async {
    _ensureInitialized();
    return await _prefs!.setInt(key, value);
  }

  /// Save a double value to simple storage
  Future<bool> saveSimpleDouble(String key, double value) async {
    _ensureInitialized();
    return await _prefs!.setDouble(key, value);
  }

  /// Save a bool value to simple storage
  Future<bool> saveSimpleBool(String key, bool value) async {
    _ensureInitialized();
    return await _prefs!.setBool(key, value);
  }

  /// Save a list of strings to simple storage
  Future<bool> saveSimpleList(String key, List<String> value) async {
    _ensureInitialized();
    return await _prefs!.setStringList(key, value);
  }

  /// Save a JSON object to simple storage
  Future<bool> saveSimpleJson(String key, Map<String, dynamic> value) async {
    _ensureInitialized();
    final jsonString = jsonEncode(value);
    return await _prefs!.setString(key, jsonString);
  }

  /// Read a string value from simple storage
  String? readSimple(String key) {
    _ensureInitialized();
    return _prefs!.getString(key);
  }

  /// Read an int value from simple storage
  int? readSimpleInt(String key) {
    _ensureInitialized();
    return _prefs!.getInt(key);
  }

  /// Read a double value from simple storage
  double? readSimpleDouble(String key) {
    _ensureInitialized();
    return _prefs!.getDouble(key);
  }

  /// Read a bool value from simple storage
  bool? readSimpleBool(String key) {
    _ensureInitialized();
    return _prefs!.getBool(key);
  }

  /// Read a list of strings from simple storage
  List<String>? readSimpleList(String key) {
    _ensureInitialized();
    return _prefs!.getStringList(key);
  }

  /// Read a JSON object from simple storage
  Map<String, dynamic>? readSimpleJson(String key) {
    _ensureInitialized();
    final jsonString = _prefs!.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Delete a key from simple storage
  Future<bool> deleteSimple(String key) async {
    _ensureInitialized();
    return await _prefs!.remove(key);
  }

  /// Check if a key exists in simple storage
  bool hasSimple(String key) {
    _ensureInitialized();
    return _prefs!.containsKey(key);
  }

  /// Get all keys from simple storage
  Set<String> getAllSimpleKeys() {
    _ensureInitialized();
    return _prefs!.getKeys();
  }

  /// Clear all simple storage
  Future<bool> clearSimple() async {
    _ensureInitialized();
    return await _prefs!.clear();
  }

  // ============================================================================
  // SECURE STORAGE (Encrypted)
  // ============================================================================

  /// Save a string value to secure storage (encrypted)
  Future<void> saveSecure(String key, String value) async {
    _ensureInitialized();
    await _secureStorage.write(key: key, value: value);
  }

  /// Save a JSON object to secure storage (encrypted)
  Future<void> saveSecureJson(String key, Map<String, dynamic> value) async {
    _ensureInitialized();
    final jsonString = jsonEncode(value);
    await _secureStorage.write(key: key, value: jsonString);
  }

  /// Read a string value from secure storage
  Future<String?> readSecure(String key) async {
    _ensureInitialized();
    return await _secureStorage.read(key: key);
  }

  /// Read a JSON object from secure storage
  Future<Map<String, dynamic>?> readSecureJson(String key) async {
    _ensureInitialized();
    final jsonString = await _secureStorage.read(key: key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Delete a key from secure storage
  Future<void> deleteSecure(String key) async {
    _ensureInitialized();
    await _secureStorage.delete(key: key);
  }

  /// Check if a key exists in secure storage
  Future<bool> hasSecure(String key) async {
    _ensureInitialized();
    return await _secureStorage.containsKey(key: key);
  }

  /// Get all keys from secure storage
  Future<Map<String, String>> getAllSecure() async {
    _ensureInitialized();
    return await _secureStorage.readAll();
  }

  /// Clear all secure storage
  Future<void> clearSecure() async {
    _ensureInitialized();
    await _secureStorage.deleteAll();
  }

  // ============================================================================
  // BIOMETRIC STORAGE (Secure Storage + Biometric Authentication)
  // ============================================================================

  /// Check if device supports biometric authentication
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheckBiometrics && isDeviceSupported;
    } catch (e) {
      debugPrint('Error checking biometric availability: $e');
      return false;
    }
  }

  /// Get available biometric types (fingerprint, face, iris)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Error getting available biometrics: $e');
      return [];
    }
  }

  /// Authenticate with biometrics
  ///
  /// Returns true if authentication succeeded
  Future<bool> _authenticateBiometric({
    required String reason,
  }) async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        throw Exception('Biometric authentication not available on this device');
      }

      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      debugPrint('Biometric authentication error: $e');
      return false;
    }
  }

  /// Save a string value to biometric-protected storage
  ///
  /// Requires biometric authentication to save
  Future<bool> saveBiometric(
    String key,
    String value, {
    String reason = 'Autenticarsi per salvare i dati',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return false;

    await _secureStorage.write(
      key: '$_biometricPrefix$key',
      value: value,
    );
    return true;
  }

  /// Save a JSON object to biometric-protected storage
  Future<bool> saveBiometricJson(
    String key,
    Map<String, dynamic> value, {
    String reason = 'Autenticarsi per salvare i dati',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return false;

    final jsonString = jsonEncode(value);
    await _secureStorage.write(
      key: '$_biometricPrefix$key',
      value: jsonString,
    );
    return true;
  }

  /// Read a string value from biometric-protected storage
  ///
  /// Requires biometric authentication to read
  Future<String?> readBiometric(
    String key, {
    String reason = 'Autenticarsi per accedere ai dati',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return null;

    return await _secureStorage.read(key: '$_biometricPrefix$key');
  }

  /// Read a JSON object from biometric-protected storage
  Future<Map<String, dynamic>?> readBiometricJson(
    String key, {
    String reason = 'Autenticarsi per accedere ai dati',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return null;

    final jsonString = await _secureStorage.read(
      key: '$_biometricPrefix$key',
    );
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Delete a key from biometric-protected storage
  ///
  /// Requires biometric authentication to delete
  Future<bool> deleteBiometric(
    String key, {
    String reason = 'Autenticarsi per eliminare i dati',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return false;

    await _secureStorage.delete(key: '$_biometricPrefix$key');
    return true;
  }

  /// Check if a key exists in biometric-protected storage
  Future<bool> hasBiometric(String key) async {
    _ensureInitialized();
    return await _secureStorage.containsKey(key: '$_biometricPrefix$key');
  }

  /// Clear all biometric-protected storage
  ///
  /// Requires biometric authentication to clear
  Future<bool> clearBiometric({
    String reason = 'Autenticarsi per eliminare tutti i dati protetti',
  }) async {
    _ensureInitialized();

    final authenticated = await _authenticateBiometric(reason: reason);
    if (!authenticated) return false;

    final allData = await _secureStorage.readAll();
    for (final key in allData.keys) {
      if (key.startsWith(_biometricPrefix)) {
        await _secureStorage.delete(key: key);
      }
    }
    return true;
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Clear all storage (simple, secure, and biometric)
  ///
  /// Requires biometric authentication to clear biometric data
  Future<void> clearAll({
    String biometricReason = 'Autenticarsi per eliminare tutti i dati',
  }) async {
    _ensureInitialized();

    await clearSimple();
    await clearSecure();
    await clearBiometric(reason: biometricReason);
  }

  /// Get storage statistics
  Future<Map<String, dynamic>> getStorageStats() async {
    _ensureInitialized();

    final simpleKeys = getAllSimpleKeys().length;
    final allSecure = await getAllSecure();
    final secureKeys = allSecure.keys.where((k) => !k.startsWith(_biometricPrefix)).length;
    final biometricKeys = allSecure.keys.where((k) => k.startsWith(_biometricPrefix)).length;

    return {
      'simple': simpleKeys,
      'secure': secureKeys,
      'biometric': biometricKeys,
      'total': simpleKeys + secureKeys + biometricKeys,
      'biometric_available': await isBiometricAvailable(),
    };
  }

  /// Print storage statistics (debug only)
  Future<void> printStats() async {
    final stats = await getStorageStats();
    debugPrint('📊 Storage Statistics:');
    debugPrint('   Simple keys: ${stats['simple']}');
    debugPrint('   Secure keys: ${stats['secure']}');
    debugPrint('   Biometric keys: ${stats['biometric']}');
    debugPrint('   Total keys: ${stats['total']}');
    debugPrint('   Biometric available: ${stats['biometric_available']}');
  }
}
