enum BackendMode { mock, real }

abstract final class AppEnvironment {
  static const String _backendMode =
      String.fromEnvironment('BACKEND_MODE', defaultValue: 'mock');

  static BackendMode get backendMode =>
      _backendMode.toLowerCase() == 'real' ? BackendMode.real : BackendMode.mock;
}
