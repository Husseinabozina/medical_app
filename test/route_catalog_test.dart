import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/router/app_router.dart';

void main() {
  test('portfolio exposes exactly 61 unique Figma screen routes', () {
    expect(portfolioRoutePaths.length, 61);
    expect(portfolioRoutePaths.toSet().length, 61);
  });

  test('core and extended showcase flows are represented', () {
    expect(portfolioRoutePaths, contains('/home'));
    expect(portfolioRoutePaths, contains('/doctor/:id/profile'));
    expect(portfolioRoutePaths, contains('/specialties/orthopedics'));
    expect(portfolioRoutePaths, contains('/favorites/services'));
    expect(portfolioRoutePaths, contains('/settings/notifications'));
    expect(portfolioRoutePaths, contains('/appointments/cancel'));
    expect(portfolioRoutePaths, contains('/pharmacy/details'));
    expect(portfolioRoutePaths, contains('/medical-record/analysis/detail'));
    expect(portfolioRoutePaths, contains('/payment/add-card'));
    expect(portfolioRoutePaths, contains('/payment/success'));
  });
}
