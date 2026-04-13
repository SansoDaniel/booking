# API Center

Sistema centralizzato per la gestione delle chiamate API con Dio.

## Caratteristiche

- ✅ **Singleton Dio Instance**: Istanza unica per tutta l'applicazione
- ✅ **Interceptors Configurati**: Loading, logging, errori, mock, autenticazione
- ✅ **Error Handling**: Gestione consistente degli errori con `ApiError`
- ✅ **Loading Management**: Indicatore di caricamento automatico
- ✅ **Mock Support**: Risposte mock per sviluppo e testing
- ✅ **Token Management**: Gestione automatica del token di autenticazione
- ✅ **Type-Safe**: Implementazione type-safe con generics

## Struttura

```
api_center/
├── api_center.dart          # Classe principale singleton
├── api_error.dart           # Classe per errori API
├── api_example.dart         # Esempi di utilizzo
├── interceptor/
│   ├── error_interceptor.dart   # Gestione errori
│   ├── loader_interceptor.dart  # Gestione loading
│   ├── mock_interceptor.dart    # Risposte mock
│   └── token_interceptor.dart   # Autenticazione
└── README.md
```

## Utilizzo Base

### 1. Inizializzazione

L'ApiCenter è un singleton e viene inizializzato automaticamente:

```dart
final apiCenter = ApiCenter();
final dio = apiCenter.dio;
```

### 2. GET Request

```dart
try {
  final response = await apiCenter.dio.get('/users');
  print(response.data);
} on DioException catch (e) {
  final error = ApiError.fromDioException(e);
  print('Error: $error');
}
```

### 3. POST Request

```dart
try {
  final response = await apiCenter.dio.post(
    '/users',
    data: {
      'name': 'John Doe',
      'email': 'john@example.com',
    },
  );
  print('Created: ${response.data}');
} on DioException catch (e) {
  final error = ApiError.fromDioException(e);
  print('Error: $error');
}
```

### 4. Request Senza Loader

```dart
final response = await apiCenter.dio.noLoader.get('/users');
```

### 5. Request Autenticata

```dart
// Set token una volta
apiCenter.setAccessToken('your-jwt-token');

// Tutte le richieste successive includeranno il token
final response = await apiCenter.dio.get('/profile');

// Rimuovi token al logout
apiCenter.clearAccessToken();
```

## Error Handling

### ApiError Properties

```dart
final error = ApiError.fromDioException(dioException);

error.message        // Messaggio user-friendly
error.statusCode     // HTTP status code
error.type           // DioExceptionType
error.data           // Response data (se disponibile)

// Helper methods
error.isNetworkError      // Timeout o connessione
error.isAuthError         // 401 o 403
error.isValidationError   // 400 o 422
error.isServerError       // 5xx
```

### Gestione Errori Specifica

```dart
try {
  final response = await apiCenter.dio.get('/data');
  return response.data;
} on DioException catch (e) {
  final error = ApiError.fromDioException(e);
  
  if (error.isAuthError) {
    // Redirect a login
    router.go('/login');
  } else if (error.isNetworkError) {
    // Mostra messaggio offline
    showToast('Controlla la connessione internet');
  } else if (error.isValidationError) {
    // Mostra errori di validazione
    showValidationErrors(error.data);
  } else {
    // Errore generico
    showToast(error.message);
  }
  
  return null;
}
```

## Interceptors

### Order of Execution

1. **MockInterceptor** (solo in ambiente mock)
2. **LoaderInterceptor** (gestione loading)
3. **ErrorInterceptor** (gestione errori)
4. **LogInterceptor** (solo in dev/development)
5. **TokenInterceptor** (quando configurato)

### Loader Management

Il loader viene mostrato/nascosto automaticamente per ogni request:

```dart
// Con loader (default)
await apiCenter.dio.get('/users');

// Senza loader
await apiCenter.dio.noLoader.get('/users');
```

### Mock Responses

Per usare risposte mock:

1. Set environment a `mock`
2. Crea file JSON in `development/mock/`:
   - Formato: `{METHOD}_{path}.json`
   - Esempio: `GET_users.json`, `POST_login.json`

```json
// development/mock/GET_users.json
{
  "success": true,
  "data": [
    {"id": 1, "name": "John"},
    {"id": 2, "name": "Jane"}
  ]
}
```

## Repository Pattern

Esempio di repository che usa ApiCenter:

```dart
class UserRepository {
  final ApiCenter _apiCenter = ApiCenter();

  Future<List<User>> getUsers() async {
    try {
      final response = await _apiCenter.dio.get('/users');
      final data = response.data as Map<String, dynamic>;
      final users = (data['data'] as List)
          .map((json) => User.fromJson(json))
          .toList();
      return users;
    } on DioException catch (e) {
      final error = ApiError.fromDioException(e);
      throw Exception(error.message);
    }
  }

  Future<User> createUser(CreateUserDto dto) async {
    try {
      final response = await _apiCenter.dio.post(
        '/users',
        data: dto.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      final error = ApiError.fromDioException(e);
      throw Exception(error.message);
    }
  }
}
```

## Best Practices

### ✅ DO

```dart
// Use ApiCenter singleton
final apiCenter = ApiCenter();

// Handle errors with ApiError
try {
  final response = await apiCenter.dio.get('/data');
} on DioException catch (e) {
  final error = ApiError.fromDioException(e);
  print(error.message);
}

// Use noLoader when appropriate
await apiCenter.dio.noLoader.get('/background-sync');

// Set token after login
apiCenter.setAccessToken(token);

// Clear token on logout
apiCenter.clearAccessToken();
```

### ❌ DON'T

```dart
// Don't create new Dio instances
final dio = Dio(); // ❌ NO

// Don't ignore errors
await apiCenter.dio.get('/data'); // ❌ NO error handling

// Don't hardcode tokens in requests
dio.get('/data', options: Options(
  headers: {'Authorization': 'Bearer token'} // ❌ Use setAccessToken
));

// Don't show loader for background requests
await apiCenter.dio.get('/analytics'); // ❌ Use noLoader
```

## Testing

### Mock Interceptor per Testing

```dart
testWidgets('fetch users', (tester) async {
  // Set environment to mock
  EnvironmentManager.environment = 'mock';
  
  // Create mock file: development/mock/GET_users.json
  final response = await apiCenter.dio.get('/users');
  
  expect(response.statusCode, 200);
  expect(response.data['success'], true);
});
```

## Configuration

### Environment Variables

```dart
// Set in main.dart or use --dart-define
EnvironmentManager.environment = 'dev';  // dev, production, mock
EnvironmentManager.apiUrl = 'https://api.example.com';
```

### Timeouts

Default timeouts (30 secondi):
- connectTimeout
- receiveTimeout  
- sendTimeout

Per modificare:

```dart
apiCenter.dio.options.connectTimeout = Duration(seconds: 60);
```

## Troubleshooting

### Loader non si nasconde

```dart
// Force hide loader
LoadingManager().forceHide();
```

### Token non funziona

```dart
// Verifica token impostato
print(apiCenter.hasAccessToken); // true/false

// Reset e ri-imposta
apiCenter.clearAccessToken();
apiCenter.setAccessToken(newToken);
```

### Mock non funziona

1. Verifica environment: `EnvironmentManager.environment == 'mock'`
2. Verifica path file: `development/mock/GET_users.json`
3. Verifica formato nome: `{METHOD}_{path}.json`
4. Aggiungi file a `pubspec.yaml`:
   ```yaml
   assets:
     - development/mock/
   ```

## Migrazione dal Vecchio Codice

```dart
// Prima ❌
Dio get _dio => Dio(BaseOptions(...));

// Dopo ✅
final apiCenter = ApiCenter();
final dio = apiCenter.dio;

// Prima ❌
_dio.interceptors.add(TokenInterceptor(token));

// Dopo ✅
apiCenter.setAccessToken(token);
```

## Prossimi Passi

- [ ] Aggiungere retry logic per request fallite
- [ ] Implementare caching delle risposte
- [ ] Aggiungere rate limiting
- [ ] Integrare con logger package (es. logger, talker)
- [ ] Aggiungere metrics e monitoring
