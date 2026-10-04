import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/app_colors.dart';
import '../design/motion.dart';
import '../navigation/app_routes.dart';

const _primaryGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.aquaBright, AppColors.aquaDeep],
);

class HealthPage extends StatelessWidget {
  const HealthPage({
    required this.child,
    super.key,
    this.bottomNavigationBar,
    this.backgroundColor = AppColors.surface,
  });

  final Widget child;
  final Widget? bottomNavigationBar;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(top: false, child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class AquaHeader extends StatelessWidget {
  const AquaHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.onBack,
    this.trailing,
    this.height = 98,
    this.centerTitle = true,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Widget? trailing;
  final double height;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      height: height + top,
      padding: EdgeInsetsDirectional.fromSTEB(24, top + 10, 24, 12),
      decoration: const BoxDecoration(gradient: _primaryGradient),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (onBack != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onBack,
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? CupertinoIcons.chevron_right
                      : CupertinoIcons.chevron_left,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          Align(
            alignment: centerTitle ? Alignment.center : AlignmentDirectional.centerStart,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null)
            Align(alignment: AlignmentDirectional.centerEnd, child: trailing!),
        ],
      ),
    );
  }
}

class GradientButton extends StatefulWidget {
  const GradientButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.width,
    this.height = 48,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool outlined;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.quick);
    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => setState(() => _pressed = true),
      onTapCancel: widget.onPressed == null ? null : () => setState(() => _pressed = false),
      onTapUp: widget.onPressed == null
          ? null
          : (_) {
              setState(() => _pressed = false);
              widget.onPressed?.call();
            },
      child: AnimatedScale(
        scale: _pressed ? .975 : 1,
        duration: duration,
        curve: AppMotion.curve,
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: widget.outlined ? null : _primaryGradient,
            color: widget.outlined ? Colors.white : null,
            borderRadius: BorderRadius.circular(100),
            border: widget.outlined ? Border.all(color: AppColors.aqua, width: 1.3) : null,
            boxShadow: widget.outlined
                ? null
                : [
                    BoxShadow(
                      color: AppColors.aquaDeep.withValues(alpha: .12),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: widget.outlined ? AppColors.aqua : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

class HealthTextField extends StatelessWidget {
  const HealthTextField({
    required this.label,
    super.key,
    this.hint,
    this.obscureText = false,
    this.trailing,
    this.maxLines = 1,
  });

  final String label;
  final String? hint;
  final bool obscureText;
  final Widget? trailing;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: maxLines,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.aqua),
            suffixIcon: trailing,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 13, 16, 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: AppColors.aqua),
            ),
          ),
        ),
      ],
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({
    required this.label,
    super.key,
    this.selected = false,
    this.onTap,
    this.padding = const EdgeInsetsDirectional.fromSTEB(14, 7, 14, 7),
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.quick),
        padding: padding,
        decoration: BoxDecoration(
          gradient: selected ? _primaryGradient : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.aqua),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected ? Colors.white : AppColors.ink,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.hint});

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          hintText: hint ?? 'common.search'.tr(),
          hintStyle: const TextStyle(color: AppColors.aqua),
          prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.aqua, size: 20),
          contentPadding: const EdgeInsetsDirectional.only(top: 9),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.aqua,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(action!, style: const TextStyle(color: AppColors.aqua)),
          ),
      ],
    );
  }
}

class InitialAvatar extends StatelessWidget {
  const InitialAvatar({required this.name, super.key, this.size = 76, this.emphasized = false});

  final String name;
  final double size;
  final bool emphasized;

  String get initials {
    final cleaned = name.replaceAll('Dr.', '').replaceAll('M.D.', '').trim();
    final parts = cleaned.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'HT';
    return parts.take(2).map((e) => e.characters.first.toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: emphasized
              ? const [AppColors.avatarLavender, AppColors.aquaBright]
              : const [AppColors.ice, Color(0xFFCDEAF6)],
        ),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(CupertinoIcons.person_fill, size: size * .48, color: AppColors.aquaDeep.withValues(alpha: .75)),
          PositionedDirectional(
            end: 2,
            bottom: 2,
            child: Container(
              width: size * .34,
              height: size * .34,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Text(
                initials,
                style: TextStyle(fontSize: size * .11, fontWeight: FontWeight.w700, color: AppColors.aquaDeep),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorRow extends StatelessWidget {
  const DoctorRow({
    required this.name,
    required this.specialty,
    super.key,
    this.favorite = false,
    this.onTap,
    this.onFavorite,
    this.cta,
  });

  final String name;
  final String specialty;
  final bool favorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final Widget? cta;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
        child: Row(
          children: [
            InitialAvatar(name: name, size: 76),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(specialty, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 7),
                  cta ?? Pill(label: 'common.info'.tr()),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavorite,
              icon: Icon(favorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: AppColors.aqua),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthBottomNav extends StatelessWidget {
  const HealthBottomNav({required this.currentIndex, super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final entries = <({IconData icon, String route})>[
      (icon: CupertinoIcons.house, route: AppRoutes.home),
      (icon: CupertinoIcons.chat_bubble_2, route: AppRoutes.messages),
      (icon: CupertinoIcons.person, route: AppRoutes.profile),
      (icon: CupertinoIcons.calendar, route: AppRoutes.appointments),
    ];
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
        color: AppColors.ice,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(entries.length, (index) {
            final selected = currentIndex == index;
            return IconButton(
              onPressed: () => context.go(entries[index].route),
              icon: AnimatedContainer(
                duration: AppMotion.of(context, AppMotion.quick),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  entries[index].icon,
                  color: AppColors.aqua,
                  size: selected ? 25 : 23,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Appear extends StatefulWidget {
  const Appear({required this.child, super.key, this.delay = Duration.zero, this.offset = const Offset(0, .06)});

  final Widget child;
  final Duration delay;
  final Offset offset;

  @override
  State<Appear> createState() => _AppearState();
}

class _AppearState extends State<Appear> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.standard);
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: duration,
      curve: AppMotion.curve,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : widget.offset,
        duration: duration,
        curve: AppMotion.curve,
        child: widget.child,
      ),
    );
  }
}

class MedicalMark extends StatelessWidget {
  const MedicalMark({super.key, this.size = 180, this.color = Colors.white});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _MedicalMarkPainter(color));
  }
}

class _MedicalMarkPainter extends CustomPainter {
  _MedicalMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * .025
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width * .44, stroke);

    final heart = Path()
      ..moveTo(size.width * .5, size.height * .72)
      ..cubicTo(size.width * .18, size.height * .50, size.width * .23, size.height * .23, size.width * .42, size.height * .26)
      ..cubicTo(size.width * .48, size.height * .27, size.width * .5, size.height * .32, size.width * .5, size.height * .32)
      ..cubicTo(size.width * .5, size.height * .32, size.width * .54, size.height * .25, size.width * .64, size.height * .25)
      ..cubicTo(size.width * .85, size.height * .25, size.width * .86, size.height * .53, size.width * .5, size.height * .72)
      ..close();
    canvas.drawPath(heart, fill);

    final cut = Paint()..color = AppColors.aqua;
    final cross = Path()
      ..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: size.width * .14, height: size.width * .36), Radius.circular(size.width * .03)))
      ..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: size.width * .36, height: size.width * .14), Radius.circular(size.width * .03)));
    canvas.drawPath(cross, cut);

    for (final angle in [0.15, 1.0, 3.7, 4.1]) {
      final point = center + Offset(math.cos(angle), math.sin(angle)) * size.width * .48;
      canvas.drawCircle(point, size.width * .02, fill);
    }
  }

  @override
  bool shouldRepaint(covariant _MedicalMarkPainter oldDelegate) => oldDelegate.color != color;
}

class SpecialtyTile extends StatelessWidget {
  const SpecialtyTile({required this.label, required this.icon, super.key, this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(gradient: _primaryGradient, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class SoftCard extends StatelessWidget {
  const SoftCard({required this.child, super.key, this.padding = const EdgeInsets.all(16), this.color = AppColors.ice});

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}

class InfoChip extends StatelessWidget {
  const InfoChip({required this.icon, required this.label, super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColors.aqua)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 14, color: AppColors.aqua), const SizedBox(width: 5), Text(label)]),
    );
  }
}

class BrandIllustration extends StatelessWidget {
  const BrandIllustration({required this.kind, super.key, this.height = 260});

  final int kind;
  final double height;

  @override
  Widget build(BuildContext context) {
    final icon = switch (kind) {
      1 => CupertinoIcons.person_2_fill,
      2 => CupertinoIcons.calendar_badge_plus,
      _ => CupertinoIcons.doc_text_fill,
    };
    final accent = switch (kind) {
      1 => AppColors.avatarBlue,
      2 => AppColors.warning,
      _ => AppColors.avatarLavender,
    };
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, AppColors.iceSoft.withValues(alpha: .65)],
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(220, 70)),
              ),
            ),
          ),
          Container(
            width: 188,
            height: 188,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.aqua),
          ),
          Transform.rotate(
            angle: kind == 2 ? -.08 : .04,
            child: Container(
              width: 155,
              height: 118,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 16, offset: const Offset(0, 7))],
              ),
              child: Icon(icon, color: Colors.white, size: 68),
            ),
          ),
          PositionedDirectional(top: 36, end: 38, child: _Sparkle(size: 18)),
          PositionedDirectional(bottom: 46, start: 38, child: _Sparkle(size: 12)),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Icon(CupertinoIcons.sparkles, size: size, color: AppColors.aquaBright);
}

class StarRating extends StatelessWidget {
  const StarRating({super.key, this.value = 4, this.size = 21});

  final int value;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => Icon(index < value ? CupertinoIcons.star_fill : CupertinoIcons.star, size: size, color: AppColors.aqua)),
    );
  }
}

class PagePadding extends StatelessWidget {
  const PagePadding({required this.child, super.key, this.top = 24});

  final Widget child;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsDirectional.fromSTEB(30, top, 30, 24), child: child);
  }
}

class ScreenBody extends StatelessWidget {
  const ScreenBody({required this.children, super.key, this.bottomPadding = 32});

  final List<Widget> children;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, bottomPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}
