import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/health_track_app.dart';
import 'core/health_domain.dart';
import 'core/health_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RepositoryProvider<HealthRepository>(
      create: (_) => DemoHealthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FavoritesCubit()),
          BlocProvider(create: (_) => BookingCubit()),
        ],
        child: const HealthTrackApp(),
      ),
    ),
  );
}
