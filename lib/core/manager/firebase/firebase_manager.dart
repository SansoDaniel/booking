import 'dart:async';
import 'dart:io';

/// Manager for Firebase services
///
/// Provides centralized management for:
/// - Firebase initialization
/// - Firebase Messaging (Push notifications)
/// - Firebase Analytics (future)
/// - Firebase Crashlytics (future)
/// - Firebase Remote Config (future)
///
/// This is a singleton that should be initialized at app startup
class FirebaseManager {
  FirebaseManager._internal();

  static final FirebaseManager _instance = FirebaseManager._internal();
  factory FirebaseManager() => _instance;

  bool _isInitialized = false;
  String? _fcmToken;
  final _notificationController = StreamController<Map<String, dynamic>>.broadcast();

  /// Check if Firebase is initialized
  bool get isInitialized => _isInitialized;

  /// Get FCM token (null if not initialized or unavailable)
  String? get fcmToken => _fcmToken;

  /// Stream for receiving notification data
  Stream<Map<String, dynamic>> get notificationStream => _notificationController.stream;

  /// Initialize Firebase services
  ///
  /// Should be called in main() before runApp()
  /// 
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await FirebaseManager().initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  Future<void> initialize() async {
    if (_isInitialized) {
      print('[FirebaseManager] Already initialized');
      return;
    }

    try {
      // TODO: Uncomment when firebase_core is added
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );

      print('[FirebaseManager] Firebase initialized successfully');
      _isInitialized = true;

      // Initialize sub-services
      await _initializeMessaging();
      // await _initializeAnalytics();
      // await _initializeCrashlytics();
      // await _initializeRemoteConfig();

    } catch (e, stackTrace) {
      print('[FirebaseManager] Failed to initialize Firebase: $e');
      print(stackTrace);
      rethrow;
    }
  }

  /// Initialize Firebase Messaging
  Future<void> _initializeMessaging() async {
    try {
      // TODO: Uncomment when firebase_messaging is added
      // final messaging = FirebaseMessaging.instance;

      // Request permissions (iOS)
      // if (Platform.isIOS) {
      //   final settings = await messaging.requestPermission(
      //     alert: true,
      //     badge: true,
      //     sound: true,
      //     provisional: false,
      //   );
      //   
      //   if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      //     print('[FirebaseManager] Notification permission denied');
      //     return;
      //   }
      // }

      // Get FCM token
      // _fcmToken = await messaging.getToken();
      // print('[FirebaseManager] FCM Token: $_fcmToken');

      // Listen for token refresh
      // messaging.onTokenRefresh.listen((newToken) {
      //   _fcmToken = newToken;
      //   print('[FirebaseManager] FCM Token refreshed: $newToken');
      //   _onTokenRefresh?.call(newToken);
      // });

      // Handle foreground messages
      // FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle background messages
      // FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

      // Handle terminated state messages
      // final initialMessage = await messaging.getInitialMessage();
      // if (initialMessage != null) {
      //   _handleTerminatedMessage(initialMessage);
      // }

      print('[FirebaseManager] Messaging initialized');
    } catch (e) {
      print('[FirebaseManager] Failed to initialize messaging: $e');
    }
  }

  /// Handle foreground notification
  void _handleForegroundMessage(dynamic message) {
    print('[FirebaseManager] Foreground message: ${message.notification?.title}');
    
    // TODO: Uncomment and implement
    // final data = {
    //   'title': message.notification?.title ?? '',
    //   'body': message.notification?.body ?? '',
    //   'data': message.data,
    //   'type': 'foreground',
    // };
    
    // _notificationController.add(data);
    // _onForegroundMessage?.call(message);
  }

  /// Handle background notification (app in background)
  void _handleBackgroundMessage(dynamic message) {
    print('[FirebaseManager] Background message: ${message.notification?.title}');
    
    // TODO: Uncomment and implement
    // final data = {
    //   'title': message.notification?.title ?? '',
    //   'body': message.notification?.body ?? '',
    //   'data': message.data,
    //   'type': 'background',
    // };
    
    // _notificationController.add(data);
    // _onBackgroundMessage?.call(message);
  }

  /// Handle terminated state notification (app was closed)
  void _handleTerminatedMessage(dynamic message) {
    print('[FirebaseManager] Terminated message: ${message.notification?.title}');
    
    // TODO: Uncomment and implement
    // final data = {
    //   'title': message.notification?.title ?? '',
    //   'body': message.notification?.body ?? '',
    //   'data': message.data,
    //   'type': 'terminated',
    // };
    
    // _notificationController.add(data);
    // _onTerminatedMessage?.call(message);
  }

  // Callback setters for custom handling
  void Function(String token)? _onTokenRefresh;
  void Function(dynamic message)? _onForegroundMessage;
  void Function(dynamic message)? _onBackgroundMessage;
  void Function(dynamic message)? _onTerminatedMessage;

  /// Set callback for token refresh
  void setOnTokenRefresh(void Function(String token) callback) {
    _onTokenRefresh = callback;
  }

  /// Set callback for foreground messages
  void setOnForegroundMessage(void Function(dynamic message) callback) {
    _onForegroundMessage = callback;
  }

  /// Set callback for background messages
  void setOnBackgroundMessage(void Function(dynamic message) callback) {
    _onBackgroundMessage = callback;
  }

  /// Set callback for terminated messages
  void setOnTerminatedMessage(void Function(dynamic message) callback) {
    _onTerminatedMessage = callback;
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      // TODO: Uncomment when firebase_messaging is added
      // await FirebaseMessaging.instance.subscribeToTopic(topic);
      print('[FirebaseManager] Subscribed to topic: $topic');
    } catch (e) {
      print('[FirebaseManager] Failed to subscribe to topic $topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      // TODO: Uncomment when firebase_messaging is added
      // await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      print('[FirebaseManager] Unsubscribed from topic: $topic');
    } catch (e) {
      print('[FirebaseManager] Failed to unsubscribe from topic $topic: $e');
    }
  }

  /// Request notification permissions (mainly for iOS)
  Future<bool> requestPermissions() async {
    if (!Platform.isIOS) {
      return true; // Android doesn't need runtime permission
    }

    try {
      // TODO: Uncomment when firebase_messaging is added
      // final messaging = FirebaseMessaging.instance;
      // final settings = await messaging.requestPermission(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      //   provisional: false,
      // );
      // 
      // return settings.authorizationStatus == AuthorizationStatus.authorized;
      
      return true; // Placeholder
    } catch (e) {
      print('[FirebaseManager] Failed to request permissions: $e');
      return false;
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      // TODO: Uncomment when firebase_messaging is added
      // await FirebaseMessaging.instance.deleteToken();
      _fcmToken = null;
      print('[FirebaseManager] FCM token deleted');
    } catch (e) {
      print('[FirebaseManager] Failed to delete token: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _notificationController.close();
  }

  // ============================================================
  // FUTURE: Firebase Analytics
  // ============================================================

  /// Log analytics event
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    try {
      // TODO: Implement when firebase_analytics is added
      // await FirebaseAnalytics.instance.logEvent(
      //   name: name,
      //   parameters: parameters,
      // );
      print('[FirebaseManager] Analytics event logged: $name');
    } catch (e) {
      print('[FirebaseManager] Failed to log event: $e');
    }
  }

  /// Set user ID for analytics
  Future<void> setUserId(String? userId) async {
    try {
      // TODO: Implement when firebase_analytics is added
      // await FirebaseAnalytics.instance.setUserId(id: userId);
      print('[FirebaseManager] User ID set: $userId');
    } catch (e) {
      print('[FirebaseManager] Failed to set user ID: $e');
    }
  }

  /// Set user property
  Future<void> setUserProperty(String name, String? value) async {
    try {
      // TODO: Implement when firebase_analytics is added
      // await FirebaseAnalytics.instance.setUserProperty(
      //   name: name,
      //   value: value,
      // );
      print('[FirebaseManager] User property set: $name = $value');
    } catch (e) {
      print('[FirebaseManager] Failed to set user property: $e');
    }
  }

  // ============================================================
  // FUTURE: Firebase Crashlytics
  // ============================================================

  /// Record error to Crashlytics
  Future<void> recordError(dynamic exception, StackTrace? stackTrace, {String? reason}) async {
    try {
      // TODO: Implement when firebase_crashlytics is added
      // await FirebaseCrashlytics.instance.recordError(
      //   exception,
      //   stackTrace,
      //   reason: reason,
      // );
      print('[FirebaseManager] Error recorded: $exception');
    } catch (e) {
      print('[FirebaseManager] Failed to record error: $e');
    }
  }

  /// Set custom key for crash reports
  Future<void> setCrashlyticsCustomKey(String key, dynamic value) async {
    try {
      // TODO: Implement when firebase_crashlytics is added
      // await FirebaseCrashlytics.instance.setCustomKey(key, value);
      print('[FirebaseManager] Crashlytics custom key set: $key = $value');
    } catch (e) {
      print('[FirebaseManager] Failed to set custom key: $e');
    }
  }

  // ============================================================
  // FUTURE: Firebase Remote Config
  // ============================================================

  /// Fetch remote config
  Future<void> fetchRemoteConfig() async {
    try {
      // TODO: Implement when firebase_remote_config is added
      // final remoteConfig = FirebaseRemoteConfig.instance;
      // await remoteConfig.setConfigSettings(RemoteConfigSettings(
      //   fetchTimeout: const Duration(minutes: 1),
      //   minimumFetchInterval: const Duration(hours: 1),
      // ));
      // await remoteConfig.fetchAndActivate();
      print('[FirebaseManager] Remote config fetched');
    } catch (e) {
      print('[FirebaseManager] Failed to fetch remote config: $e');
    }
  }

  /// Get remote config value
  String getRemoteConfigString(String key, {String defaultValue = ''}) {
    // TODO: Implement when firebase_remote_config is added
    // return FirebaseRemoteConfig.instance.getString(key);
    return defaultValue;
  }

  /// Get remote config bool value
  bool getRemoteConfigBool(String key, {bool defaultValue = false}) {
    // TODO: Implement when firebase_remote_config is added
    // return FirebaseRemoteConfig.instance.getBool(key);
    return defaultValue;
  }

  /// Get remote config int value
  int getRemoteConfigInt(String key, {int defaultValue = 0}) {
    // TODO: Implement when firebase_remote_config is added
    // return FirebaseRemoteConfig.instance.getInt(key);
    return defaultValue;
  }
}
