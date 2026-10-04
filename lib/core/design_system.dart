import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation.dart';

abstract final class AppColors {
  static const aqua = Color(0xFF33E4DB);
  static const cyan = Color(0xFF00BBD3);
  static const primary = Color(0xFF13CAD6);
  static const ink = Color(0xFF252525);
  static const softBlue = Color(0xFFE9F6FE);
  static const paleLilac = Color(0xFFECF1FF);
  static const white = Color(0xFFFFFFFF);
  static const muted = Color(0xFF8B97A8);
  static const border = Color(0xFFDCE9F2);
  static const success = Color(0xFF36C98F);
  static const danger = Color(0xFFFF6B6B);
}

abstract final class AppMotion {
  static const quick = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 320);
  static const slow = Duration(milliseconds: 520);
  static const curve = Curves.easeOutCubic;
}

abstract final class HealthTheme {
  static ThemeData get light {
    final textTheme = GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.primary,
        secondary: AppColors.cyan,
        surface: AppColors.white,
      ),
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.softBlue,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
        contentPadding:
            const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }
}

class HealthScaffold extends StatelessWidget {
  const HealthScaffold({
    super.key,
    required this.child,
    this.title,
    this.showBack = false,
    this.trailing,
    this.bottomNavigationBar,
    this.padding = const EdgeInsetsDirectional.fromSTEB(20, 14, 20, 24),
  });

  final Widget child;
  final String? title;
  final bool showBack;
  final Widget? trailing;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                if (title != null || showBack || trailing != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 44,
                          child: showBack
                              ? IconButton(
                                  onPressed: () => AppNavigation.back(context),
                                  icon: const Icon(
                                    CupertinoIcons.back,
                                    color: AppColors.ink,
                                  ),
                                )
                              : null,
                        ),
                        Expanded(
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        SizedBox(width: 44, child: trailing),
                      ],
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding,
                    child: child,
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

class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    required this.child,
    this.height = 190,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.aqua, AppColors.cyan],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),
      child: child,
    );
  }
}

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color = AppColors.white,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final card = AnimatedContainer(
      duration: AppMotion.quick,
      curve: AppMotion.curve,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border.withValues(alpha: .72)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: .08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );

    return onTap == null
        ? card
        : InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: onTap,
            child: card,
          );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorAvatar extends StatelessWidget {
  const DoctorAvatar({
    super.key,
    required this.initials,
    this.size = 58,
  });

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(size * .34),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDDFBF7), Color(0xFFDFF3FF)],
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.cyan,
          fontSize: size * .28,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class HealthLogo extends StatefulWidget {
  const HealthLogo({super.key, this.size = 112, this.animate = false});

  final double size;
  final bool animate;

  @override
  State<HealthLogo> createState() => _HealthLogoState();
}

class _HealthLogoState extends State<HealthLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = widget.animate ? 1 + (_controller.value * .045) : 1.0;
        return Transform.scale(scale: scale, child: child);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(painter: _HealthLogoPainter()),
      ),
    );
  }
}

class _HealthLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * .09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * .16, h * .52);
    path.cubicTo(w * .16, h * .28, w * .42, h * .20, w * .50, h * .40);
    path.cubicTo(w * .60, h * .19, w * .85, h * .29, w * .84, h * .52);
    path.cubicTo(w * .83, h * .68, w * .67, h * .78, w * .50, h * .90);
    path.cubicTo(w * .31, h * .77, w * .17, h * .67, w * .16, h * .52);
    canvas.drawPath(path, p);

    final pulse = Path()
      ..moveTo(w * .15, h * .56)
      ..lineTo(w * .36, h * .56)
      ..lineTo(w * .43, h * .43)
      ..lineTo(w * .52, h * .69)
      ..lineTo(w * .61, h * .50)
      ..lineTo(w * .69, h * .56)
      ..lineTo(w * .86, h * .56);
    canvas.drawPath(pulse, p..strokeWidth = size.width * .055);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TinyRating extends StatelessWidget {
  const TinyRating(this.value, {super.key});
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(CupertinoIcons.star_fill, size: 15, color: Color(0xFFFFC857)),
        const SizedBox(width: 4),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ],
    );
  }
}

class AnimatedAppear extends StatefulWidget {
  const AnimatedAppear({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<AnimatedAppear> createState() => _AnimatedAppearState();
}

class _AnimatedAppearState extends State<AnimatedAppear>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.slow,
  );
  late final Animation<double> _opacity =
      CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  late final Animation<Offset> _offset = Tween<Offset>(
    begin: const Offset(0, .05),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: AppMotion.curve));

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}

class SuccessPulse extends StatelessWidget {
  const SuccessPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 720),
      tween: Tween(begin: .3, end: 1),
      curve: Curves.elasticOut,
      builder: (context, value, child) => Transform.scale(
        scale: value > 1 ? 1 : value,
        child: child,
      ),
      child: Container(
        width: 116,
        height: 116,
        decoration: const BoxDecoration(
          color: AppColors.softBlue,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          CupertinoIcons.check_mark_circled_solid,
          size: 74,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
