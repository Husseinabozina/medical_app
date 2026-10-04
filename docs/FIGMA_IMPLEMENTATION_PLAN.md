# Figma implementation plan

Source file: `Medical App UI Kit - Health Mobile App Tracker Appointment Mobile App (Community)`

The linked HealthTrack page contains 61 frames. The portfolio scope intentionally chooses 30 screens that create complete journeys instead of duplicating every specialty variant.

## Selected 30 frames

| # | Figma frame | Node | Route |
|---|---|---|---|
| 1 | 01 - A - First Screen | 2279:1229 | `/` |
| 2 | 02 - A - Register | 2279:1230 | `/entry` |
| 3 | 03 - A - Onboarding | 2124:45 | `/onboarding/doctor` |
| 4 | 03 - B - Onboarding | 2146:472 | `/onboarding/schedule` |
| 5 | 03 - C - Onboarding | 2146:499 | `/onboarding/records` |
| 6 | 04 - A - Log In | 2109:103 | `/auth/login` |
| 7 | 04 - B - Log In | 2109:140 | `/auth/hello-login` |
| 8 | 04 - C - Sign Up | 2109:169 | `/auth/sign-up` |
| 9 | 04 - D - Set Password | 2109:216 | `/auth/set-password` |
| 10 | 05 - A - Home | 2213:326 | `/home` |
| 11 | 06 - A - Specialties | 2068:756 | `/specialties` |
| 12 | 06 - B - Cardiology Doc | 2237:1423 | `/specialties/cardiology` |
| 13 | 07 - A - Doctors | 2068:376 | `/doctors` |
| 14 | 07 - B - Info Doctors | 2112:1361 | `/doctors/info` |
| 15 | 07 - D - Favorite Doc | 2112:802 | `/doctors/favorites` |
| 16 | 08 - A - Profile | 2133:1964 | `/profile` |
| 17 | 08 - C - Settings | 2133:2024 | `/profile/settings` |
| 18 | 09 - A - Notification | 2112:1667 | `/notifications` |
| 19 | 09 - B - Message | 2112:1720 | `/messages` |
| 20 | 10 - A - Filter | 2079:520 | `/doctors/filters` |
| 21 | 11 - A - Doctor Profile | 2097:1242 | `/doctors/profile` |
| 22 | 11 - B - Schedule | 2088:1073 | `/appointments/schedule` |
| 23 | 12 - B - Appointment Upcoming | 2194:422 | `/appointments` |
| 24 | 12 - D - Appointment Details | 2088:1187 | `/appointments/details` |
| 25 | 12 - F - Review | 2111:1410 | `/appointments/review` |
| 26 | 13 - A - Pharmacy | 2078:1049 | `/pharmacy` |
| 27 | 14 - A - Medical Record | 2076:911 | `/medical-record` |
| 28 | 15 - A - Payment Method | 2128:1556 | `/payment/method` |
| 29 | 15 - C - Payment Summary | 2128:1624 | `/payment/summary` |
| 30 | 15 - D - Payment Successfully | 2128:1676 | `/payment/success` |

## Visual DNA extracted from Figma

- Primary gradient: `#33E4DB` → `#00BBD3`.
- Core aqua: `#13CAD6`.
- Dark text: `#252525`.
- Ice surfaces: `#E9F6FE` / `#ECF2FF`.
- Primary type family: League Spartan; logo accent uses Inter.
- Frequent radii: 13, 16, 18, 20, 30, 50, 100.
- Pattern language: turquoise headers, pill controls, rounded cards, light-blue fields, compact line icons and a persistent bottom navigation.

## Intentional deviations

- Real clinician/profile photographs in the source kit are replaced by stylized, non-photographic avatars. The hierarchy, sizes and placement remain aligned with the design.
- Lorem ipsum is replaced with meaningful demo copy.
- Static 360 px Figma dimensions are translated into flexible Flutter layouts so the UI remains usable across phone widths.
- The original file contains no motion/prototype metadata on the inspected splash/onboarding/home/payment-success frames, so motion is added as a product enhancement rather than copied from Figma.
