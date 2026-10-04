import 'package:flutter/material.dart';

import '../core/design_system.dart';
import '../router/app_router.dart';

class HealthTrackApp extends StatelessWidget {
  const HealthTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HealthTrack',
      theme: HealthTheme.light,
      routerConfig: appRouter,
    );
  }
}
