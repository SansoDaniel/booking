import 'dart:io';

void main(List<String> arguments) async {
  final String separator = Platform.pathSeparator;

  // Print header
  _printHeader();

  // Validate arguments
  if (!_validateArguments(arguments)) {
    _printUsage();
    exitCode = 2;
    return;
  }

  final featureName = arguments[0];

  try {
    // Step 1: Clear cache
    stdout.writeln('📦 \x1B[1m\x1B[36mStep 1/3:\x1B[0m Pulizia cache Mason...');
    final clearCache = await _runMasonCommand(['cache', 'clear']);
    _printCommandResult(clearCache, showOutput: false);

    // Step 2: Get bricks
    stdout.writeln(
      '🧱 \x1B[1m\x1B[36mStep 2/3:\x1B[0m Recupero brick del progetto...',
    );
    final getBrick = await _runMasonCommand(['get']);
    _printCommandResult(getBrick, showOutput: false);

    // Step 3: Generate feature
    stdout.writeln(
      '🏗️  \x1B[1m\x1B[36mStep 3/3:\x1B[0m Generazione feature "$featureName"...',
    );
    final result = await _runMasonCommand([
      'make',
      'riverpod_state',
      '--name',
      featureName,
      '-o',
      'lib${separator}riverpod',
    ]);

    if (result.exitCode == 0) {
      _printCommandResult(result);
      _printSuccess(featureName);
      _printGeneratedFiles(featureName, separator);
    } else {
      _printError('Errore durante la generazione della feature');
      stderr.writeln('\x1B[31m${result.stderr}\x1B[0m');
      exitCode = 1;
    }
  } catch (e) {
    _printError('Errore imprevisto: $e');
    exitCode = 1;
  }
}

/// Prints the header banner
void _printHeader() {
  stdout.writeln();
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln(
    '\x1B[1m\x1B[36m    🚀  GENERAZIONE AUTOMATICA DELLA FEATURE  🚀    \x1B[0m',
  );
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln();
}

/// Validates command line arguments
bool _validateArguments(List<String> arguments) {
  if (arguments.length != 1) {
    return false;
  }

  final featureName = arguments[0];

  // Validate feature name (should be snake_case)
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(featureName)) {
    stderr.writeln(
      '\x1B[31m❌ Errore: Il nome della feature deve essere in snake_case (es: user_profile)\x1B[0m',
    );
    return false;
  }

  return true;
}

/// Prints usage instructions
void _printUsage() {
  stdout.writeln();
  stdout.writeln('\x1B[1m\x1B[33m📖 UTILIZZO:\x1B[0m');
  stdout.writeln(
    '   dart run development/feature_gen/generation.dart <feature_name> <visibility>',
  );
  stdout.writeln();
  stdout.writeln('\x1B[1m\x1B[33m📋 PARAMETRI:\x1B[0m');
  stdout.writeln(
    '   \x1B[36m<feature_name>\x1B[0m  Nome della feature in snake_case (es: user_profile)',
  );
  stdout.writeln();
  stdout.writeln('\x1B[1m\x1B[33m✨ ESEMPI:\x1B[0m');
  stdout.writeln(
    '   dart run development/feature_gen/generation.dart user_profile',
  );
  stdout.writeln(
    '   dart run development/feature_gen/generation.dart admin_panel',
  );
  stdout.writeln();
}

/// Runs a mason command
Future<ProcessResult> _runMasonCommand(List<String> args) async {
  return await Process.run('dart', ['run', 'mason_cli:mason', ...args]);
}

/// Prints the result of a command execution
void _printCommandResult(ProcessResult result, {bool showOutput = true}) {
  if (result.exitCode == 0) {
    stdout.writeln('   \x1B[32m✓ Completato con successo\x1B[0m');
    if (showOutput && result.stdout.toString().trim().isNotEmpty) {
      stdout.writeln('\x1B[36m${result.stdout}\x1B[0m');
    }
  } else {
    stdout.writeln('   \x1B[31m✗ Fallito\x1B[0m');
    if (result.stderr.toString().trim().isNotEmpty) {
      stderr.writeln('\x1B[1m\x1B[31m${result.stderr}\x1B[0m');
    }
  }
  stdout.writeln();
}

/// Prints success message
void _printSuccess(String featureName) {
  stdout.writeln();
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln(
    '\x1B[1m\x1B[32m    ✅  GENERAZIONE COMPLETATA CON SUCCESSO!  ✅    \x1B[0m',
  );
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln();
}

/// Prints information about generated files
void _printGeneratedFiles(String featureName, String separator) {
  final basePath = 'lib${separator}riverpod$separator$featureName';

  stdout.writeln('\x1B[1m\x1B[36m📁 File generati:\x1B[0m');
  stdout.writeln('   \x1B[96m$basePath/$featureName.dart\x1B[0m');
  stdout.writeln('   \x1B[96m$basePath/providers/\x1B[0m');
  stdout.writeln('   \x1B[96m   ├── providers.dart\x1B[0m');
  stdout.writeln('   \x1B[96m   ├── ${featureName}_provider.dart\x1B[0m');
  stdout.writeln('   \x1B[96m   ├── ${featureName}_notifier.dart\x1B[0m');
  stdout.writeln('   \x1B[96m   ├── ${featureName}_state.dart\x1B[0m');
  stdout.writeln('   \x1B[96m   └── ${featureName}_interceptor.dart\x1B[0m');
  stdout.writeln('   \x1B[96m$basePath/views/\x1B[0m');
  stdout.writeln('   \x1B[96m   └── ${featureName}_view.dart\x1B[0m');
  stdout.writeln('   \x1B[96m$basePath/services/\x1B[0m');
  stdout.writeln('   \x1B[96m   └── ${featureName}_services.dart\x1B[0m');
  stdout.writeln();

  stdout.writeln('\x1B[1m\x1B[36m🔧 Prossimi passi:\x1B[0m');
  stdout.writeln(
    '   1. Aggiungi l\'interceptor a \x1B[33mlib/dI_setup.dart\x1B[0m',
  );
  stdout.writeln(
    '   2. Implementa la logica business in \x1B[33m${featureName}_notifier.dart\x1B[0m',
  );
  stdout.writeln(
    '   3. Definisci lo stato in \x1B[33m${featureName}_state.dart\x1B[0m',
  );
  stdout.writeln(
    '   4. Costruisci l\'UI in \x1B[33m${featureName}_view.dart\x1B[0m',
  );
  stdout.writeln(
    '   5. (Opzionale) Aggiungi servizi in \x1B[33mservices/\x1B[0m',
  );
  stdout.writeln();
}

/// Prints error message
void _printError(String message) {
  stderr.writeln();
  stderr.writeln(
    '\x1B[31m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stderr.writeln('\x1B[1m\x1B[31m    ❌  $message  ❌    \x1B[0m');
  stderr.writeln(
    '\x1B[31m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stderr.writeln();
}
