import 'package:project_architecture/core/manager/firebase/firebase_manager.dart';

/// Examples of how to use FirebaseManager
///
/// This file demonstrates various use cases for Firebase integration
class FirebaseExample {
  final FirebaseManager _firebaseManager = FirebaseManager();

  /// Example 1: Initialize Firebase in main.dart
  /// 
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   
  ///   // Initialize Firebase
  ///   await FirebaseManager().initialize();
  ///   
  ///   runApp(MyApp());
  /// }
  /// ```

  /// Example 2: Setup notification listeners
  void setupNotificationListeners() {
    // Listen to all notifications via stream
    _firebaseManager.notificationStream.listen((notification) {
      print('Notification received: ${notification['title']}');
      
      // Handle notification based on type
      switch (notification['type']) {
        case 'foreground':
          _handleForegroundNotification(notification);
          break;
        case 'background':
          _handleBackgroundNotification(notification);
          break;
        case 'terminated':
          _handleTerminatedNotification(notification);
          break;
      }
    });

    // Or use individual callbacks
    _firebaseManager.setOnForegroundMessage((message) {
      print('Foreground message: $message');
      // Show in-app notification or update UI
    });

    _firebaseManager.setOnBackgroundMessage((message) {
      print('Background message: $message');
      // Navigate to specific screen
    });

    _firebaseManager.setOnTerminatedMessage((message) {
      print('Terminated message: $message');
      // Navigate to specific screen
    });

    _firebaseManager.setOnTokenRefresh((token) {
      print('Token refreshed: $token');
      // Send new token to backend
      _sendTokenToBackend(token);
    });
  }

  /// Example 3: Get and send FCM token to backend
  Future<void> registerDeviceToken() async {
    final token = _firebaseManager.fcmToken;
    
    if (token != null) {
      await _sendTokenToBackend(token);
    } else {
      print('FCM token not available');
    }
  }

  Future<void> _sendTokenToBackend(String token) async {
    // Send to your backend API
    // await apiCenter.dio.post('/devices/register', data: {
    //   'fcm_token': token,
    //   'platform': Platform.isIOS ? 'ios' : 'android',
    // });
    print('Token sent to backend: $token');
  }

  /// Example 4: Request notification permissions (iOS)
  Future<void> requestNotificationPermissions() async {
    final granted = await _firebaseManager.requestPermissions();
    
    if (granted) {
      print('Notification permissions granted');
      // Register device token
      await registerDeviceToken();
    } else {
      print('Notification permissions denied');
      // Show explanation dialog
    }
  }

  /// Example 5: Subscribe to topics
  Future<void> subscribeToUserTopics(String userId, List<String> interests) async {
    // Subscribe to user-specific topic
    await _firebaseManager.subscribeToTopic('user_$userId');
    
    // Subscribe to interest topics
    for (final interest in interests) {
      await _firebaseManager.subscribeToTopic('interest_$interest');
    }
    
    // Subscribe to general topics
    await _firebaseManager.subscribeToTopic('all_users');
    await _firebaseManager.subscribeToTopic('promotions');
  }

  /// Example 6: Unsubscribe on logout
  Future<void> unsubscribeOnLogout(String userId) async {
    await _firebaseManager.unsubscribeFromTopic('user_$userId');
    await _firebaseManager.deleteToken();
  }

  /// Example 7: Handle notifications with routing
  void _handleForegroundNotification(Map<String, dynamic> notification) {
    final data = notification['data'] as Map<String, dynamic>?;
    
    if (data != null && data.containsKey('type')) {
      switch (data['type']) {
        case 'message':
          // Show in-app notification
          _showInAppNotification(notification);
          break;
        case 'order':
          // Update order status in UI
          _updateOrderStatus(data['order_id']);
          break;
        default:
          print('Unknown notification type: ${data['type']}');
      }
    }
  }

  void _handleBackgroundNotification(Map<String, dynamic> notification) {
    final data = notification['data'] as Map<String, dynamic>?;
    
    if (data != null && data.containsKey('screen')) {
      // Navigate to specific screen
      _navigateToScreen(data['screen'], data);
    }
  }

  void _handleTerminatedNotification(Map<String, dynamic> notification) {
    final data = notification['data'] as Map<String, dynamic>?;
    
    if (data != null && data.containsKey('screen')) {
      // Navigate to specific screen
      _navigateToScreen(data['screen'], data);
    }
  }

  void _showInAppNotification(Map<String, dynamic> notification) {
    // Use your toast/snackbar system
    print('Show in-app: ${notification['title']}');
  }

  void _updateOrderStatus(String orderId) {
    // Update UI or refetch order data
    print('Update order: $orderId');
  }

  void _navigateToScreen(String screen, Map<String, dynamic> data) {
    // Use your router
    print('Navigate to: $screen with data: $data');
  }

  /// Example 8: Analytics integration
  Future<void> trackUserActions() async {
    // Log screen view
    await _firebaseManager.logEvent('screen_view', parameters: {
      'screen_name': 'home',
      'screen_class': 'HomeView',
    });

    // Log button click
    await _firebaseManager.logEvent('button_click', parameters: {
      'button_name': 'checkout',
      'screen': 'cart',
    });

    // Log purchase
    await _firebaseManager.logEvent('purchase', parameters: {
      'value': 99.99,
      'currency': 'EUR',
      'items': ['product_123', 'product_456'],
    });

    // Set user properties
    await _firebaseManager.setUserId('user_123');
    await _firebaseManager.setUserProperty('user_type', 'premium');
    await _firebaseManager.setUserProperty('preferred_language', 'it');
  }

  /// Example 9: Crashlytics integration
  Future<void> setupCrashlytics() async {
    // Set custom keys for debugging
    await _firebaseManager.setCrashlyticsCustomKey('user_id', 'user_123');
    await _firebaseManager.setCrashlyticsCustomKey('environment', 'production');

    // Record non-fatal error
    try {
      // Some operation that might fail
      throw Exception('Something went wrong');
    } catch (e, stackTrace) {
      await _firebaseManager.recordError(
        e,
        stackTrace,
        reason: 'Failed to process payment',
      );
    }
  }

  /// Example 10: Remote Config integration
  Future<void> useRemoteConfig() async {
    // Fetch config
    await _firebaseManager.fetchRemoteConfig();

    // Get values
    final maintenanceMode = _firebaseManager.getRemoteConfigBool(
      'maintenance_mode',
      defaultValue: false,
    );

    final minAppVersion = _firebaseManager.getRemoteConfigString(
      'min_app_version',
      defaultValue: '1.0.0',
    );

    final maxRetries = _firebaseManager.getRemoteConfigInt(
      'max_api_retries',
      defaultValue: 3,
    );

    print('Maintenance mode: $maintenanceMode');
    print('Min app version: $minAppVersion');
    print('Max retries: $maxRetries');

    // Use values to control app behavior
    if (maintenanceMode) {
      // Show maintenance screen
    }
  }

  /// Example 11: Complete app initialization
  /// 
  /// In your main.dart:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   
  ///   // Initialize Firebase
  ///   await FirebaseManager().initialize();
  ///   
  ///   // Setup notification handlers
  ///   final firebaseExample = FirebaseExample();
  ///   firebaseExample.setupNotificationListeners();
  ///   
  ///   // Fetch remote config
  ///   await FirebaseManager().fetchRemoteConfig();
  ///   
  ///   runApp(MyApp());
  /// }
  /// ```

  /// Example 12: Riverpod integration
  /// 
  /// Create a provider for Firebase notifications:
  /// ```dart
  /// final notificationProvider = StreamProvider<Map<String, dynamic>>((ref) {
  ///   return FirebaseManager().notificationStream;
  /// });
  /// 
  /// // In your widget:
  /// class MyWidget extends ConsumerWidget {
  ///   @override
  ///   Widget build(BuildContext context, WidgetRef ref) {
  ///     final notification = ref.watch(notificationProvider);
  ///     
  ///     notification.when(
  ///       data: (data) => Text('Notification: ${data['title']}'),
  ///       loading: () => CircularProgressIndicator(),
  ///       error: (err, stack) => Text('Error: $err'),
  ///     );
  ///   }
  /// }
  /// ```
}
