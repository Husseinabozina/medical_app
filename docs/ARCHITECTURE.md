# Architecture & delivery notes

## Why this structure

HealthTrack is a showcase application with no dedicated backend. The architecture therefore demonstrates clean boundaries without adding layers that would exist only for ceremony.

### Domain

`health_domain.dart` contains entities and the `HealthRepository` contract. The UI depends on the contract, not on Firebase, REST, or local persistence.

### Data

`DemoHealthRepository` is the current replaceable implementation. A future REST/Firebase implementation can be introduced without changing the presentation widgets.

### Presentation state

- `FavoritesCubit` owns the favorite doctor set.
- `BookingCubit` owns selected date, time, and payment method.

Local text-field and switch state remains local when it has no cross-screen business meaning.

## Figma fidelity rules

1. 360×800 is the visual reference size for most source frames.
2. Flutter layout remains responsive up to a 430px constrained content width.
3. Directional padding/alignment APIs are used where practical.
4. Figma screenshots are reference-only, never shipped as screen images.
5. Reusable visual patterns are implemented once: soft cards, primary buttons, doctor avatars, ratings, headers, logo, motion.
6. The original kit uses real doctor photography; this portfolio version uses abstract initials to avoid shipping face photography while preserving the card geometry.

## Motion gate

Animations must satisfy all of the following:

- communicates state or hierarchy;
- normally completes in under 550ms;
- does not block interaction;
- avoids repeated large-scale motion on medical information;
- respects the calm/trustworthy product character.

## Next production-hardening step

When moving beyond portfolio/demo scope:

- add API/data-source implementations;
- add localization and full RTL QA;
- add accessibility semantics and dynamic text scaling review;
- add golden tests against Figma reference screenshots;
- add CI for format/analyze/test;
- add secure backend/payment integration instead of demo payment state.
