import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/design_system.dart';
import '../features/account/account_screens.dart';
import '../features/appointments/appointment_screens.dart';
import '../features/auth/auth_screens.dart';
import '../features/extended/remaining_screens.dart';
import '../features/home/home_screens.dart';
import '../features/payments/payment_screens.dart';
import '../features/services/service_screens.dart';

const portfolioRoutePaths = <String>[
  '/',
  '/register',
  '/onboarding/1',
  '/onboarding/2',
  '/onboarding/3',
  '/login',
  '/login/form',
  '/signup',
  '/set-password',
  '/home',
  '/specialties',
  '/specialties/cardiology',
  '/doctors',
  '/doctor/:id',
  '/favorites',
  '/profile',
  '/settings',
  '/notifications',
  '/message',
  '/filter',
  '/doctor/:id/profile',
  '/doctor/:id/schedule',
  '/appointments/upcoming',
  '/appointments/details',
  '/review',
  '/pharmacy',
  '/medical-record',
  '/payment/method',
  '/payment/summary',
  '/payment/success',
  '/specialties/dermatology',
  '/specialties/general',
  '/specialties/gynecology',
  '/specialties/odontology',
  '/specialties/oncology',
  '/specialties/ophthalmology',
  '/specialties/orthopedics',
  '/favorites/rating',
  '/favorites/services',
  '/favorites/female',
  '/favorites/male',
  '/profile/edit',
  '/settings/notifications',
  '/settings/password-manager',
  '/settings/privacy',
  '/help/faq',
  '/help/contact',
  '/logout',
  '/appointments/complete',
  '/appointments/cancelled',
  '/appointments/cancel',
  '/pharmacy/filter',
  '/pharmacy/details',
  '/medical-record/add',
  '/medical-record/menu',
  '/medical-record/allergies',
  '/medical-record/analysis',
  '/medical-record/analysis/detail',
  '/medical-record/vaccinations',
  '/medical-record/history',
  '/payment/add-card',
];

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
    _route('/specialties/dermatology', const DermatologyDoctorsVariantScreen()),
    _route('/specialties/general', const GeneralDoctorsVariantScreen()),
    _route('/specialties/gynecology', const GynecologyDoctorsVariantScreen()),
    _route('/specialties/odontology', const OdontologyDoctorsVariantScreen()),
    _route('/specialties/oncology', const OncologyDoctorsVariantScreen()),
    _route(
      '/specialties/ophthalmology',
      const OphthalmologyDoctorsVariantScreen(),
    ),
    _route('/specialties/orthopedics', const OrthopedicsDoctorsVariantScreen()),
    _route('/doctors', const DoctorsScreen()),
    GoRoute(
      path: '/doctor/:id',
      pageBuilder: (context, state) => _page(
        state,
        DoctorInfoScreen(doctorId: state.pathParameters['id'] ?? 'emma'),
      ),
    ),
    _route('/favorites', const FavoriteDoctorsScreen()),
    _route('/favorites/rating', const DoctorRatingScreen()),
    _route('/favorites/services', const FavoriteServicesScreen()),
    _route('/favorites/female', const FavoriteFemaleDoctorsScreen()),
    _route('/favorites/male', const FavoriteMaleDoctorsScreen()),
    _route('/profile', const ProfileScreen()),
    _route('/profile/edit', const EditProfileScreen()),
    _route('/settings', const SettingsScreen()),
    _route('/settings/notifications', const NotificationSettingScreen()),
    _route('/settings/password-manager', const PasswordManagerScreen()),
    _route('/settings/privacy', const PrivacyPolicyScreen()),
    _route('/help/faq', const HelpFaqScreen()),
    _route('/help/contact', const HelpContactScreen()),
    _route('/logout', const LogoutScreen()),
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
    _route('/appointments/complete', const AppointmentCompleteScreen()),
    _route('/appointments/upcoming', const AppointmentUpcomingScreen()),
    _route('/appointments/cancelled', const AppointmentCancelledScreen()),
    _route('/appointments/cancel', const CancelAppointmentScreen()),
    _route('/appointments/details', const AppointmentDetailsScreen()),
    _route('/review', const ReviewScreen()),
    _route('/pharmacy', const PharmacyScreen()),
    _route('/pharmacy/filter', const PharmacyFilterScreen()),
    _route('/pharmacy/details', const PharmacyDetailsScreen()),
    _route('/medical-record', const MedicalRecordScreen()),
    _route('/medical-record/add', const MedicalRecordAddScreen()),
    _route('/medical-record/menu', const MedicalRecordMenuScreen()),
    _route('/medical-record/allergies', const AllergiesScreen()),
    _route('/medical-record/analysis', const AnalysisScreen()),
    _route('/medical-record/analysis/detail', const AnalysisDetailScreen()),
    _route('/medical-record/vaccinations', const VaccinationsScreen()),
    _route('/medical-record/history', const MedicalHistoryScreen()),
    _route('/payment/method', const PaymentMethodScreen()),
    _route('/payment/add-card', const AddCardScreen()),
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
