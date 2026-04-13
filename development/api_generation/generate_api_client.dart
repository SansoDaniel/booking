import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

final String outputFolder = path.join('local_plugin', 'app_api');
final Directory outputFolderDir = Directory(outputFolder);
final String generatedTestFolder = path.join(outputFolder, 'test');
final Directory generatedTestFolderDir = Directory(generatedTestFolder);

void main(List<String> arguments) async {
  // Print header
  _printHeader();

  try {
    // Step 1: Clean existing API client
    stdout.writeln(
      '🗑️  \x1B[1m\x1B[36mStep 1/6:\x1B[0m Pulizia client API esistenti...',
    );
    if (outputFolderDir.existsSync()) {
      outputFolderDir.deleteSync(recursive: true);
      stdout.writeln('   \x1B[32m✓ Client API precedenti rimossi\x1B[0m');
    } else {
      stdout.writeln(
        '   \x1B[33m⚠ Nessun client esistente da rimuovere\x1B[0m',
      );
    }
    stdout.writeln();

    // Step 2: Generate API client with OpenAPI Generator
    stdout.writeln(
      '🔨 \x1B[1m\x1B[36mStep 2/6:\x1B[0m Generazione client API con OpenAPI Generator...',
    );
    final generateCmd = await Process.run('java', <String>[
      '-jar',
      path.join('development', 'api_generation', 'openapi-generator-cli.jar'),
      'generate',
      '--generator-name',
      'dart-dio',
      '--input-spec',
      '', // Insert link of swagger
      '--output',
      outputFolder,
      '--global-property=apiDocs false',
      '--global-property=modelDocs false',
      '--global-property=apiTests false',
      '--global-property=modelTests false',
      '--additional-properties=pubPublishTo=none',
      '--additional-properties=pubAuthor=none',
      '--additional-properties=pubHomepage=https://',
      '--additional-properties=pubName=app_api',
      '--additional-properties=pubDescription=Client generati utilizzando documentazione fornita tramite OpenAPI Document (file swagger) che rispetta lo standard OpenAPI v3',
      '--additional-properties=pubLibrary=app_api',
    ]);

    _printCommandResult(generateCmd, 'Generazione client API');

    // Step 3: Remove auto-generated tests
    stdout.writeln(
      '🧹 \x1B[1m\x1B[36mStep 3/6:\x1B[0m Rimozione test autogenerati...',
    );
    if (generatedTestFolderDir.existsSync()) {
      generatedTestFolderDir.deleteSync(recursive: true);
      stdout.writeln('   \x1B[32m✓ Test autogenerati rimossi\x1B[0m');
    } else {
      stdout.writeln('   \x1B[33m⚠ Nessun test da rimuovere\x1B[0m');
    }
    stdout.writeln();

    // Step 4: Update pubspec.yaml with Dart SDK version
    stdout.writeln(
      '📝 \x1B[1m\x1B[36mStep 4/6:\x1B[0m Aggiornamento pubspec.yaml...',
    );
    await _updatePubspecDartSdk();

    // Step 5: Run pub get
    stdout.writeln(
      '📦 \x1B[1m\x1B[36mStep 5/6:\x1B[0m Installazione dipendenze (pub get)...',
    );
    final buildCmd = await Process.run('flutter', <String>[
      'pub',
      'get',
    ], workingDirectory: path.join(outputFolder));
    _printCommandResult(buildCmd, 'Pub get', showOutput: false);

    // Step 6: Run build_runner
    stdout.writeln(
      '⚙️  \x1B[1m\x1B[36mStep 6/6:\x1B[0m Esecuzione build_runner...',
    );
    final buildRunnerCmd = await Process.run('dart', <String>[
      'run',
      'build_runner',
      'build',
    ], workingDirectory: path.join(outputFolder));
    _printCommandResult(buildRunnerCmd, 'Build runner', showOutput: false);

    // Print success
    _printSuccess();
  } catch (e) {
    _printError('Errore imprevisto durante la generazione: $e');
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
    '\x1B[1m\x1B[36m    🌐  GENERAZIONE AUTOMATICA CLIENT API  🌐    \x1B[0m',
  );
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln();
}

/// Updates the Dart SDK version in the generated pubspec.yaml
Future<void> _updatePubspecDartSdk() async {
  try {
    // Read Dart SDK version from root pubspec.yaml
    final rootYaml = File('pubspec.yaml');
    final text = rootYaml.readAsStringSync();
    final yaml = loadYaml(text);
    final dartSdk = yaml['environment']['sdk'] as String;

    // Update generated pubspec.yaml
    final newYamlPath = path.join(outputFolder, 'pubspec.yaml');
    final generatedYaml = File(newYamlPath);
    final generatedText = await generatedYaml.readAsString();
    final newYaml = YamlEditor(generatedText);
    newYaml.update(<Object?>['environment', 'sdk'], dartSdk);
    await generatedYaml.writeAsString(newYaml.toString());

    stdout.writeln('   \x1B[32m✓ Dart SDK aggiornato a: $dartSdk\x1B[0m');
  } catch (e) {
    stdout.writeln(
      '   \x1B[31m✗ Errore durante l\'aggiornamento del pubspec: $e\x1B[0m',
    );
    rethrow;
  }
  stdout.writeln();
}

/// Prints the result of a command execution
void _printCommandResult(
  ProcessResult result,
  String stepName, {
  bool showOutput = true,
}) {
  if (result.exitCode == 0) {
    stdout.writeln('   \x1B[32m✓ $stepName completata con successo\x1B[0m');
    if (showOutput && result.stdout.toString().trim().isNotEmpty) {
      // Show only last few important lines
      final lines = result.stdout.toString().trim().split('\n');
      final relevantLines =
          lines.where((line) {
            return line.contains('Successfully') ||
                line.contains('Generated') ||
                line.contains('Created') ||
                line.contains('✓');
          }).toList();

      if (relevantLines.isNotEmpty) {
        for (final line in relevantLines.take(3)) {
          stdout.writeln('   \x1B[36m$line\x1B[0m');
        }
      }
    }
  } else {
    stdout.writeln('   \x1B[31m✗ $stepName fallita\x1B[0m');
    if (result.stderr.toString().trim().isNotEmpty) {
      stderr.writeln('\x1B[1m\x1B[31m${result.stderr}\x1B[0m');
    }
    if (result.stdout.toString().trim().isNotEmpty) {
      // Show error-related lines from stdout
      final lines = result.stdout.toString().trim().split('\n');
      final errorLines =
          lines.where((line) {
            return line.toLowerCase().contains('error') ||
                line.toLowerCase().contains('fail') ||
                line.contains('✗');
          }).toList();

      if (errorLines.isNotEmpty) {
        stderr.writeln('\x1B[36m${errorLines.join('\n')}\x1B[0m');
      }
    }
    exitCode = 1;
  }
  stdout.writeln();
}

/// Prints success message
void _printSuccess() {
  stdout.writeln();
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln(
    '\x1B[1m\x1B[32m    ✅  GENERAZIONE CLIENT API COMPLETATA!  ✅    \x1B[0m',
  );
  stdout.writeln(
    '\x1B[32m═══════════════════════════════════════════════════════\x1B[0m',
  );
  stdout.writeln();
  stdout.writeln('\x1B[1m\x1B[36m📁 Client API generato:\x1B[0m');
  stdout.writeln('   \x1B[96m$outputFolder/\x1B[0m');
  stdout.writeln('   \x1B[96m├── lib/\x1B[0m');
  stdout.writeln('   \x1B[96m│   ├── api/          # API endpoints\x1B[0m');
  stdout.writeln('   \x1B[96m│   └── model/        # Data models\x1B[0m');
  stdout.writeln('   \x1B[96m└── pubspec.yaml\x1B[0m');
  stdout.writeln();
  stdout.writeln('\x1B[1m\x1B[36m🔧 Prossimi passi:\x1B[0m');
  stdout.writeln(
    '   1. Verifica i client API generati in \x1B[33m$outputFolder/lib/api/\x1B[0m',
  );
  stdout.writeln(
    '   2. Utilizza i modelli in \x1B[33m$outputFolder/lib/model/\x1B[0m',
  );
  stdout.writeln(
    '   3. Configura l\'URL base dell\'API nella tua applicazione',
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
