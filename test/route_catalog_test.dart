import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/router/app_router.dart';

void main() {
  test('portfolio exposes exactly 30 unique screen routes', () {
    expect(portfolioRoutePaths.length, 30);
    expect(portfolioRoutePaths.toSet().length, 30);
  });

  test('core showcase flows are represented in the route catalog', () {
    expect(portfolioRoutePaths, contains('/home'));
    expect(portfolioRoutePaths, contains('/doctor/:id/profile'));
    expect(portfolioRoutePaths, contains('/medical-record'));
    expect(portfolioRoutePaths, contains('/payment/success'));
  });
}
