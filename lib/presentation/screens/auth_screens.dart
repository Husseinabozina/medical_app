import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_colors.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/health_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => _LoginForm(title: 'auth.log_in'.tr(), socialMode: true);
}

class HelloLoginScreen extends StatelessWidget {
  const HelloLoginScreen({super.key});

  @override
  Widget build(BuildContext context) => _LoginForm(title: 'auth.hello'.tr(), socialMode: false);
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.title, required this.socialMode});

  final String title;
  final bool socialMode;

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: title, onBack: () => context.go(AppRoutes.entry)),
          Expanded(
            child: ScreenBody(
              children: [
                Text('auth.welcome'.tr(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                if (socialMode) Text('auth.welcome_body'.tr(), style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 64),
                HealthTextField(label: 'auth.email_or_mobile'.tr(), hint: 'example@example.com'),
                const SizedBox(height: 20),
                HealthTextField(
                  label: 'auth.password'.tr(),
                  hint: '••••••••••••',
                  obscureText: true,
                  trailing: const Icon(CupertinoIcons.eye_slash, color: AppColors.aqua),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(onPressed: () => context.go(AppRoutes.setPassword), child: Text('auth.forgot_password'.tr())),
                ),
                const SizedBox(height: 24),
                Center(child: GradientButton(label: 'auth.log_in'.tr(), width: 194, onPressed: () => context.go(AppRoutes.home))),
                const SizedBox(height: 52),
                Center(child: Text(socialMode ? 'auth.or_sign_up_with'.tr() : 'auth.or'.tr())),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialCircle(icon: socialMode ? CupertinoIcons.globe : CupertinoIcons.hand_draw),
                    if (socialMode) ...[
                      const SizedBox(width: 12),
                      const _SocialCircle(icon: CupertinoIcons.f_cursive_circle),
                      const SizedBox(width: 12),
                      const _SocialCircle(icon: CupertinoIcons.hand_draw),
                    ],
                  ],
                ),
                const SizedBox(height: 28),
                Center(
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.signUp),
                    child: Text.rich(
                      TextSpan(children: [TextSpan(text: '${'auth.no_account'.tr()} '), TextSpan(text: 'auth.sign_up'.tr(), style: const TextStyle(color: AppColors.aqua))]),
                    ),
                  ),
                ),
              ],
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
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: 'auth.new_account'.tr(), onBack: () => context.go(AppRoutes.entry)),
          Expanded(
            child: ScreenBody(
              children: [
                HealthTextField(label: 'auth.full_name'.tr(), hint: 'auth.full_name_hint'.tr()),
                const SizedBox(height: 14),
                HealthTextField(label: 'auth.password'.tr(), hint: '••••••••••••', obscureText: true, trailing: const Icon(CupertinoIcons.eye_slash, color: AppColors.aqua)),
                const SizedBox(height: 14),
                HealthTextField(label: 'auth.email'.tr(), hint: 'example@example.com'),
                const SizedBox(height: 14),
                HealthTextField(label: 'auth.mobile'.tr(), hint: '+1 234 567 8900'),
                const SizedBox(height: 14),
                HealthTextField(label: 'auth.birth_date'.tr(), hint: 'DD / MM / YYYY'),
                const SizedBox(height: 18),
                Text('auth.terms'.tr(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 14),
                Center(child: GradientButton(label: 'auth.sign_up'.tr(), width: 192, onPressed: () => context.go(AppRoutes.home))),
                const SizedBox(height: 14),
                Center(child: Text('auth.or_sign_up_with'.tr())),
                const SizedBox(height: 10),
                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [_SocialCircle(icon: CupertinoIcons.globe), SizedBox(width: 12), _SocialCircle(icon: CupertinoIcons.f_cursive_circle), SizedBox(width: 12), _SocialCircle(icon: CupertinoIcons.hand_draw)]),
                const SizedBox(height: 18),
                Center(child: TextButton(onPressed: () => context.go(AppRoutes.login), child: Text('auth.have_account'.tr()))),
              ],
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
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: 'auth.set_password'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ScreenBody(
              children: [
                Text('auth.password_reset_body'.tr(), style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 30),
                HealthTextField(label: 'auth.password'.tr(), hint: '••••••••••••', obscureText: true, trailing: const Icon(CupertinoIcons.eye_slash, color: AppColors.aqua)),
                const SizedBox(height: 28),
                HealthTextField(label: 'auth.confirm_password'.tr(), hint: '••••••••••••', obscureText: true, trailing: const Icon(CupertinoIcons.eye_slash, color: AppColors.aqua)),
                const SizedBox(height: 70),
                Center(child: GradientButton(label: 'auth.create_new_password'.tr(), width: 270, onPressed: () => context.go(AppRoutes.helloLogin))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  const _SocialCircle({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
        child: Icon(icon, color: Colors.white, size: 22),
      );
}
