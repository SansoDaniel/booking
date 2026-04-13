class EnvironmentManager {
  const EnvironmentManager._();

  static String environment = String.fromEnvironment('environment');
  static String version = String.fromEnvironment('version');
  static String apiUrl = String.fromEnvironment('api-url');
}
