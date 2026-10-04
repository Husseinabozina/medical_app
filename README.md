# HealthTrack — Flutter Portfolio App

A 61-screen Flutter recreation of the complete **HealthTrack** Figma Community medical UI kit, built as a portfolio project rather than a production healthcare system.

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

## 61 implemented screens

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

| 31 | Dermatology Doctors | `2237:1809` | `/specialties/dermatology` |
| 32 | General Doctors | `2237:2227` | `/specialties/general` |
| 33 | Gynecology Doctors | `2237:2351` | `/specialties/gynecology` |
| 34 | Odontology Doctors | `2237:2592` | `/specialties/odontology` |
| 35 | Oncology Doctors | `2237:2715` | `/specialties/oncology` |
| 36 | Ophthalmology Doctors | `2243:1478` | `/specialties/ophthalmology` |
| 37 | Orthopedics Doctors | `2243:1596` | `/specialties/orthopedics` |
| 38 | Doctor Rating | `2112:1184` | `/favorites/rating` |
| 39 | Favorite Services | `2112:728` | `/favorites/services` |
| 40 | Favorite Female Doctors | `2112:912` | `/favorites/female` |
| 41 | Favorite Male Doctors | `2112:1045` | `/favorites/male` |
| 42 | Edit Profile | `2133:2100` | `/profile/edit` |
| 43 | Notification Setting | `2133:2058` | `/settings/notifications` |
| 44 | Password Manager | `2133:2138` | `/settings/password-manager` |
| 45 | Privacy Policy | `2133:2044` | `/settings/privacy` |
| 46 | Help Center FAQ | `2052:4238` | `/help/faq` |
| 47 | Help Center Contact Us | `2133:2220` | `/help/contact` |
| 48 | Logout | `2221:336` | `/logout` |
| 49 | Appointment Complete | `2194:608` | `/appointments/complete` |
| 50 | Appointment Cancelled | `2194:545` | `/appointments/cancelled` |
| 51 | Cancel Appointment | `2111:1373` | `/appointments/cancel` |
| 52 | Pharmacy Filter | `2078:1198` | `/pharmacy/filter` |
| 53 | Pharmacy Details | `2078:1239` | `/pharmacy/details` |
| 54 | Medical Record Add Record | `2097:1121` | `/medical-record/add` |
| 55 | Medical Record Menu | `2110:221` | `/medical-record/menu` |
| 56 | Allergies | `2213:552` | `/medical-record/allergies` |
| 57 | Analysis | `2107:156` | `/medical-record/analysis` |
| 58 | Analysis Details | `2107:508` | `/medical-record/analysis/detail` |
| 59 | Vaccinations | `2107:188` | `/medical-record/vaccinations` |
| 60 | Medical History | `2107:220` | `/medical-record/history` |
| 61 | Payment Method — Add Card | `2128:1588` | `/payment/add-card` |

All **61 top-level HealthTrack UI frames** from the Figma page are now represented in Flutter. Repeated doctor/specialty layouts share reusable widgets internally, while each source frame keeps its own route and portfolio state.

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
    extended/
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

## Mock backend

HealthTrack now includes a mutable in-memory backend for portfolio/runtime testing.

It covers:

- doctors, specialties and pharmacies;
- favorite mutations;
- chat message sending;
- appointment cancellation and re-booking;
- medical-record creation;
- saved payment-card creation;
- profile updates.

The mock backend deliberately adds a short artificial delay so loading/interaction behavior is closer to a real API. Data survives for the current app process only and resets on restart.

The backend is selected through `BACKEND_MODE`. The current project ships only the mock implementation; `real` is intentionally reserved for a future REST/Firebase adapter and fails fast instead of silently falling back.

VS Code/Cursor includes a **HealthTrack — Mock** launch configuration.

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
