import '../core/app_environment.dart';
import '../core/health_domain.dart';
import 'mock/mock_health_data_source.dart';

abstract final class HealthBackendFactory {
  static HealthDataSource create(BackendMode mode) {
    switch (mode) {
      case BackendMode.mock:
        return MockHealthDataSource();
      case BackendMode.real:
        throw UnsupportedError(
          'Real HealthTrack backend is not configured yet. '
          'Run with --dart-define=BACKEND_MODE=mock.',
        );
    }
  }
}
