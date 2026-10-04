# HealthTrack — Flutter Portfolio App

A 30-screen Flutter recreation of the **HealthTrack** Figma Community medical UI kit, built as a portfolio project rather than a production healthcare system.

## Goal

The project follows the same Figma-to-Flutter workflow used in the earlier UI portfolio work:

- inspect the exact Figma frame before implementation;
- preserve the visual DNA instead of pasting screenshots into the app;
- use a reusable design system and feature-first structure;
- keep the architecture pragmatic and portfolio-readable;
- add calm, purpose-built motion instead of decorative animation overload;
- keep navigation and core interactions working.

Figma source: **Medical App UI Kit / Health Mobile App Tracker / Appointment Mobile App**  
Source file key: `jrf18b58l0rdFM4uTN5DEg`

## 30 implemented screens

| # | Figma screen | Node | Flutter route |
|---|---|---|---|
| 01 | First Screen | `2279:1229` | `/` |
| 02 | Register | `2279:1230` | `/register` |
| 03 | Onboarding A | `2124:45` | `/onboarding/1` |
| 04 | Onboarding B | `2146:472` | `/onboarding/2` |
| 05 | Onboarding C | `2146:499` | `/onboarding/3` |
| 06 | Log In A | `2109:103` | `/login` |
| 07 | Log In B | `2109:140` | `/login/form` |
| 08 | Sign Up | `2109:169` | `/signup` |
| 09 | Set Password | `2109:216` | `/set-password` |
| 10 | Home | `2213:326` | `/home` |
| 11 | Specialties | `2068:756` | `/specialties` |
| 12 | Cardiology Doctors | `2237:1423` | `/specialties/cardiology` |
| 13 | Doctors | `2068:376` | `/doctors` |
| 14 | Doctor Info | `2112:1361` | `/doctor/:id` |
| 15 | Favorite Doctor | `2112:802` | `/favorites` |
| 16 | Profile | `2133:1964` | `/profile` |
| 17 | Settings | `2133:2024` | `/settings` |
| 18 | Notification | `2112:1667` | `/notifications` |
| 19 | Message | `2112:1720` | `/message` |
| 20 | Filter | `2079:520` | `/filter` |
| 21 | Doctor Profile | `2097:1242` | `/doctor/:id/profile` |
| 22 | Schedule | `2088:1073` | `/doctor/:id/schedule` |
| 23 | Appointment Upcoming | `2194:422` | `/appointments/upcoming` |
| 24 | Appointment Details | `2088:1187` | `/appointments/details` |
| 25 | Review | `2111:1410` | `/review` |
| 26 | Pharmacy | `2078:1049` | `/pharmacy` |
| 27 | Medical Record | `2076:911` | `/medical-record` |
| 28 | Payment Method | `2128:1556` | `/payment/method` |
| 29 | Payment Summary | `2128:1624` | `/payment/summary` |
| 30 | Payment Successfully | `2128:1676` | `/payment/success` |

The source Figma contains 61 top-level frames. We intentionally selected 30 screens that cover complete product flows instead of repeating near-identical specialty/doctor variants.

## Design system

Figma-derived core palette:

- Aqua: `#33E4DB`
- Cyan: `#00BBD3`
- Primary: `#13CAD6`
- Soft blue: `#E9F6FE`
- Pale lilac: `#ECF1FF`
- Ink: `#252525`

The UI uses soft rounded cards, low-contrast medical surfaces, high readability, restrained shadows and consistent 18–24px radii.

## Motion language

Motion is deliberately calm and short:

- splash pulse for the HealthTrack mark;
- onboarding illustration scale/fade;
- staggered list/card entry;
- subtle favorite state scale;
- animated date/time and payment selections;
- fade + slight slide route transition;
- elastic success confirmation.

The app avoids aggressive bounce, flashy parallax, or long transitions because they conflict with the trustworthy medical tone.

## Architecture

```text
lib/
  app/
    health_track_app.dart
  core/
    design_system.dart
    health_domain.dart
    health_state.dart
  features/
    auth/
    home/
    account/
    appointments/
    services/
    payments/
  router/
    app_router.dart
```

This is a **pragmatic Clean Architecture** portfolio implementation:

- domain models + repository contract are UI-independent;
- `DemoHealthRepository` is the replaceable data implementation;
- Cubits own interactive state such as favorites and booking selections;
- screens do not contain networking code;
- reusable UI/motion tokens live in `core/design_system.dart`.

The current repo intentionally uses demo data and no real medical or payment backend.

## Run locally

The repository was initialized source-first. If generated platform folders are not present yet, run once from the repo root:

```bash
flutter create . --platforms=android,ios,web,macos
flutter pub get
flutter analyze
flutter test
flutter run
```

After the first `flutter create .`, keep the existing `lib/`, `test/`, `pubspec.yaml`, and architecture files from this branch.

## Privacy / visual asset note

No Figma screenshot is used as a production UI asset. Doctor visuals are intentionally represented with abstract initial-based avatars rather than real human-face photography, while keeping the layout hierarchy and medical visual character.
