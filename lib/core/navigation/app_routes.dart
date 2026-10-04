abstract final class AppRoutes {
  static const splash = '/';
  static const entry = '/entry';
  static const onboardingOne = '/onboarding/doctor';
  static const onboardingTwo = '/onboarding/schedule';
  static const onboardingThree = '/onboarding/records';
  static const login = '/auth/login';
  static const helloLogin = '/auth/hello-login';
  static const signUp = '/auth/sign-up';
  static const setPassword = '/auth/set-password';
  static const home = '/home';
  static const specialties = '/specialties';
  static const cardiology = '/specialties/cardiology';
  static const doctors = '/doctors';
  static const doctorInfo = '/doctors/info';
  static const favorites = '/doctors/favorites';
  static const profile = '/profile';
  static const settings = '/profile/settings';
  static const notifications = '/notifications';
  static const messages = '/messages';
  static const filters = '/doctors/filters';
  static const doctorProfile = '/doctors/profile';
  static const schedule = '/appointments/schedule';
  static const appointments = '/appointments';
  static const appointmentDetails = '/appointments/details';
  static const review = '/appointments/review';
  static const pharmacy = '/pharmacy';
  static const medicalRecord = '/medical-record';
  static const paymentMethod = '/payment/method';
  static const paymentSummary = '/payment/summary';
  static const paymentSuccess = '/payment/success';

  static const portfolioScreens = <String>[
    splash,
    entry,
    onboardingOne,
    onboardingTwo,
    onboardingThree,
    login,
    helloLogin,
    signUp,
    setPassword,
    home,
    specialties,
    cardiology,
    doctors,
    doctorInfo,
    favorites,
    profile,
    settings,
    notifications,
    messages,
    filters,
    doctorProfile,
    schedule,
    appointments,
    appointmentDetails,
    review,
    pharmacy,
    medicalRecord,
    paymentMethod,
    paymentSummary,
    paymentSuccess,
  ];
}
