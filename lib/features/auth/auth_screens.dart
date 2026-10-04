import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1650), () {
      if (mounted) context.go('/register');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.aqua, AppColors.cyan],
          ),
        ),
        child: Center(
          child: AnimatedAppear(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HealthLogo(size: 122, animate: true),
                const SizedBox(height: 28),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Health',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.2,
                            ),
                      ),
                      TextSpan(
                        text: 'Track',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1.2,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 44, 24, 24),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: 154,
                    height: 154,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.aqua, AppColors.cyan],
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(28),
                    child: const HealthLogo(size: 98),
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'Your health, one step closer',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Book doctors, manage appointments and keep your medical information together.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Get started',
                    onPressed: () => context.go('/onboarding/1'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('I already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OnboardingTemplate(
      step: 0,
      symbol: '✚',
      title: 'Choose your doctor',
      description:
          'Explore trusted specialists and find the right doctor for your needs.',
      nextRoute: '/onboarding/2',
    );
  }
}

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OnboardingTemplate(
      step: 1,
      symbol: '◷',
      title: 'Schedule with ease',
      description:
          'Pick an available date and time without phone calls or waiting.',
      nextRoute: '/onboarding/3',
    );
  }
}

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OnboardingTemplate(
      step: 2,
      symbol: '♡',
      title: 'Keep health organized',
      description:
          'Appointments, records and pharmacy information stay in one calm place.',
      nextRoute: '/login',
      isLast: true,
    );
  }
}

class _OnboardingTemplate extends StatelessWidget {
  const _OnboardingTemplate({
    required this.step,
    required this.symbol,
    required this.title,
    required this.description,
    required this.nextRoute,
    this.isLast = false,
  });

  final int step;
  final String symbol;
  final String title;
  final String description;
  final String nextRoute;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 28),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Skip'),
                    ),
                  ),
                  const Spacer(),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: .82, end: 1),
                    duration: AppMotion.slow,
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) =>
                        Transform.scale(scale: value, child: child),
                    child: Container(
                      width: 220,
                      height: 220,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(54),
                      ),
                      child: Text(
                        symbol,
                        style: const TextStyle(
                          fontSize: 94,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: AppMotion.quick,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == step ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == step
                              ? AppColors.primary
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: isLast ? 'Continue' : 'Next',
                    onPressed: () => context.go(nextRoute),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginLandingScreen extends StatelessWidget {
  const LoginLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 46),
          Center(
            child: Container(
              width: 118,
              height: 118,
              padding: const EdgeInsets.all(23),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.aqua, AppColors.cyan],
                ),
                shape: BoxShape.circle,
              ),
              child: const HealthLogo(size: 72),
            ),
          ),
          const SizedBox(height: 42),
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Continue to your personal HealthTrack space.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                ),
          ),
          const SizedBox(height: 36),
          PrimaryButton(
            label: 'Log in',
            onPressed: () => context.go('/login/form'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              side: const BorderSide(color: AppColors.primary),
            ),
            onPressed: () => context.go('/signup'),
            child: const Text('Create account'),
          ),
        ],
      ),
    );
  }
}

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Log in',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 26),
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your details to continue.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 28),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(CupertinoIcons.mail),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(CupertinoIcons.lock),
              suffixIcon: IconButton(
                onPressed: () => setState(() => obscure = !obscure),
                icon: Icon(
                  obscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => context.go('/set-password'),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Log in',
            onPressed: () => context.go('/home'),
          ),
          const SizedBox(height: 18),
          Center(
            child: TextButton(
              onPressed: () => context.go('/signup'),
              child: const Text('New here? Create an account'),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Sign up',
      showBack: true,
      child: Column(
        children: [
          const SizedBox(height: 18),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(CupertinoIcons.person),
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(CupertinoIcons.mail),
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone number',
              prefixIcon: Icon(CupertinoIcons.phone),
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(CupertinoIcons.lock),
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Create account',
            onPressed: () => context.go('/set-password'),
          ),
          const SizedBox(height: 16),
          Text(
            'By continuing, you agree to HealthTrack Terms & Privacy Policy.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.muted,
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Set password',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          Text(
            'Create a secure password',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Use at least 8 characters with a mix of letters and numbers.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 28),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New password',
              prefixIcon: Icon(CupertinoIcons.lock),
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm password',
              prefixIcon: Icon(CupertinoIcons.lock_shield),
            ),
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            label: 'Save password',
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}
