import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/design/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'data/repositories/mock_health_repository.dart';
import 'presentation/cubit/health_cubit.dart';

class HealthTrackApp extends StatelessWidget {
  const HealthTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MockHealthRepository(),
      child: BlocProvider(
        create: (context) => HealthCubit(context.read<MockHealthRepository>())..load(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'HealthTrack',
          theme: AppTheme.light,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
