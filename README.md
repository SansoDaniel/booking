# 🏗️ Project Architecture

A production-ready Flutter application with clean architecture, advanced state management, and comprehensive developer tools.

[![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?logo=dart)](https://dart.dev)

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Development Tools](#-development-tools)
- [Core Managers](#-core-managers)
- [State Management](#-state-management)
- [Navigation & Routing](#-navigation--routing)
- [Testing](#-testing)
- [Contributing](#-contributing)

## ✨ Features

### 🎯 Core Features
- **Clean Architecture** - Separation of concerns with clear boundaries
- **Feature-First Structure** - Organized by business features (public/private)
- **State Management** - Riverpod with StateNotifier pattern
- **Dependency Injection** - GetIt + Injectable for service management
- **Type-Safe Routing** - GoRouter with code generation
- **Multi-Environment** - Dev/Prod configurations with dart-define
- **Secure Storage** - Three-level security (memory, encrypted, biometric)
- **Network Layer** - Dio with interceptors and error handling
- **Global Error Handling** - Comprehensive error catching and logging
- **Navigation Middleware** - Authentication, logging, and analytics

### 🛠️ Developer Tools
- **Feature Generator** - CLI tool to scaffold new features
- **Custom Bricks** - Mason templates for consistent code
- **Hot Reload** - Fast development iteration
- **Debug Tools** - Logging, analytics, and performance monitoring

## 🏛️ Architecture

This project follows **Clean Architecture** principles with a **feature-first** approach:

```
lib/
├── core/                   # Core application infrastructure
│   ├── api_center/         # API client and interceptors
│   ├── extensions/         # Dart extensions (Future, String, etc.)
│   ├── manager/            # Core managers (Storage, UI, Routing)
│   ├── models/             # Base models and states
│   └── utils/              # Utilities and helpers
├── features/               # Business features
│   ├── public/             # Public features (no auth required)
│   │   ├── splash/
│   │   └── login/
│   └── private/            # Private features (auth required)
│       ├── home/
│       ├── dashboard/
│       └── settings/
├── routes/                 # Route definitions and generation
└── main.dart               # Application entry point
```

### Feature Structure

Each feature follows a consistent pattern:

```
feature_name/
├── views/                # UI screens
│   └── feature_view.dart
├── providers/           # State management
│   ├── feature_notifier.dart
│   ├── feature_state.dart
│   ├── feature_provider.dart
│   └── feature_interceptor.dart
├── services/            # Business logic
│   └── feature_service.dart
└── feature.dart        # Barrel export
```

## 📁 Project Structure

```
project_architecture/
├── lib/
│   ├── core/
│   │   ├── api/
│   │   │   ├── api_center.dart           # Dio client configuration
│   │   │   └── interceptors/            # Request/response interceptors
│   │   ├── extensions/
│   │   │   ├── future_extension.dart    # Future utilities (retry, timeout, etc.)
│   │   │   └── string_extension.dart    # String helpers
│   │   ├── manager/
│   │   │   ├── environment/            # Environment configuration
│   │   │   ├── storage/               # Secure storage manager
│   │   │   ├── routing/              # Navigation & middleware
│   │   │   ├── ui/                  # Toast, Modal, Loading managers
│   │   │   └── firebase/           # Firebase integration
│   │   └── models/
│   │       └── app_state.dart     # Base state class
│   ├── features/
│   │   ├── public/
│   │   │   ├── splash/           # Splash screen
│   │   │   └── login/           # Login & authentication
│   │   └── private/
│   │       ├── home/           # Home dashboard
│   │       ├── dashboard/     # Analytics dashboard
│   │       └── settings/     # User settings
│   ├── routes/
│   │   ├── routes.dart      # routes declaration
│   ├── dI_setup.dart          # Dependency injection setup
│   ├── injection_container.dart
│   └── main.dart             # App entry point
├── local_plugins/
│   ├── design_system/        # Custom UI components
│   ├── localization/        # i18n support
├── development/
│   └── feature_gen/        # Feature generator CLI
├── environments/
│   ├── dev.json           # Development config
│   └── prod.json         # Production config
├── bricks/               # Mason templates
└── test/                # Unit & widget tests
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.7.2`
- Dart SDK: `>=3.7.2`
- IDE: VS Code or Android Studio

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd project_architecture
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   # Generate routes
   dart run build_runner build --delete-conflicting-outputs

   # Or watch for changes
   dart run build_runner watch --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # Development environment
   flutter run --dart-define-from-file=environments/dev.json

   # Production environment
   flutter run --dart-define-from-file=environments/prod.json
   ```

### Environment Configuration

Environment variables are defined in JSON files:

**`environments/dev.json`**
```json
{
  "APP_NAME": "MyApp Dev",
  "API_BASE_URL": "https://api-dev.example.com",
  "ENVIRONMENT": "dev"
}
```

**`environments/prod.json`**
```json
{
  "APP_NAME": "MyApp",
  "API_BASE_URL": "https://api.example.com",
  "ENVIRONMENT": "prod"
}
```

Access in code via `EnvironmentManager`:
```dart
final apiUrl = EnvironmentManager.apiBaseUrl;
final env = EnvironmentManager.environment;
```

## 🛠️ Development Tools

### Feature Generator

Generate a complete feature structure with one command:

```bash
dart run development/feature_gen/generation.dart {featureName} {path}
```

**Example:**
```bash
# Generate a public feature
dart run development/feature_gen/generation.dart profile lib/features/public

# Generate a private feature
dart run development/feature_gen/generation.dart analytics lib/features/private
```

This creates:
```
feature_name/
├── views/feature_view.dart
├── providers/
│   ├── feature_notifier.dart
│   ├── feature_state.dart
│   ├── feature_provider.dart
│   └── feature_interceptor.dart
└── feature.dart
```

## 🎯 Core Managers

### StorageManager

Three-level secure storage system:

```dart
final storage = sl<StorageManager>();
await storage.initialize();

// Level 1: Memory cache (fast, session-only)
await storage.write('theme', 'dark');
final theme = await storage.read('theme');

// Level 2: Encrypted storage (persisted, encrypted)
await storage.writeSecure('auth_token', token);
final token = await storage.readSecure('auth_token');

// Level 3: Biometric-protected (highest security)
await storage.writeBiometric('sensitive_data', data);
final data = await storage.readBiometric('sensitive_data');
```

**Features:**
- Memory cache for fast access
- Encrypted persistent storage (flutter_secure_storage)
- Biometric authentication (fingerprint/face ID)
- Automatic cleanup and error handling

### LoadingManager

Global loading state management:

```dart
final loadingManager = sl<LoadingManager>();

// Show loading
loadingManager.show();

// Hide loading
loadingManager.hide();

// Check state
if (loadingManager.isLoading) {
  // Handle loading state
}
```

### ToastManager

Beautiful toast notifications:

```dart
final toastManager = sl<ToastManager>();

// Success toast
toastManager.showSuccess(
  title: 'Success',
  message: 'Operation completed',
);

// Error toast
toastManager.showError(
  title: 'Error',
  message: 'Something went wrong',
);

// Info toast
toastManager.showInfo(
  title: 'Info',
  message: 'Important information',
);
```

### ModalManager ⚠️ Work in progress

Centralized modal/dialog management:

```dart
final modalManager = sl<ModalManager>();

// Show custom modal
await modalManager.show(
  child: CustomDialog(),
  barrierDismissible: true,
);

// Show confirmation dialog
final confirmed = await modalManager.showConfirmation(
  title: 'Confirm Action',
  message: 'Are you sure?',
);
```

## 🔄 State Management

State management uses **Riverpod** with the **StateNotifier** pattern:

### Creating a State

```dart
class LoginState extends AppState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserData? user;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserData? user,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isAuthenticated, user, error];
}
```

### Creating a Notifier

```dart
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._loginService) : super(LoginState());

  final LoginService _loginService;

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _loginService.login(email, password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    // Logout logic
    state = LoginState(); // Reset to initial state
  }
}
```

### Creating a Provider

```dart
final loginProvider =
    AutoDisposeStateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(sl<LoginService>()),
);
```

### Using in UI

```dart
class LoginView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    if (loginState.isLoading) {
      return const CircularProgressIndicator();
    }

    return ElevatedButton(
      onPressed: () => loginNotifier.login(email, password),
      child: const Text('Login'),
    );
  }
}
```

## 🧭 Navigation & Routing

### Type-Safe Navigation

```dart
// Navigate to a route
context.push(HomeRoute().location);

// Navigate with parameters
context.push(ProfileRoute(userId: '123').location);

// Go back
Navigate.back();

// Replace current route
context.replace(LoginRoute().location);
```

### Navigation Middleware

The app includes a powerful middleware system for navigation:

#### 1. AuthMiddleware
Protects private routes and redirects unauthenticated users:

```dart
// Public routes (accessible to everyone)
final publicRoutes = ['/login', '/splash', '/register'];

// Private routes automatically require authentication
```

**Priority:** `10` (executes first)

#### 2. LoggingMiddleware
Logs all navigation events in debug mode:

```
┌──────────────────────────────────────────
│ 🧭 Navigation Event
├──────────────────────────────────────────
│ Path: /home
│ Timestamp: 2025-01-20T10:30:45.123Z
└──────────────────────────────────────────
```

**Priority:** `50`

#### 3. AnalyticsMiddleware
Tracks screen views for analytics:

```dart
// Automatically tracks all navigation
// Configurable excluded routes
```

**Priority:** `90` (executes last)

### Creating Custom Middleware

```dart
class CustomMiddleware extends NavigationMiddleware {
  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Your custom logic

    // Allow navigation
    return const MiddlewareResult.proceed();

    // Or redirect
    return MiddlewareResult.redirect('/login');

    // Or block
    return const MiddlewareResult.block();
  }

  @override
  int get priority => 50; // Lower = executes first

  @override
  String get name => 'CustomMiddleware';
}

// Register it in middleware_setup.dart
MiddlewareManager().register(CustomMiddleware());
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/login/login_test.dart
```

### Test Structure

```
test/
├── features/
│   ├── login/
│   │   ├── login_notifier_test.dart
│   │   └── login_service_test.dart
│   └── home/
├── core/
│   ├── extensions/
│   └── managers/
└── helpers/
    └── test_helpers.dart
```

## 🎨 Code Style

### Formatting

```bash
# Format code
dart format .

# Analyze code
flutter analyze
```

### Naming Conventions

- **Classes**: PascalCase (`LoginNotifier`, `UserModel`)
- **Files**: snake_case (`login_notifier.dart`, `user_model.dart`)
- **Variables**: camelCase (`isLoading`, `userName`)
- **Constants**: lowerCamelCase (`defaultTimeout`, `maxRetries`)
- **Private**: Prefix with `_` (`_loginService`, `_handleError`)

## 🔐 Security Best Practices

1. **Never commit sensitive data** to version control
2. **Use environment variables** for API keys and secrets
3. **Enable biometric storage** for sensitive user data
4. **Implement proper authentication** flows
5. **Validate all user inputs** before processing
6. **Use HTTPS** for all network requests
7. **Enable debug mode checks** for sensitive features

## 📦 Key Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `go_router` | Type-safe routing |
| `get_it` | Dependency injection |
| `injectable` | DI code generation |
| `dio` | HTTP client |
| `flutter_secure_storage` | Encrypted storage |
| `local_auth` | Biometric authentication |
| `equatable` | Value equality |
| `toastification` | Toast notifications |
| `lottie` | Animations |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

```
feat: Add new feature
fix: Fix bug
docs: Update documentation
style: Code style changes
refactor: Code refactoring
test: Add tests
chore: Maintenance tasks
```

## 📚 Additional Documentation

- [**Environment Manager**](./lib/core/manager/environment_manager.dart) - Environment configuration

## 📧 Contact

For questions or support, please open an issue on GitHub.

---

**Built with ❤️ using Flutter**
