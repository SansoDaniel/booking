# Mock API Responses

Questa cartella contiene file JSON per simulare risposte API durante lo sviluppo.

## Come Funziona

Quando l'ambiente è impostato su `'mock'`, il `MockInterceptor` intercetta tutte le chiamate API e restituisce i dati da questi file JSON invece di effettuare chiamate HTTP reali.

## Convenzione di Naming

I file devono seguire questa convenzione:
```
{METODO_HTTP}_{path}.json
```

### Esempi

| Request | File Mock |
|---------|-----------|
| `GET /users` | `GET_users.json` |
| `POST /login` | `POST_login.json` |
| `GET /users/123` | `GET_users_123.json` |
| `PUT /users/profile` | `PUT_users_profile.json` |
| `DELETE /posts/5` | `DELETE_posts_5.json` |

**Nota**: Le barre `/` nel path vengono sostituite con underscore `_`.

## Formato File

I file JSON devono contenere la risposta completa dell'API:

```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Example"
  },
  "message": "Operation successful"
}
```

## Utilizzo

### 1. Imposta l'Ambiente

Nel file `main.dart` o via environment variables:

```dart
void main() {
  // Set environment to mock
  // This can also be done via --dart-define
}
```

### 2. Crea il File Mock

Crea un file JSON in questa cartella con la convenzione di naming corretta.

### 3. Esegui l'App

L'app userà automaticamente i mock invece di chiamare le API reali.

## Esempio Completo

### File: GET_users.json

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "role": "admin"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "role": "user"
    }
  ],
  "meta": {
    "total": 2,
    "page": 1,
    "per_page": 10
  }
}
```

### Codice Dart

```dart
// Con environment = 'mock', questa chiamata userà GET_users.json
final response = await apiCenter.dio.get('/users');
print(response.data); // Stampa il contenuto di GET_users.json
```

## Tips

### Risposte di Errore

Puoi simulare anche errori creando file specifici:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email già registrata"
  }
}
```

### Dati Complessi

Per simulare risposte complesse con relazioni:

```json
{
  "data": {
    "user": {
      "id": 1,
      "name": "John",
      "posts": [
        {"id": 1, "title": "Post 1"},
        {"id": 2, "title": "Post 2"}
      ],
      "profile": {
        "bio": "Developer",
        "avatar": "https://..."
      }
    }
  }
}
```

### Delay Simulato

Il `MockInterceptor` restituisce le risposte immediatamente. Per simulare ritardi di rete, puoi aggiungere un delay nel notifier/repository:

```dart
// In sviluppo/testing
await Future.delayed(Duration(seconds: 2));
final response = await apiCenter.dio.get('/users');
```

## Troubleshooting

### File Non Trovato

Se ricevi un errore "Mock file not found":

1. Verifica il nome del file corrisponda alla convenzione
2. Controlla che il file sia in questa cartella
3. Assicurati che `pubspec.yaml` includa:
   ```yaml
   flutter:
     assets:
       - development/mock/
   ```
4. Esegui `flutter pub get`

### JSON Non Valido

Se il JSON non viene parsato:

1. Valida il JSON su [jsonlint.com](https://jsonlint.com)
2. Verifica virgole e parentesi
3. Usa double quotes `"` non single quotes `'`

### Ambiente Non Mock

Verifica che `EnvironmentManager.environment == 'mock'`:

```dart
print(EnvironmentManager.environment); // Deve essere 'mock'
```

## Best Practices

1. **Naming Consistente**: Usa sempre la convenzione di naming
2. **Struttura Reale**: Mantieni la struttura identica all'API reale
3. **Dati Realistici**: Usa dati che rappresentano scenari reali
4. **Casi Edge**: Crea mock per casi limite (liste vuote, errori, etc.)
5. **Versioning**: Documenta quale versione API rappresentano i mock

## Esempi Aggiuntivi

Nella cartella trovi:
- `GET_users.json` - Lista utenti esempio

Puoi creare altri file seguendo lo stesso pattern per tutte le API del progetto.
