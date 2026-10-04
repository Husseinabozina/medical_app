import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/motion.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/health_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.splash)..forward();
    Future<void>.delayed(const Duration(milliseconds: 1700), () {
      if (mounted) context.go(AppRoutes.entry);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disabled = MediaQuery.maybeOf(context)?.disableAnimations == true;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.aquaBright, AppColors.aquaDeep]),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = disabled ? 1.0 : CurvedAnimation(parent: _controller, curve: Curves.easeOutBack).value;
              return Opacity(
                opacity: t.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: .78 + (.22 * t),
                  child: Transform.rotate(angle: disabled ? 0 : math.sin(_controller.value * math.pi) * .015, child: child),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MedicalMark(size: 190),
                const SizedBox(height: 28),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Health', style: GoogleFonts.inter(fontWeight: FontWeight.w900)),
                      TextSpan(text: 'Track', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  style: const TextStyle(fontSize: 32, color: Colors.white, letterSpacing: -1.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 110, 30, 54),
            child: Column(
              children: [
                const MedicalMark(size: 190, color: AppColors.aqua),
                const SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Health', style: GoogleFonts.inter(fontWeight: FontWeight.w900)),
                      TextSpan(text: 'Track', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  style: const TextStyle(fontSize: 32, color: AppColors.aqua, letterSpacing: -1.2),
                ),
                const Spacer(),
                Text('entry.copy'.tr(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 30),
                GradientButton(label: 'auth.log_in'.tr(), width: 208, onPressed: () => context.go(AppRoutes.login)),
                const SizedBox(height: 10),
                SizedBox(
                  width: 208,
                  height: 46,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: AppColors.ice, foregroundColor: AppColors.aqua),
                    onPressed: () => context.go(AppRoutes.onboardingOne),
                    child: Text('auth.sign_up'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.aqua)),
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

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) => _OnboardingScreen(
        illustration: 1,
        title: 'onboarding.choose_doctor'.tr(),
        body: 'onboarding.choose_doctor_body'.tr(),
        index: 0,
        nextRoute: AppRoutes.onboardingTwo,
      );
}

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({super.key});

  @override
  Widget build(BuildContext context) => _OnboardingScreen(
        illustration: 2,
        title: 'onboarding.schedule'.tr(),
        body: 'onboarding.schedule_body'.tr(),
        index: 1,
        nextRoute: AppRoutes.onboardingThree,
      );
}

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({super.key});

  @override
  Widget build(BuildContext context) => _OnboardingScreen(
        illustration: 3,
        title: 'onboarding.records'.tr(),
        body: 'onboarding.records_body'.tr(),
        index: 2,
        nextRoute: AppRoutes.signUp,
        finalStep: true,
      );
}

class _OnboardingScreen extends StatelessWidget {
  const _OnboardingScreen({
    required this.illustration,
    required this.title,
    required this.body,
    required this.index,
    required this.nextRoute,
    this.finalStep = false,
  });

  final int illustration;
  final String title;
  final String body;
  final int index;
  final String nextRoute;
  final bool finalStep;

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          if (!finalStep)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 28, top: 8),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.signUp),
                  child: Text('common.skip'.tr(), style: const TextStyle(color: AppColors.ink)),
                ),
              ),
            )
          else
            const SizedBox(height: 44),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Appear(child: BrandIllustration(kind: illustration, height: 300)),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 36),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w500, height: 1.05),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 56),
                    child: Text(body, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.3)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (dot) => AnimatedContainer(
                        duration: AppMotion.of(context, AppMotion.quick),
                        width: dot == index ? 10 : 8,
                        height: dot == index ? 10 : 8,
                        margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: dot == index ? AppColors.aqua : AppColors.ice),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  GradientButton(
                    label: finalStep ? 'common.get_started'.tr() : 'common.next'.tr(),
                    width: 206,
                    onPressed: () => context.go(nextRoute),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
