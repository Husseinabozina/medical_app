import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/health_track_app.dart';
import 'core/health_domain.dart';
import 'core/health_state.dart';
import 'data/health_repository_impl.dart';
import 'data/mock/mock_health_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RepositoryProvider<HealthRepository>(
      create: (_) => HealthRepositoryImpl(
        dataSource: MockHealthDataSource(),
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
