import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_app/core/design_system.dart';

void main() {
  testWidgets('back from a root-level favorites route falls back to home',
      (tester) async {
    final router = GoRouter(
      initialLocation: '/favorites',
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const Scaffold(body: Text('Home screen')),
        ),
        GoRoute(
          path: '/favorites',
          builder: (_, __) => const HealthScaffold(
            title: 'Favorites',
            showBack: true,
            child: Text('Favorites screen'),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        theme: HealthTheme.light,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Favorites screen'), findsOneWidget);

    await tester.tap(find.byIcon(CupertinoIcons.back));
    await tester.pumpAndSettle();

    expect(find.text('Home screen'), findsOneWidget);
  });
}
