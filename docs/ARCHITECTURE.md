# Architecture & delivery notes

## Why this structure

HealthTrack is a showcase application with no dedicated backend. The architecture therefore demonstrates clean boundaries without adding layers that would exist only for ceremony.

### Domain

`health_domain.dart` contains the portfolio entities plus the `HealthRepository` and `HealthDataSource` contracts. Presentation code depends on the repository contract rather than Firebase, REST, local persistence, or demo fixtures.

### Data

`MockHealthDataSource` owns deterministic showcase fixtures plus process-local mutable state. `HealthRepositoryImpl` delegates to the injected data source and is provided through `RepositoryProvider`.

That keeps the execution path explicit:

```text
Screen -> Cubit / presentation interaction -> HealthRepository -> HealthDataSource
```

A future REST/Firebase data source can replace the mock implementation without changing screen widgets. `HealthBackendFactory` keeps that swap explicit through the `BACKEND_MODE` environment switch.

### Presentation state

- `FavoritesCubit` owns presentation state for favorites while persisting each toggle through `HealthRepository`.
- `BookingCubit` owns selected date, time, and payment method.
- Local text-field and switch state remains local when it has no cross-screen business meaning.

This is intentionally pragmatic Clean Architecture: boundaries that make replacement/testing useful are kept; empty use-case classes are not added only for ceremony.

### Mock runtime behavior

The mock backend simulates short API latency and supports session mutations for favorites, messages, appointments, medical records, payment cards and profile data. It is intentionally reversible: the presentation and domain layers depend on contracts, not on the mock implementation itself.

The mock store is in-memory only, so a full app restart resets fixture state.

## Figma fidelity rules

1. 360×800 is the visual reference size for most source frames.
2. Flutter layout remains responsive up to a 430px constrained content width.
3. Directional padding/alignment APIs are used where practical.
4. Figma screenshots are reference-only, never shipped as screen images.
5. Reusable visual patterns are implemented once: soft cards, primary buttons, doctor avatars, ratings, headers, logo, and motion.
6. The original kit uses real doctor photography; this portfolio version uses abstract initials to avoid shipping face photography while preserving card geometry.
7. All 61 top-level HealthTrack source frames are implemented. Repeated specialty/favorite variants reuse shared Flutter components while retaining distinct routes and source-frame mappings.

## Motion gate

Animations must satisfy all of the following:

- communicate state or hierarchy;
- normally complete in under 550ms;
- do not block interaction;
- avoid repeated large-scale motion around medical information;
- respect the calm/trustworthy product character.

The implementation uses a splash pulse, staggered content entrance, short fade/slide route transitions, animated selections, favorite-state feedback, expandable FAQ content, and restrained success confirmation.

## Automated quality gate

GitHub Actions runs `flutter pub get`, `flutter analyze`, and `flutter test` for this feature branch and pull requests. The route catalog test also locks the portfolio scope to exactly 61 unique screen routes.

## Next production-hardening step

When moving beyond portfolio/demo scope:

- replace `DemoHealthDataSource` with API/Firebase-backed data sources;
- add localization and full RTL QA;
- add accessibility semantics and dynamic text scaling review;
- add golden tests against approved Figma reference screenshots;
- add secure backend/payment integration instead of demo payment state.
