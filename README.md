# HealthTrack — Flutter Medical Portfolio App

HealthTrack is a 30-screen Flutter portfolio/showcase implementation inspired by the linked Figma Community medical UI kit. The project intentionally treats Figma as a design reference rather than generated web code.

## What is implemented

- Exactly 30 routed product screens covering splash, onboarding, authentication, home, specialties, doctors, favorites, profile, settings, notifications, chat, filters, doctor profile, scheduling, appointments, reviews, pharmacy, medical records, payment and payment success.
- Feature-oriented Clean Architecture: presentation (screens + Cubit), domain entities/repository contract, and a mock data repository.
- A shared HealthTrack design system based on the Figma palette: aqua gradients, ice-blue surfaces, rounded pills/cards, and League Spartan typography.
- Responsive Flutter layout using normal Row/Column/Grid/List primitives rather than fixed screenshot recreation.
- Arabic + English localization with RTL-aware directional padding/alignment.
- Motion system with short, calm healthcare-oriented transitions and reduced-motion awareness.
- No backend and no real patient data. The repository is deliberately a portfolio demo.
- Real-person Figma headshots are deliberately replaced with stylized avatar placeholders while retaining the visual hierarchy and layout.

## Run

This repository focuses on the app source. If native runner folders are not present in your local clone, create them once:

```bash
flutter create . --project-name medical_app --platforms=android,ios,web
flutter pub get
flutter run
```

Then validate:

```bash
flutter analyze
flutter test
```

## Architecture

See `docs/ARCHITECTURE.md`, `docs/FIGMA_IMPLEMENTATION_PLAN.md`, and `docs/MOTION.md`.
