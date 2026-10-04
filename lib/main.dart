import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/health_track_app.dart';
import 'core/app_environment.dart';
import 'core/health_domain.dart';
import 'core/health_state.dart';
import 'data/backend_factory.dart';
import 'data/health_repository_impl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RepositoryProvider<HealthRepository>(
      create: (_) => HealthRepositoryImpl(
        dataSource: HealthBackendFactory.create(AppEnvironment.backendMode),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FavoritesCubit(context.read<HealthRepository>()),
          ),
          BlocProvider(create: (_) => BookingCubit()),
        ],
        child: const HealthTrackApp(),
      ),
    ),
  );
}
