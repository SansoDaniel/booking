# Firebase Manager

Manager centralizzato per tutti i servizi Firebase nel progetto.

## 📋 Indice

- [Caratteristiche](#caratteristiche)
- [Installazione](#installazione)
- [Configurazione](#configurazione)
- [Utilizzo](#utilizzo)
- [Servizi Supportati](#servizi-supportati)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## ✨ Caratteristiche

- ✅ **Singleton Pattern**: Istanza unica per tutta l'app
- ✅ **Firebase Messaging**: Push notifications complete
- ✅ **Topic Subscription**: Gestione topic per notifiche mirate
- ✅ **Token Management**: Gestione automatica FCM token
- ✅ **Stream API**: Stream per ascoltare notifiche
- ✅ **Callbacks**: Callbacks personalizzabili per ogni evento
- ✅ **Analytics Ready**: Preparato per Firebase Analytics
- ✅ **Crashlytics Ready**: Preparato per crash reporting
- ✅ **Remote Config Ready**: Preparato per configurazioni remote
- ✅ **Cross-Platform**: iOS e Android supportati

## 📦 Installazione

### 1. Aggiungi Dipendenze

Nel `pubspec.yaml`:

```yaml
dependencies:
  # Firebase Core (required)
  firebase_core: ^3.8.1
  
  # Firebase Messaging (push notifications)
  firebase_messaging: ^15.1.5
  
  # Optional services
  firebase_analytics: ^11.4.1
  firebase_crashlytics: ^4.2.1
  firebase_remote_config: ^5.2.1
```

### 2. Configura Firebase

#### iOS

1. Scarica `GoogleService-Info.plist` dalla Firebase Console
2. Aggiungi a `ios/Runner/GoogleService-Info.plist`
3. In `ios/Runner/AppDelegate.swift`:

```swift
import FirebaseCore
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

4. Aggiungi capabilities in Xcode:
   - Push Notifications
   - Background Modes → Remote notifications

#### Android

1. Scarica `google-services.json` dalla Firebase Console
2. Aggiungi a `android/app/google-services.json`
3. In `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.2'
    }
}
```

4. In `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'
```

5. In `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
</manifest>
```

### 3. Genera Firebase Options

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

Questo crea `lib/firebase_options.dart`.

## 🚀 Configurazione

### Inizializzazione Base

Nel `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:booking_app/core/manager/firebase_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize FirebaseManager
  await FirebaseManager().initialize();
  
  runApp(MyApp());
}
```

### Setup Notifiche

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseManager _firebaseManager = FirebaseManager();

  @override
  void initState() {
    super.initState();
    _setupNotifications();
  }

  void _setupNotifications() {
    // Ascolta tutte le notifiche
    _firebaseManager.notificationStream.listen((notification) {
      print('Notifica: ${notification['title']}');
    });

    // O usa callbacks specifici
    _firebaseManager.setOnForegroundMessage((message) {
      // App in foreground
      _showInAppNotification(message);
    });

    _firebaseManager.setOnBackgroundMessage((message) {
      // App in background
      _navigateToScreen(message);
    });

    _firebaseManager.setOnTerminatedMessage((message) {
      // App era chiusa
      _navigateToScreen(message);
    });

    _firebaseManager.setOnTokenRefresh((token) {
      // Token aggiornato
      _sendTokenToBackend(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView());
  }
}
```

## 💡 Utilizzo

### 1. Richiedere Permessi (iOS)

```dart
final granted = await FirebaseManager().requestPermissions();

if (granted) {
  print('Permessi concessi');
} else {
  // Mostra dialog esplicativo
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Notifiche Disabilitate'),
      content: Text('Abilita le notifiche nelle impostazioni'),
    ),
  );
}
```

### 2. Ottenere FCM Token

```dart
final token = FirebaseManager().fcmToken;

if (token != null) {
  // Invia al backend
  await apiCenter.dio.post('/devices/register', data: {
    'fcm_token': token,
    'platform': Platform.isIOS ? 'ios' : 'android',
  });
}
```

### 3. Subscribere a Topic

```dart
// Topic per notifiche generali
await FirebaseManager().subscribeToTopic('all_users');

// Topic per utente specifico
await FirebaseManager().subscribeToTopic('user_${userId}');

// Topic per categorie
await FirebaseManager().subscribeToTopic('news');
await FirebaseManager().subscribeToTopic('promotions');

// Topic per interessi
final interests = ['sport', 'tech', 'music'];
for (final interest in interests) {
  await FirebaseManager().subscribeToTopic('interest_$interest');
}
```

### 4. Gestire Notifiche

```dart
// Listener stream
FirebaseManager().notificationStream.listen((notification) {
  final type = notification['type']; // foreground, background, terminated
  final title = notification['title'];
  final body = notification['body'];
  final data = notification['data'];

  switch (type) {
    case 'foreground':
      // Mostra banner in-app
      showToast(title, body);
      break;
    
    case 'background':
    case 'terminated':
      // Naviga a schermata specifica
      if (data['screen'] != null) {
        router.go(data['screen']);
      }
      break;
  }
});
```

### 5. Unsubscribe e Cleanup

```dart
// Al logout
Future<void> logout() async {
  final userId = getCurrentUserId();
  
  // Unsubscribe da topic utente
  await FirebaseManager().unsubscribeFromTopic('user_$userId');
  
  // Elimina token
  await FirebaseManager().deleteToken();
  
  // Clear user data...
}
```

### 6. Analytics (Quando Implementato)

```dart
// Track screen view
await FirebaseManager().logEvent('screen_view', parameters: {
  'screen_name': 'home',
  'screen_class': 'HomeView',
});

// Track evento personalizzato
await FirebaseManager().logEvent('button_click', parameters: {
  'button_name': 'checkout',
  'value': 99.99,
});

// Set user properties
await FirebaseManager().setUserId('user_123');
await FirebaseManager().setUserProperty('user_type', 'premium');
```

### 7. Crashlytics (Quando Implementato)

```dart
// Registra errore
try {
  await riskyOperation();
} catch (e, stackTrace) {
  await FirebaseManager().recordError(
    e,
    stackTrace,
    reason: 'Failed operation X',
  );
}

// Set custom keys per debugging
await FirebaseManager().setCrashlyticsCustomKey('user_id', userId);
await FirebaseManager().setCrashlyticsCustomKey('screen', 'checkout');
```

### 8. Remote Config (Quando Implementato)

```dart
// Fetch configurazioni
await FirebaseManager().fetchRemoteConfig();

// Get valori
final maintenanceMode = FirebaseManager().getRemoteConfigBool(
  'maintenance_mode',
  defaultValue: false,
);

final minVersion = FirebaseManager().getRemoteConfigString(
  'min_app_version',
  defaultValue: '1.0.0',
);

// Usa valori
if (maintenanceMode) {
  // Mostra schermata manutenzione
  router.go('/maintenance');
}
```

## 🎯 Servizi Supportati

### ✅ Implementati

| Servizio | Status | Descrizione |
|----------|--------|-------------|
| Core | ✅ Ready | Inizializzazione Firebase |
| Messaging | ✅ Ready | Push notifications complete |
| Token Management | ✅ Ready | FCM token handling |
| Topics | ✅ Ready | Topic subscription/unsubscription |
| Callbacks | ✅ Ready | Custom notification handlers |
| Stream API | ✅ Ready | Reactive notification stream |

### 🔜 Preparati (da implementare)

| Servizio | Status | File |
|----------|--------|------|
| Analytics | 🔜 Ready | Uncomment code in firebase_manager.dart |
| Crashlytics | 🔜 Ready | Uncomment code in firebase_manager.dart |
| Remote Config | 🔜 Ready | Uncomment code in firebase_manager.dart |

## 📱 Payload Notifiche

### Formato Consigliato

```json
{
  "notification": {
    "title": "Nuovo Messaggio",
    "body": "Hai ricevuto un messaggio da Mario"
  },
  "data": {
    "type": "message",
    "screen": "/chat/123",
    "message_id": "msg_456",
    "sender_id": "user_789"
  }
}
```

### Gestione nel Codice

```dart
_firebaseManager.notificationStream.listen((notification) {
  final data = notification['data'] as Map<String, dynamic>?;
  
  if (data != null) {
    final type = data['type'];
    
    switch (type) {
      case 'message':
        _openChat(data['sender_id']);
        break;
      case 'order':
        _openOrder(data['order_id']);
        break;
      case 'promotion':
        _openPromotion(data['promo_id']);
        break;
    }
  }
});
```

## 🏗️ Integrazione con Riverpod

### Provider per Notifiche

```dart
// Provider per stream notifiche
final notificationStreamProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return FirebaseManager().notificationStream;
});

// Provider per FCM token
final fcmTokenProvider = Provider<String?>((ref) {
  return FirebaseManager().fcmToken;
});

// Provider per stato Firebase
final firebaseInitializedProvider = Provider<bool>((ref) {
  return FirebaseManager().isInitialized;
});
```

### Uso nei Widget

```dart
class NotificationListener extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationAsync = ref.watch(notificationStreamProvider);

    notificationAsync.when(
      data: (notification) {
        // Handle notification
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNotification(context, notification);
        });
        return SizedBox.shrink();
      },
      loading: () => SizedBox.shrink(),
      error: (error, stack) {
        print('Notification error: $error');
        return SizedBox.shrink();
      },
    );
  }
}
```

## 🎨 Best Practices

### ✅ DO

```dart
// Initialize early
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager().initialize();
  runApp(MyApp());
}

// Request permissions at appropriate time
await FirebaseManager().requestPermissions();

// Send token to backend
final token = FirebaseManager().fcmToken;
if (token != null) {
  await sendToBackend(token);
}

// Subscribe to relevant topics
await FirebaseManager().subscribeToTopic('user_$userId');

// Cleanup on logout
await FirebaseManager().unsubscribeFromTopic('user_$userId');
await FirebaseManager().deleteToken();
```

### ❌ DON'T

```dart
// Don't initialize multiple times
FirebaseManager().initialize(); // ❌ Already initialized

// Don't forget to handle permissions
final token = FirebaseManager().fcmToken; // ❌ May be null without permissions

// Don't ignore notification types
_firebaseManager.notificationStream.listen((n) {
  print(n); // ❌ Handle properly
});

// Don't forget cleanup
// ❌ No cleanup on logout = user still receives notifications
```

## 🐛 Troubleshooting

### Token è null

**Problema**: `FirebaseManager().fcmToken` ritorna null

**Soluzioni**:
1. Verifica permessi iOS: `await requestPermissions()`
2. Verifica Firebase inizializzato: `FirebaseManager().isInitialized`
3. Attendi inizializzazione: Token disponibile dopo `initialize()`
4. Controlla console Firebase per errori

### Notifiche non arrivano

**iOS**:
- Verifica capabilities: Push Notifications abilitato
- Verifica certificati APNs in Firebase Console
- Controlla permessi app nelle Settings iOS

**Android**:
- Verifica `google-services.json` presente
- Verifica permissions in AndroidManifest
- Controlla FCM sender ID

### Build fallisce

**Errore**: `FirebaseMessaging not found`

**Soluzione**:
```bash
flutter pub get
flutter clean
flutter pub get
```

### Token non si aggiorna

**Problema**: `onTokenRefresh` non viene chiamato

**Soluzione**:
```dart
// Force token refresh
await FirebaseManager().deleteToken();
await FirebaseManager().initialize();
```

## 📚 Prossimi Step

1. **Aggiungi Firebase packages** al `pubspec.yaml`
2. **Configura Firebase** per iOS e Android
3. **Uncomment il codice** in `firebase_manager.dart`
4. **Testa notifiche** via Firebase Console
5. **Implementa Analytics** (optional)
6. **Implementa Crashlytics** (optional)
7. **Implementa Remote Config** (optional)

## 📖 Riferimenti

- [Firebase Flutter](https://firebase.google.com/docs/flutter/setup)
- [Firebase Messaging](https://firebase.google.com/docs/cloud-messaging/flutter/client)
- [FlutterFire](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)

---

**Note**: Tutto il codice è già preparato e documentato. Basta aggiungere i package, configurare Firebase, e decommentare il codice necessario!
