import 'package:go_router/go_router.dart';

import '../../presentation/screens/auth_screens.dart';
import '../../presentation/screens/health_flow_screens.dart';
import '../../presentation/screens/home_doctor_screens.dart';
import '../../presentation/screens/onboarding_screens.dart';
import '../../presentation/screens/profile_communication_screens.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppRoutes.entry, builder: (_, __) => const EntryScreen()),
      GoRoute(path: AppRoutes.onboardingOne, builder: (_, __) => const OnboardingOneScreen()),
      GoRoute(path: AppRoutes.onboardingTwo, builder: (_, __) => const OnboardingTwoScreen()),
      GoRoute(path: AppRoutes.onboardingThree, builder: (_, __) => const OnboardingThreeScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.helloLogin, builder: (_, __) => const HelloLoginScreen()),
      GoRoute(path: AppRoutes.signUp, builder: (_, __) => const SignUpScreen()),
      GoRoute(path: AppRoutes.setPassword, builder: (_, __) => const SetPasswordScreen()),
      GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeScreen()),
      GoRoute(path: AppRoutes.specialties, builder: (_, __) => const SpecialtiesScreen()),
      GoRoute(path: AppRoutes.cardiology, builder: (_, __) => const CardiologyDoctorsScreen()),
      GoRoute(path: AppRoutes.doctors, builder: (_, __) => const DoctorsScreen()),
      GoRoute(path: AppRoutes.doctorInfo, builder: (_, __) => const DoctorInfoScreen()),
      GoRoute(path: AppRoutes.favorites, builder: (_, __) => const FavoriteDoctorsScreen()),
      GoRoute(path: AppRoutes.profile, builder: (_, __) => const ProfileScreen()),
      GoRoute(path: AppRoutes.settings, builder: (_, __) => const SettingsScreen()),
      GoRoute(path: AppRoutes.notifications, builder: (_, __) => const NotificationsScreen()),
      GoRoute(path: AppRoutes.messages, builder: (_, __) => const MessageScreen()),
      GoRoute(path: AppRoutes.filters, builder: (_, __) => const FilterScreen()),
      GoRoute(path: AppRoutes.doctorProfile, builder: (_, __) => const DoctorProfileScreen()),
      GoRoute(path: AppRoutes.schedule, builder: (_, __) => const ScheduleScreen()),
      GoRoute(path: AppRoutes.appointments, builder: (_, __) => const AppointmentsScreen()),
      GoRoute(path: AppRoutes.appointmentDetails, builder: (_, __) => const AppointmentDetailsScreen()),
      GoRoute(path: AppRoutes.review, builder: (_, __) => const ReviewScreen()),
      GoRoute(path: AppRoutes.pharmacy, builder: (_, __) => const PharmacyScreen()),
      GoRoute(path: AppRoutes.medicalRecord, builder: (_, __) => const MedicalRecordScreen()),
      GoRoute(path: AppRoutes.paymentMethod, builder: (_, __) => const PaymentMethodScreen()),
      GoRoute(path: AppRoutes.paymentSummary, builder: (_, __) => const PaymentSummaryScreen()),
      GoRoute(path: AppRoutes.paymentSuccess, builder: (_, __) => const PaymentSuccessScreen()),
    ],
  );
}
