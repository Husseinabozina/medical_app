import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/core/navigation.dart';

void main() {
  test('bottom-navigation destinations have a deterministic back fallback', () {
    expect(AppNavigation.fallbackFor('/favorites'), '/home');
    expect(AppNavigation.fallbackFor('/profile'), '/home');
    expect(AppNavigation.fallbackFor('/appointments/upcoming'), '/home');
  });

  test('nested flows return to their logical parent', () {
    expect(AppNavigation.fallbackFor('/settings/privacy'), '/settings');
    expect(AppNavigation.fallbackFor('/help/faq'), '/settings');
    expect(AppNavigation.fallbackFor('/medical-record/allergies'), '/medical-record/menu');
    expect(AppNavigation.fallbackFor('/payment/add-card'), '/payment/method');
    expect(AppNavigation.fallbackFor('/pharmacy/details'), '/pharmacy');
  });

  test('doctor child routes return to the selected doctor', () {
    expect(
      AppNavigation.fallbackFor('/doctor/emma/profile'),
      '/doctor/emma',
    );
    expect(
      AppNavigation.fallbackFor('/doctor/emma/schedule'),
      '/doctor/emma',
    );
    expect(AppNavigation.fallbackFor('/doctor/emma'), '/doctors');
  });
}
