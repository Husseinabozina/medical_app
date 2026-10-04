import 'package:flutter/material.dart';

abstract final class AppMotion {
  static const quick = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 240);
  static const emphasized = Duration(milliseconds: 420);
  static const splash = Duration(milliseconds: 850);
  static const curve = Curves.easeOutCubic;
  static const emphasizedCurve = Curves.easeOutBack;

  static Duration of(BuildContext context, Duration duration) {
    final media = MediaQuery.maybeOf(context);
    return media?.disableAnimations == true ? Duration.zero : duration;
  }
}
