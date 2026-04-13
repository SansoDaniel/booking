# Firebase Quick Start Guide

Guida rapida per attivare Firebase nel progetto.

## 🚀 Setup in 5 Minuti

### Step 1: Aggiungi Packages (2 min)

Nel `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.8.1
  firebase_messaging: ^15.1.5
```

```bash
flutter pub get
```

### Step 2: Configura Firebase (2 min)

```bash
# Install FlutterFire CLI (solo prima volta)
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

Segui le istruzioni e seleziona il progetto Firebase.

### Step 3: Attiva il Codice (1 min)

Nel file `firebase_manager.dart`, cerca tutti i `// TODO: Uncomment` e decommenta il codice.

**Esempio**:

```dart
// Prima:
// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

// Dopo:
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Step 4: Inizializza in main.dart

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
  
  // Initialize Manager
  await FirebaseManager().initialize();
  
  runApp(MyApp());
}
```

### Step 5: Testa

Invia una notifica di test dalla [Firebase Console](https://console.firebase.google.com/).

## 📱 iOS Setup Aggiuntivo

### Info.plist

Aggiungi in `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### Xcode Capabilities

1. Apri `ios/Runner.xcworkspace` in Xcode
2. Seleziona Runner target
3. Signing & Capabilities
4. Aggiungi:
   - Push Notifications
   - Background Modes → Remote notifications

### APNs Key

1. Vai su [Apple Developer](https://developer.apple.com/account/resources/authkeys/list)
2. Crea APNs Key
3. Scarica il file `.p8`
4. Carica in Firebase Console → Project Settings → Cloud Messaging

## 🤖 Android Setup Aggiuntivo

### Permissions

Già configurato in `AndroidManifest.xml`.

### Google Services

Già configurato se hai eseguito `flutterfire configure`.

## ✅ Verifica Funzionamento

```dart
void testFirebase() {
  final manager = FirebaseManager();
  
  print('Initialized: ${manager.isInitialized}');
  print('Token: ${manager.fcmToken}');
  
  if (manager.isInitialized && manager.fcmToken != null) {
    print('✅ Firebase funziona!');
  } else {
    print('❌ Controlla configurazione');
  }
}
```

## 🎯 Prossimi Passi

1. ✅ Setup completato
2. 📱 Testa notifiche dalla console
3. 🔔 Implementa gestione notifiche custom
4. 📊 Aggiungi Analytics (optional)
5. 🐛 Aggiungi Crashlytics (optional)
6. ⚙️ Aggiungi Remote Config (optional)

## 📚 Documentazione Completa

Vedi [FIREBASE_README.md](./FIREBASE_README.md) per:
- Esempi completi
- Best practices
- Integrazione con Riverpod
- Troubleshooting
- Tutti i servizi Firebase

## 🆘 Problemi Comuni

### "Firebase not initialized"

**Soluzione**: Chiama `await FirebaseManager().initialize()` in main.dart

### "Token is null"

**Soluzione iOS**: Richiedi permessi con `await requestPermissions()`

**Soluzione Android**: Verifica `google-services.json`

### Build fallisce

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

---

**Tempo totale**: ~5 minuti + configurazione Firebase Console

**Difficoltà**: ⭐️⭐️☆☆☆ (Facile)
