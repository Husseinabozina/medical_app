# HealthTrack showcase specification

Build a polished Flutter portfolio app from 30 representative HealthTrack Figma frames. Preserve the visual system and core user journeys, provide English/Arabic direction-aware UI, and use mock data only. No production health claims, backend, payment processing, or real patient data are in scope.

## Acceptance criteria

1. `AppRoutes.portfolioScreens` contains exactly 30 unique routes.
2. Every selected Figma flow is represented and reachable by router configuration.
3. Domain models and repository contract do not depend on Flutter UI.
4. UI obtains sample doctors/appointments/pharmacies through a mock repository and Cubit.
5. Shared colors, typography and motion live under `core` rather than being recreated per screen.
6. Arabic/English localization assets exist and layouts use directional APIs.
7. No Figma screenshot is embedded as a production screen.
8. No real person photograph is shipped in the app.
9. CI runs `flutter analyze` and `flutter test`.
