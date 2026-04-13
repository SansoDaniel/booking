# Navigation Middleware System

Sistema completo di middleware per la gestione della navigazione in Flutter con GoRouter.

## 📋 Indice

- [Panoramica](#panoramica)
- [Middleware Disponibili](#middleware-disponibili)
- [Utilizzo Base](#utilizzo-base)
- [Creare Middleware Personalizzati](#creare-middleware-personalizzati)
- [API Reference](#api-reference)
- [Esempi Pratici](#esempi-pratici)

---

## 🎯 Panoramica

Il sistema di middleware permette di intercettare e gestire eventi di navigazione prima che la route venga visualizzata. È utile per:

- ✅ **Autenticazione** - Verificare se l'utente è loggato
- ✅ **Logging** - Tracciare tutte le navigazioni
- ✅ **Analytics** - Inviare eventi a Firebase/Mixpanel
- ✅ **Permessi** - Verificare permessi device
- ✅ **Onboarding** - Gestire first-time user experience
- ✅ **A/B Testing** - Routing condizionale basato su esperimenti
- ✅ **Feature Flags** - Bloccare accesso a feature disabilitate

---

## 📦 Middleware Disponibili

### 1. AuthMiddleware

**Priority**: 10 (eseguito per primo)

**Scopo**: Verifica autenticazione utente e reindirizza al login se necessario.

**Features**:
- ✅ Controllo token da StorageManager
- ✅ Route pubbliche configurabili
- ✅ Redirect automatico con return URL
- ✅ Fail-safe su errori

**Configurazione**:
```dart
AuthMiddleware(
  storage: sl<StorageManager>(),
  loginRoute: '/login',
  publicRoutes: ['/login', '/splash', '/register'],
)
```

---

### 2. LoggingMiddleware

**Priority**: 50 (eseguito nel mezzo)

**Scopo**: Log dettagliati di ogni navigazione (solo in debug mode).

**Features**:
- ✅ Log automatico solo in debug
- ✅ Formato leggibile con box drawing
- ✅ Include path, query params, path params
- ✅ Timestamp per ogni navigazione
- ✅ Modalità verbose opzionale

**Configurazione**:
```dart
const LoggingMiddleware(
  verbose: true, // Include extra data
)
```

**Output esempio**:
```
┌──────────────────────────────────────────
│ 🧭 Navigation Event
├──────────────────────────────────────────
│ Path: /dashboard
│ Query Params: {tab: settings}
│ Timestamp: 2025-11-20T12:30:45.123Z
└──────────────────────────────────────────
```

---

### 3. AnalyticsMiddleware

**Priority**: 90 (eseguito per ultimo)

**Scopo**: Traccia screen views per analytics.

**Features**:
- ✅ Integrazione pronta per Firebase Analytics
- ✅ Route escluse configurabili
- ✅ Estrazione automatica screen name
- ✅ Parametri query inclusi
- ✅ Gestione errori graceful

**Configurazione**:
```dart
const AnalyticsMiddleware(
  enabled: true,
  excludedRoutes: ['/splash'], // Non tracciare splash
)
```

**Integrazione Firebase**:
```dart
// Decommentare quando Firebase è configurato:
await FirebaseAnalytics.instance.logScreenView(
  screenName: screenName,
  screenClass: path,
);
```

---

## 🚀 Utilizzo Base

### 1. Inizializzazione Automatica

Il sistema si inizializza automaticamente all'avvio dell'app in `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ... altre inizializzazioni

  setupNavigationMiddleware(); // ← Inizializza middleware

  runApp(const MyApp());
}
```

### 2. Configurazione Predefinita

I middleware sono già configurati in `middleware_setup.dart`:

```dart
void setupNavigationMiddleware() {
  final manager = MiddlewareManager();

  // 1. Auth (priority: 10)
  manager.register(AuthMiddleware(...));

  // 2. Logging (priority: 50)
  manager.register(LoggingMiddleware(...));

  // 3. Analytics (priority: 90)
  manager.register(AnalyticsMiddleware(...));

  manager.printChain(); // Debug: stampa catena middleware
}
```

### 3. Integrazione con GoRouter

Il routing è già configurato per usare i middleware:

```dart
final GoRouter router = GoRouter(
  redirect: (context, state) async {
    // Esegui catena middleware
    final result = await MiddlewareManager().execute(context, state);

    if (result != null) {
      return result; // Redirect richiesto da middleware
    }

    return null; // Procedi con navigazione normale
  },
);
```

---

## 🛠️ Creare Middleware Personalizzati

### Esempio: PermissionMiddleware

```dart
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'navigation_middleware.dart';

class PermissionMiddleware extends NavigationMiddleware {
  final Map<String, Permission> routePermissions;

  const PermissionMiddleware({
    required this.routePermissions,
  });

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    final path = state.matchedLocation;

    // Check if route requires permission
    final requiredPermission = routePermissions[path];
    if (requiredPermission == null) {
      return const MiddlewareResult.proceed();
    }

    // Check permission status
    final status = await requiredPermission.status;

    if (status.isGranted) {
      return const MiddlewareResult.proceed();
    }

    // Permission not granted - redirect to permission request
    return const MiddlewareResult.redirect('/permission-request');
  }

  @override
  int get priority => 20; // After auth, before logging

  @override
  String get name => 'PermissionMiddleware';
}
```

### Registrazione:

```dart
MiddlewareManager().register(
  PermissionMiddleware(
    routePermissions: {
      '/camera': Permission.camera,
      '/gallery': Permission.photos,
      '/location': Permission.location,
    },
  ),
);
```

---

### Esempio: OnboardingMiddleware

```dart
class OnboardingMiddleware extends NavigationMiddleware {
  final StorageManager storage;
  final String onboardingRoute;

  const OnboardingMiddleware({
    required this.storage,
    this.onboardingRoute = '/onboarding',
  });

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Skip if already on onboarding
    if (state.matchedLocation == onboardingRoute) {
      return const MiddlewareResult.proceed();
    }

    // Check if onboarding completed
    final completed = storage.readSimpleBool('onboarding_completed') ?? false;

    if (!completed) {
      return MiddlewareResult.redirect(onboardingRoute);
    }

    return const MiddlewareResult.proceed();
  }

  @override
  int get priority => 15; // After auth, before logging

  @override
  String get name => 'OnboardingMiddleware';
}
```

---

### Esempio: FeatureFlagMiddleware

```dart
class FeatureFlagMiddleware extends NavigationMiddleware {
  final Map<String, bool> featureFlags;
  final String blockedRoute;

  const FeatureFlagMiddleware({
    required this.featureFlags,
    this.blockedRoute = '/feature-disabled',
  });

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    final path = state.matchedLocation;

    // Check if route requires feature flag
    for (final entry in featureFlags.entries) {
      if (path.startsWith(entry.key) && !entry.value) {
        return MiddlewareResult.redirect(blockedRoute);
      }
    }

    return const MiddlewareResult.proceed();
  }

  @override
  int get priority => 30;

  @override
  String get name => 'FeatureFlagMiddleware';
}
```

---

## 📚 API Reference

### MiddlewareResult

```dart
// Allow navigation
const MiddlewareResult.proceed()

// Redirect to another route
const MiddlewareResult.redirect(String path, {Map<String, dynamic>? data})

// Block navigation completely
const MiddlewareResult.block()
```

### MiddlewareManager

```dart
// Get singleton instance
final manager = MiddlewareManager();

// Register middleware
manager.register(MyMiddleware());

// Register multiple
manager.registerAll([
  AuthMiddleware(),
  LoggingMiddleware(),
]);

// Remove middleware
manager.remove<AuthMiddleware>();

// Check if registered
final hasAuth = manager.has<AuthMiddleware>();

// Get instance
final auth = manager.get<AuthMiddleware>();

// Clear all
manager.clear();

// Print chain
manager.printChain();

// Execute chain
final result = await manager.execute(context, state);
```

### NavigationMiddleware (Base Class)

```dart
abstract class NavigationMiddleware {
  // Execute middleware logic
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  );

  // Priority (lower = executed first)
  int get priority => 100;

  // Name for debugging
  String get name;
}
```

---

## 💡 Esempi Pratici

### Esempio 1: Protezione Route Privata

```dart
// User cerca di accedere a /dashboard senza essere loggato

1. AuthMiddleware (priority: 10)
   - Controlla token
   - Non trovato
   - ❌ Redirect a /login?redirectTo=/dashboard

2. LoggingMiddleware (priority: 50)
   - Non eseguito (redirect già richiesto)

3. AnalyticsMiddleware (priority: 90)
   - Non eseguito

Risultato: Utente reindirizzato a /login
```

---

### Esempio 2: Navigazione Normale

```dart
// User loggato naviga a /settings

1. AuthMiddleware (priority: 10)
   - Controlla token
   - Trovato ✅
   - Procede

2. LoggingMiddleware (priority: 50)
   - Log: "Navigation to /settings"
   - Procede

3. AnalyticsMiddleware (priority: 90)
   - Track: "Screen View: Settings"
   - Procede

Risultato: Navigazione a /settings completata
```

---

### Esempio 3: Catena con Blocco

```dart
// User senza permessi cerca di accedere a /camera

1. AuthMiddleware (priority: 10)
   - Token OK ✅
   - Procede

2. PermissionMiddleware (priority: 20)
   - Camera permission: denied
   - ❌ Redirect a /permission-request

3. LoggingMiddleware (priority: 50)
   - Non eseguito

Risultato: Utente reindirizzato a /permission-request
```

---

## 🔧 Debugging

### Stampare la Catena

```dart
MiddlewareManager().printChain();

// Output:
// 📋 Middleware Chain (3 middleware):
//    1. AuthMiddleware (priority: 10)
//    2. LoggingMiddleware (priority: 50)
//    3. AnalyticsMiddleware (priority: 90)
```

### Verificare Registrazione

```dart
if (!MiddlewareManager().has<AuthMiddleware>()) {
  debugPrint('⚠️ AuthMiddleware not registered!');
}
```

---

## ⚡ Performance

- **Overhead**: ~1-5ms per navigazione (dipende da numero middleware)
- **Caching**: Token auth viene letto da storage (cache interno di StorageManager)
- **Async**: Tutti i middleware sono async-safe
- **Fail-safe**: Errori in middleware non bloccano l'app (fail-open)

---

## 🎯 Best Practices

### ✅ DO

```dart
// Use priority appropriately
class AuthMiddleware {
  int get priority => 10; // First
}

class LoggingMiddleware {
  int get priority => 50; // Middle
}

class AnalyticsMiddleware {
  int get priority => 90; // Last
}

// Handle errors gracefully
try {
  final result = await someAsyncOperation();
  return const MiddlewareResult.proceed();
} catch (e) {
  debugPrint('Middleware error: $e');
  return const MiddlewareResult.proceed(); // Fail-open
}

// Use descriptive names
String get name => 'MyCustomMiddleware';
```

### ❌ DON'T

```dart
// Don't block navigation without good reason
return const MiddlewareResult.block(); // ❌ User is stuck!

// Don't do heavy computation
Future<MiddlewareResult> execute(...) async {
  await Future.delayed(Duration(seconds: 5)); // ❌ Slow!
  return proceed();
}

// Don't throw unhandled exceptions
throw Exception('Error'); // ❌ Will crash app

// Don't forget to register
// Missing: MiddlewareManager().register(MyMiddleware()); ❌
```

---

## 🚦 Ordine di Esecuzione Raccomandato

| Priority | Middleware | Motivo |
|----------|-----------|--------|
| 10 | Auth | Verifica autenticazione per prima |
| 20 | Permission | Verifica permessi se autenticato |
| 30 | Feature Flags | Verifica feature disponibili |
| 40 | Onboarding | Gestisce prima esperienza utente |
| 50 | Logging | Log dopo controlli critici |
| 60-80 | Custom | I tuoi middleware |
| 90 | Analytics | Track dopo tutti i controlli |

---

## 📖 Riferimenti

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter Navigation](https://docs.flutter.dev/development/ui/navigation)
- [StorageManager](../storage/README.md)

---

**Made with ❤️ for Flutter**
