# Core Managers

Gestione centralizzata di tutti i servizi dell'applicazione.

## 📁 Struttura

```
manager/
├── manager.dart                    # Export principale (usa questo)
├── firebase/                       # Servizi Firebase
│   ├── firebase_manager.dart      # Manager Firebase
│   ├── firebase_example.dart      # Esempi di utilizzo
│   ├── firebase.dart              # Export Firebase
│   ├── README.md                  # Documentazione completa
│   └── QUICKSTART.md              # Setup rapido 5 minuti
├── environment/                    # Configurazione ambiente
│   ├── environment_manager.dart   # Variabili ambiente
│   └── environment.dart           # Export Environment
├── routing/                        # Navigazione
│   ├── route_manager.dart         # GoRouter configuration
│   └── routing.dart               # Export Routing
├── storage/                        # Storage management
│   ├── storage_manager.dart       # Simple, secure & biometric storage
│   └── storage.dart               # Export Storage
└── ui/                            # Gestione UI
    ├── loading_manager.dart       # Loading indicators
    ├── modal_manager.dart         # Modal dialogs & bottom sheets
    ├── toast_manager.dart         # Toast notifications
    └── ui.dart                    # Export UI
```

## 🚀 Utilizzo

### Import Singolo (Consigliato)

```dart
// Importa tutti i manager
import 'package:project_architecture/core/manager/manager.dart';

// Usa i manager
final firebaseManager = FirebaseManager();
final loadingManager = LoadingManager();
final apiUrl = EnvironmentManager.apiUrl;
```

### Import Specifici

```dart
// Solo Firebase
import 'package:project_architecture/core/manager/firebase/firebase.dart';

// Solo UI managers
import 'package:project_architecture/core/manager/ui/ui.dart';

// Solo Environment
import 'package:project_architecture/core/manager/environment/environment.dart';

// Solo Routing
import 'package:project_architecture/core/manager/routing/routing.dart';

// Solo Storage
import 'package:project_architecture/core/manager/storage/storage.dart';
```

## 📚 Manager Disponibili

### 🔥 Firebase Manager

**Location**: `firebase/firebase_manager.dart`

**Funzionalità**:
- ✅ Push Notifications (Firebase Messaging)
- ✅ Token Management (FCM)
- ✅ Topic Subscription
- ✅ Analytics (preparato)
- ✅ Crashlytics (preparato)
- ✅ Remote Config (preparato)

**Utilizzo**:
```dart
// Initialize
await FirebaseManager().initialize();

// Get token
final token = FirebaseManager().fcmToken;

// Listen to notifications
FirebaseManager().notificationStream.listen((notification) {
  print('Received: ${notification['title']}');
});

// Subscribe to topic
await FirebaseManager().subscribeToTopic('news');
```

**Documentazione**: Vedi [firebase/README.md](firebase/README.md)

---

### 🌍 Environment Manager

**Location**: `environment/environment_manager.dart`

**Funzionalità**:
- ✅ Environment variables
- ✅ API URL configuration
- ✅ Version management

**Utilizzo**:
```dart
// Get environment
final env = EnvironmentManager.environment; // dev, production, mock

// Get API URL
final apiUrl = EnvironmentManager.apiUrl;

// Get version
final version = EnvironmentManager.version;
```

**Configuration**:
```bash
flutter run --dart-define=environment=dev \
            --dart-define=api-url=https://api.dev.example.com \
            --dart-define=version=1.0.0
```

---

### 🧭 Route Manager

**Location**: `routing/route_manager.dart`

**Funzionalità**:
- ✅ GoRouter configuration
- ✅ Navigation helpers
- ✅ Route guards (preparato)

**Utilizzo**:
```dart
// Get router
final router = router;

// Navigate
Navigate.back();

// Get current context
final context = Navigate.currentContext;
```

---

### 🎨 Loading Manager

**Location**: `ui/loading_manager.dart`

**Funzionalità**:
- ✅ Global loading indicator
- ✅ Multiple concurrent requests handling
- ✅ Overlay UI with CircularProgressIndicator
- ✅ Automatic context management via NavigatorKey

**Note**: Il LoadingManager utilizza automaticamente il `NavigatorKey` globale dal route_manager, non richiede configurazione del context.

**Utilizzo**:
```dart
// Show loading
LoadingManager().showLoading();

// Hide loading
LoadingManager().hideLoading();

// Force hide (reset counter)
LoadingManager().forceHide();

// Check if loading
final isLoading = LoadingManager().isLoading;

// Get loading count
final count = LoadingManager().loadingCount;
```

**Integrato con API**:
```dart
// Automatic con ApiCenter
await apiCenter.dio.get('/users'); // Loading automatico

// Senza loading
await apiCenter.dio.noLoader.get('/users');
```

---

### 🪟 Modal Manager

**Location**: `ui/modal_manager.dart`

**Funzionalità**:
- ✅ Stack-based modal management (LIFO)
- ✅ Automatic restoration of previous modals
- ✅ State preservation when modals are hidden
- ✅ Dialog and bottom sheet support
- ✅ Custom configurations
- ✅ Stream API for stack changes
- ✅ Type-safe results
- ✅ Nested modals support

**Utilizzo Base**:
```dart
final modalManager = ModalManager();

// Show dialog
await modalManager.showDialog(
  content: AlertDialog(
    title: Text('Titolo'),
    content: Text('Contenuto'),
    actions: [
      TextButton(
        onPressed: () => modalManager.closeCurrentModal(),
        child: Text('Chiudi'),
      ),
    ],
  ),
);

// Show bottom sheet
await modalManager.showBottomSheet(
  content: Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Bottom Sheet'),
        ElevatedButton(
          onPressed: () => modalManager.closeCurrentModal(),
          child: Text('Chiudi'),
        ),
      ],
    ),
  ),
);
```

**Come Funziona lo Stack**:
```
1. Open Modal A    → Stack: [A]                     → UI: A visible
2. Open Modal B    → Stack: [A(hidden), B(visible)] → UI: B visible, A preserved
3. Close Modal B   → Stack: [A(visible)]            → UI: A restored automatically
```

**Modali Annidate**:
```dart
// Form with confirmation dialog
await modalManager.showDialog(
  id: 'form',
  content: MyForm(
    onSave: () async {
      // Opens confirmation - form is hidden but state preserved
      final confirm = await modalManager.showDialog<bool>(
        id: 'confirm',
        content: ConfirmDialog(message: 'Salvare?'),
      );
      // Form automatically restored here with all data intact!
      if (confirm == true) {
        modalManager.closeModal('form');
      }
    },
  ),
);
```

**Modal con Risultato**:
```dart
final result = await modalManager.showDialog<String>(
  content: ChoiceDialog(),
);
if (result == 'A') {
  // Handle option A
}
```

**Configurazioni Predefinite**:
```dart
// Full screen modal
await modalManager.showBottomSheet(
  config: ModalConfig.fullScreen,
  content: MyFullScreenContent(),
);

// Custom configuration
await modalManager.showBottomSheet(
  config: ModalConfig(
    isScrollControlled: true,
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  ),
  content: MyContent(),
);
```

**API Reference**:
- `showModal<T>()` - Generic modal (dialog or bottom sheet)
- `showDialog<T>()` - Show dialog
- `showBottomSheet<T>()` - Show bottom sheet
- `closeModal(String id)` - Close specific modal
- `closeCurrentModal()` - Close top modal
- `closeAllModals()` - Close all modals
- `hasOpenModals` - Check if any modal is open
- `currentModal` - Get current visible modal
- `modalCount` - Number of modals in stack
- `modalStream` - Stream of stack changes

**Note**: Il ModalManager utilizza automaticamente il `NavigatorKey` globale, non richiede configurazione del context.

---

### 🍞 Toast Manager

**Location**: `ui/toast_manager.dart`

**Funzionalità**:
- ✅ Toast notifications
- ✅ Warning messages
- ✅ Error messages

**Utilizzo**:
```dart
final toastManager = ToastManager();

toastManager.show();
toastManager.showWarning();
toastManager.showError();
```

**TODO**: Implementare differenziazione tra show/showWarning/showError

---

### 💾 Storage Manager

**Location**: `storage/storage_manager.dart`

**Funzionalità**:
- ✅ **Simple Storage**: SharedPreferences (unencrypted, fast)
- ✅ **Secure Storage**: flutter_secure_storage (encrypted)
- ✅ **Biometric Storage**: Secure storage + biometric authentication
- ✅ JSON serialization support
- ✅ Multiple data types (String, int, double, bool, List)
- ✅ Storage statistics and debugging

**Livelli di Sicurezza**:

1. **Simple Storage** - Per dati non sensibili (preferenze UI, cache)
   - Veloce e non crittografato
   - Usa SharedPreferences
   - Esempio: tema scuro/chiaro, lingua, impostazioni UI

2. **Secure Storage** - Per dati sensibili (token, credenziali)
   - Crittografato con AES
   - Usa Keychain (iOS) / KeyStore (Android)
   - Esempio: auth token, API keys, password

3. **Biometric Storage** - Per dati critici (PIN, dati finanziari)
   - Secure storage + autenticazione biometrica
   - Richiede Face ID / Touch ID / Fingerprint
   - Esempio: PIN bancario, dati carte credito

**Inizializzazione**:
```dart
final storage = StorageManager();
await storage.initialize();
```

**Simple Storage (Non Crittografato)**:
```dart
// String
await storage.saveSimple('theme', 'dark');
final theme = storage.readSimple('theme'); // 'dark'

// Int
await storage.saveSimpleInt('loginCount', 5);
final count = storage.readSimpleInt('loginCount'); // 5

// Bool
await storage.saveSimpleBool('notifications', true);
final enabled = storage.readSimpleBool('notifications'); // true

// List
await storage.saveSimpleList('favorites', ['item1', 'item2']);
final favorites = storage.readSimpleList('favorites'); // ['item1', 'item2']

// JSON
await storage.saveSimpleJson('user', {'name': 'Mario', 'age': 30});
final user = storage.readSimpleJson('user'); // {'name': 'Mario', 'age': 30}

// Check existence
final exists = storage.hasSimple('theme'); // true

// Delete
await storage.deleteSimple('theme');

// Get all keys
final keys = storage.getAllSimpleKeys(); // Set<String>

// Clear all
await storage.clearSimple();
```

**Secure Storage (Crittografato)**:
```dart
// String
await storage.saveSecure('authToken', 'abc123xyz');
final token = await storage.readSecure('authToken'); // 'abc123xyz'

// JSON
await storage.saveSecureJson('credentials', {
  'username': 'mario@example.com',
  'refreshToken': 'xyz789',
});
final creds = await storage.readSecureJson('credentials');

// Check existence
final exists = await storage.hasSecure('authToken'); // true

// Delete
await storage.deleteSecure('authToken');

// Get all secure data
final allSecure = await storage.getAllSecure(); // Map<String, String>

// Clear all
await storage.clearSecure();
```

**Biometric Storage (Secure + Biometria)**:
```dart
// Check if biometric is available
final isAvailable = await storage.isBiometricAvailable();
if (!isAvailable) {
  print('Biometric authentication not available');
  return;
}

// Get available biometric types
final types = await storage.getAvailableBiometrics();
// [BiometricType.face, BiometricType.fingerprint]

// Save with biometric (requires authentication)
final saved = await storage.saveBiometric(
  'bankPin',
  '1234',
  reason: 'Autenticarsi per salvare il PIN',
);
if (!saved) {
  print('Authentication failed');
}

// Read with biometric (requires authentication)
final pin = await storage.readBiometric(
  'bankPin',
  reason: 'Autenticarsi per accedere al PIN',
);
// Returns null if authentication fails

// JSON
await storage.saveBiometricJson('payment', {
  'cardNumber': '1234567890',
  'cvv': '123',
});
final payment = await storage.readBiometricJson('payment');

// Delete (requires authentication)
final deleted = await storage.deleteBiometric(
  'bankPin',
  reason: 'Autenticarsi per eliminare il PIN',
);

// Check existence (no auth required)
final exists = await storage.hasBiometric('bankPin');

// Clear all biometric data (requires authentication)
final cleared = await storage.clearBiometric(
  reason: 'Autenticarsi per eliminare tutti i dati protetti',
);
```

**Utility Methods**:
```dart
// Clear all storage types
await storage.clearAll(
  biometricReason: 'Autenticarsi per eliminare tutti i dati',
);

// Get storage statistics
final stats = await storage.getStorageStats();
// {
//   'simple': 5,
//   'secure': 3,
//   'biometric': 2,
//   'total': 10,
//   'biometric_available': true
// }

// Print stats (debug only)
await storage.printStats();
// 📊 Storage Statistics:
//    Simple keys: 5
//    Secure keys: 3
//    Biometric keys: 2
//    Total keys: 10
//    Biometric available: true
```

**Esempi Pratici**:

```dart
// Login flow
class AuthService {
  final storage = StorageManager();

  Future<void> login(String email, String password) async {
    // ... perform login

    // Save auth token (secure)
    await storage.saveSecure('authToken', token);

    // Save user preferences (simple)
    await storage.saveSimpleBool('rememberMe', true);
    await storage.saveSimple('lastEmail', email);
  }

  Future<void> enableBiometric() async {
    final isAvailable = await storage.isBiometricAvailable();
    if (!isAvailable) throw Exception('Biometric not available');

    // Save sensitive data with biometric protection
    final saved = await storage.saveBiometric(
      'userPin',
      '1234',
      reason: 'Autenticarsi per abilitare l\'accesso biometrico',
    );

    if (saved) {
      await storage.saveSimpleBool('biometricEnabled', true);
    }
  }

  Future<bool> biometricLogin() async {
    final pin = await storage.readBiometric(
      'userPin',
      reason: 'Autenticarsi per accedere',
    );
    return pin != null;
  }
}
```

**Best Practices**:

```dart
// ✅ DO: Use appropriate security level
await storage.saveSimple('theme', 'dark');           // UI preferences
await storage.saveSecure('authToken', token);         // Auth data
await storage.saveBiometric('bankPin', pin);          // Critical data

// ✅ DO: Initialize once at app startup
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager().initialize();
  runApp(MyApp());
}

// ✅ DO: Handle biometric failures gracefully
final pin = await storage.readBiometric('pin');
if (pin == null) {
  // User canceled or authentication failed
  showDialog('Autenticazione fallita');
  return;
}

// ❌ DON'T: Store sensitive data in simple storage
await storage.saveSimple('password', 'secret'); // ❌ Use saveSecure!

// ❌ DON'T: Use biometric for non-critical data
await storage.saveBiometric('theme', 'dark'); // ❌ Use saveSimple!

// ❌ DON'T: Forget to check availability
await storage.saveBiometric('pin', '1234'); // ❌ Check availability first!
```

**Platform Configuration**:

**Android** (android/app/src/main/AndroidManifest.xml):
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<!-- Or for older API levels -->
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

**iOS** (ios/Runner/Info.plist):
```xml
<key>NSFaceIDUsageDescription</key>
<string>Autenticazione richiesta per accedere ai dati protetti</string>
```

**Note**:
- Simple storage è sincrono per lettura, asincrono per scrittura
- Secure storage è sempre asincrono
- Biometric storage richiede autenticazione per lettura/scrittura/eliminazione
- Il manager è un singleton thread-safe

---

## 🔧 Dependency Injection

Tutti i manager sono registrati come singleton in `dI_setup.dart`:

```dart
// Core services - Singletons that persist throughout app lifecycle
sl.registerLazySingleton<FocusRegistry>(() => FocusRegistry());
sl.registerLazySingleton<ApiCenter>(() => ApiCenter());
sl.registerLazySingleton<LoadingManager>(() => LoadingManager());
sl.registerLazySingleton<ModalManager>(() => ModalManager());
sl.registerLazySingleton<FirebaseManager>(() => FirebaseManager());
sl.registerLazySingleton<StorageManager>(() => StorageManager());
```

**Utilizzo con GetIt**:
```dart
import 'package:project_architecture/injection_container.dart';

// Get instance
final firebaseManager = sl<FirebaseManager>();
final loadingManager = sl<LoadingManager>();
```

**Utilizzo con Riverpod**:
```dart
// Create provider
final firebaseManagerProvider = Provider<FirebaseManager>((ref) {
  return sl<FirebaseManager>();
});

// Use in widget
final firebaseManager = ref.watch(firebaseManagerProvider);
```

---

## 📋 Checklist Setup

### Firebase (Quando Necessario)

- [ ] Aggiungi packages Firebase al `pubspec.yaml`
- [ ] Esegui `flutterfire configure`
- [ ] Decommenta codice in `firebase_manager.dart`
- [ ] Inizializza in `main.dart`
- [ ] Testa notifiche da Firebase Console

### Environment

- [x] ✅ Già configurato
- [ ] Imposta variabili con `--dart-define`

### Routing

- [x] ✅ Già configurato
- [ ] Aggiungi route guards (opzionale)

### Loading

- [x] ✅ Integrato con ApiCenter
- [x] ✅ Pronto all'uso

### Toast

- [ ] Implementare differenziazione messaggi

---

## 🎯 Best Practices

### ✅ DO

```dart
// Use singleton instances
final manager = FirebaseManager();

// Import from manager.dart
import 'package:project_architecture/core/manager/manager.dart';

// Handle errors
try {
  await operation();
} catch (e) {
  LoadingManager().forceHide();
  ToastManager().showError();
}

// Cleanup on dispose
@override
void dispose() {
  FirebaseManager().dispose();
  super.dispose();
}
```

### ❌ DON'T

```dart
// Don't create new instances
final manager = new FirebaseManager(); // ❌

// Don't import from deep paths when manager.dart exists
import 'package:project_architecture/core/manager/ui/loading_manager.dart'; // ❌

// Don't forget to hide loading on errors
try {
  LoadingManager().showLoading();
  await operation();
} catch (e) {
  // ❌ Loading rimane attivo
}

// Don't use print for production
print('Error'); // ❌ Use proper logging
```

---

## 🚀 Quick Start

```dart
// 1. Import manager
import 'package:project_architecture/core/manager/manager.dart';

// 2. Initialize Firebase (opzionale)
await FirebaseManager().initialize();

// 3. Use managers
LoadingManager().showLoading();
final data = await apiCenter.dio.get('/data');
LoadingManager().hideLoading();

// 4. Handle notifications
FirebaseManager().notificationStream.listen((notification) {
  ToastManager().show(); // Mostra notifica
});
```

---

## 📖 Documentazione Dettagliata

- **Firebase**: [firebase/README.md](firebase/README.md) - Setup completo, esempi, troubleshooting
- **Firebase Quick Start**: [firebase/QUICKSTART.md](firebase/QUICKSTART.md) - Setup in 5 minuti
- **API Center**: [../api_center/README.md](../api_center/README.md) - Integrazione LoadingManager

---

## 🔮 Future Enhancements

- [ ] **Permission Manager**: Gestione permessi device
- [x] **Storage Manager**: Local storage con 3 livelli di sicurezza ✅
- [ ] **Cache Manager**: Caching strategico
- [ ] **Network Manager**: Network connectivity monitoring
- [ ] **Theme Manager**: Dark/light theme switching
- [ ] **Localization Manager**: Dynamic language switching
- [ ] **Deep Link Manager**: Deep link handling

---

**Nota**: Tutti i manager sono singleton e thread-safe. Usa `manager.dart` per import centralizzato.
