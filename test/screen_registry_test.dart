import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/core/navigation/app_routes.dart';

void main() {
  test('portfolio exposes exactly 30 unique product screens', () {
    expect(AppRoutes.portfolioScreens, hasLength(30));
    expect(AppRoutes.portfolioScreens.toSet(), hasLength(30));
  });
}
