import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppNavigation {
  static void back(BuildContext context, {String? fallback}) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    final path = GoRouterState.of(context).uri.path;
    context.go(fallback ?? fallbackFor(path));
  }

  static String fallbackFor(String path) {
    if (path == '/favorites' ||
        path == '/profile' ||
        path == '/appointments/upcoming' ||
        path == '/notifications' ||
        path == '/message' ||
        path == '/filter' ||
        path == '/doctors' ||
        path == '/specialties' ||
        path == '/pharmacy' ||
        path == '/medical-record') {
      return '/home';
    }

    if (path == '/settings') return '/profile';
    if (path == '/profile/edit') return '/profile';
    if (path.startsWith('/settings/')) return '/settings';
    if (path.startsWith('/help/')) return '/settings';
    if (path == '/logout') return '/profile';

    if (path.startsWith('/specialties/')) return '/specialties';

    if (path.startsWith('/favorites/')) return '/favorites';

    if (path == '/appointments/details' ||
        path == '/appointments/cancel' ||
        path == '/review') {
      return '/appointments/upcoming';
    }
    if (path == '/appointments/complete' ||
        path == '/appointments/cancelled') {
      return '/appointments/upcoming';
    }

    if (path == '/pharmacy/filter' || path == '/pharmacy/details') {
      return '/pharmacy';
    }

    if (path == '/medical-record/add' || path == '/medical-record/menu') {
      return '/medical-record';
    }
    if (path.startsWith('/medical-record/')) {
      return '/medical-record/menu';
    }

    if (path == '/payment/add-card') return '/payment/method';
    if (path == '/payment/summary') return '/payment/method';
    if (path == '/payment/method') return '/appointments/details';

    final doctorMatch =
        RegExp(r'^/doctor/([^/]+)(?:/(profile|schedule))?$').firstMatch(path);
    if (doctorMatch != null) {
      final doctorId = doctorMatch.group(1)!;
      final child = doctorMatch.group(2);
      return child == null ? '/doctors' : '/doctor/$doctorId';
    }

    if (path.startsWith('/onboarding/')) return '/register';
    if (path == '/login/form' || path == '/signup') return '/login';
    if (path == '/set-password') return '/login/form';
    if (path == '/register' || path == '/login') return '/';

    return '/home';
  }
}
