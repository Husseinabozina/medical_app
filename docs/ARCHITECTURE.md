# Architecture & delivery notes

## Why this structure

HealthTrack is a showcase application with no dedicated backend. The architecture therefore demonstrates clean boundaries without adding layers that would exist only for ceremony.

### Domain

`health_domain.dart` contains the portfolio entities plus the `HealthRepository` and `HealthDataSource` contracts. Presentation code depends on the repository contract rather than Firebase, REST, local persistence, or demo fixtures.

### Data

`DemoHealthDataSource` owns deterministic showcase data. `DemoHealthRepository` delegates to that data source and is injected through `RepositoryProvider`.

That keeps the execution path explicit:

```text
Screen -> Cubit / presentation interaction -> HealthRepository -> HealthDataSource
```

A future REST/Firebase data source can replace the demo implementation without changing the screen widgets.

### Presentation state

- `FavoritesCubit` owns the favorite doctor set.
- `BookingCubit` owns selected date, time, and payment method.
- Local text-field and switch state remains local when it has no cross-screen business meaning.

This is intentionally pragmatic Clean Architecture: boundaries that make replacement/testing useful are kept; empty use-case classes are not added only for ceremony.

## Figma fidelity rules

1. 360×800 is the visual reference size for most source frames.
2. Flutter layout remains responsive up to a 430px constrained content width.
3. Directional padding/alignment APIs are used where practical.
4. Figma screenshots are reference-only, never shipped as screen images.
5. Reusable visual patterns are implemented once: soft cards, primary buttons, doctor avatars, ratings, headers, logo, and motion.
6. The original kit uses real doctor photography; this portfolio version uses abstract initials to avoid shipping face photography while preserving card geometry.
7. The 61 source frames are reduced to 30 deliberately selected screens that cover distinct product flows instead of repeating near-identical specialty variants.

## Motion gate

Animations must satisfy all of the following:

- communicate state or hierarchy;
- normally complete in under 550ms;
- do not block interaction;
- avoid repeated large-scale motion around medical information;
- respect the calm/trustworthy product character.

The implementation uses a splash pulse, staggered content entrance, short fade/slide route transitions, animated selections, favorite-state feedback, and a restrained success confirmation.

## Automated quality gate

GitHub Actions runs `flutter pub get`, `flutter analyze`, and `flutter test` for this feature branch and pull requests. The route catalog test also locks the portfolio scope to exactly 30 unique screen routes.

## Next production-hardening step

When moving beyond portfolio/demo scope:

- replace `DemoHealthDataSource` with API/Firebase-backed data sources;
- add localization and full RTL QA;
- add accessibility semantics and dynamic text scaling review;
- add golden tests against approved Figma reference screenshots;
- add secure backend/payment integration instead of demo payment state.
