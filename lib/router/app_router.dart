import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/design_system.dart';
import '../features/account/account_screens.dart';
import '../features/appointments/appointment_screens.dart';
import '../features/auth/auth_screens.dart';
import '../features/home/home_screens.dart';
import '../features/payments/payment_screens.dart';
import '../features/services/service_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    _route('/', const SplashScreen()),
    _route('/register', const RegisterScreen()),
    _route('/onboarding/1', const OnboardingOneScreen()),
    _route('/onboarding/2', const OnboardingTwoScreen()),
    _route('/onboarding/3', const OnboardingThreeScreen()),
    _route('/login', const LoginLandingScreen()),
    _route('/login/form', const LoginFormScreen()),
    _route('/signup', const SignUpScreen()),
    _route('/set-password', const SetPasswordScreen()),
    _route('/home', const HomeScreen()),
    _route('/specialties', const SpecialtiesScreen()),
    _route('/specialties/cardiology', const CardiologyDoctorsScreen()),
    _route('/doctors', const DoctorsScreen()),
    GoRoute(
      path: '/doctor/:id',
      pageBuilder: (context, state) => _page(
        state,
        DoctorInfoScreen(doctorId: state.pathParameters['id'] ?? 'emma'),
      ),
    ),
    _route('/favorites', const FavoriteDoctorsScreen()),
    _route('/profile', const ProfileScreen()),
    _route('/settings', const SettingsScreen()),
    _route('/notifications', const NotificationsScreen()),
    _route('/message', const MessageScreen()),
    _route('/filter', const FilterScreen()),
    GoRoute(
      path: '/doctor/:id/profile',
      pageBuilder: (context, state) => _page(
        state,
        DoctorProfileScreen(doctorId: state.pathParameters['id'] ?? 'emma'),
      ),
    ),
    GoRoute(
      path: '/doctor/:id/schedule',
      pageBuilder: (context, state) => _page(
        state,
        ScheduleScreen(doctorId: state.pathParameters['id'] ?? 'emma'),
      ),
    ),
    _route('/appointments/upcoming', const AppointmentUpcomingScreen()),
    _route('/appointments/details', const AppointmentDetailsScreen()),
    _route('/review', const ReviewScreen()),
    _route('/pharmacy', const PharmacyScreen()),
    _route('/medical-record', const MedicalRecordScreen()),
    _route('/payment/method', const PaymentMethodScreen()),
    _route('/payment/summary', const PaymentSummaryScreen()),
    _route('/payment/success', const PaymentSuccessScreen()),
  ],
);

GoRoute _route(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => _page(state, child),
  );
}

CustomTransitionPage<void> _page(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: AppMotion.medium,
    reverseTransitionDuration: AppMotion.quick,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(.025, .015),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}
