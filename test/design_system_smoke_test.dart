import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/core/design_system.dart';

void main() {
  testWidgets('HealthTrack design system renders its logo', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: ColoredBox(
              color: AppColors.primary,
              child: HealthLogo(),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(HealthLogo), findsOneWidget);
  });

  test('core Figma palette remains stable', () {
    expect(AppColors.primary, const Color(0xFF13CAD6));
    expect(AppColors.aqua, const Color(0xFF33E4DB));
    expect(AppColors.cyan, const Color(0xFF00BBD3));
  });
}
