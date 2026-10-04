# Architecture

HealthTrack uses a pragmatic Clean Architecture suitable for a portfolio app rather than pretending to have a production backend that does not exist.

## Layers

- `domain/entities`: doctor, appointment, and pharmacy business models.
- `domain/repositories`: abstract `HealthRepository` contract.
- `data/repositories`: deterministic mock implementation used by the showcase.
- `presentation/cubit`: shared interaction state for doctors, appointments and pharmacy data.
- `presentation/screens`: 30 routed screens grouped by user journey.
- `core/design`: colors, typography/theme, and motion tokens.
- `core/widgets`: reusable UI primitives built from the extracted visual language.
- `core/navigation`: central routes and GoRouter setup.

## Why this shape

The project demonstrates layer boundaries, dependency inversion and testable state without adding unnecessary networking, persistence or generated boilerplate. The data source can later be replaced with REST/Firebase without rewriting the UI contracts.

## Directionality and localization

User-visible labels are sourced through `easy_localization`. Layout uses directional padding/alignment so Arabic flips naturally. Names, dates and mock domain data remain data rather than localization keys.
