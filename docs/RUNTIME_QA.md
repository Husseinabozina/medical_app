# Runtime QA checklist

Run the portfolio in mock mode:

```bash
flutter run --dart-define=BACKEND_MODE=mock
```

## Critical 10-minute smoke pass

1. Auth/onboarding
   - Splash → Register → Onboarding 1/2/3 → Login.
   - Every forward/back action responds once and no route gets stuck.

2. Home CTAs
   - **View all** opens Specialties.
   - **Details** opens Appointment details.
   - **See all** opens Doctors.
   - Quick access opens Doctors, Specialties, Pharmacy and Medical Record.

3. Favorites regression
   - Home bottom navigation → Favorites.
   - Tap the back arrow.
   - It must return to Home even though bottom navigation used `go()`.
   - Toggle a favorite, leave, return, and verify the mock-session state is preserved.

4. Doctor/booking/payment
   - Doctors → Doctor info → Full profile → Schedule.
   - Pick date/time → Payment method → Add Card → Save Card.
   - Back arrows must return to the logical parent route.
   - Complete payment demo and open appointment details.

5. Appointments
   - Upcoming → Details.
   - Cancel → choose reason → Cancel Appointment → Cancelled.
   - Complete → Re-Book → schedule.
   - No dead tabs/buttons.

6. Messaging
   - Open Message.
   - Type and send a message.
   - Sending indicator appears briefly and the sent message remains in the mock session.

7. Profile/settings/help
   - Profile → Edit profile → update.
   - Settings → Notification settings / Password manager / Privacy policy.
   - Help → FAQ / Contact Us.
   - Logout → Cancel returns to Profile; confirmation returns to Login.

8. Pharmacy
   - Pharmacy → Filter → Details.
   - All back arrows work.
   - No overflow around cards/map placeholder.

9. Medical record
   - Medical Record → Add Record → Save.
   - Menu → Allergies / Analysis / Analysis detail / Vaccinations / Medical History.
   - Back arrows follow the logical hierarchy.

10. Visual gate
    - No overflow warnings.
    - No crashes/exceptions.
    - No clipped text at 360×800 reference size.
    - Header, cards, gradients, spacing and typography remain visually close to Figma.
    - Motion remains short, calm and non-blocking.

## Automated gates

CI must stay green for:

- `flutter analyze`
- `flutter test`
- 61 unique portfolio routes
- mock backend mutation tests
- back-navigation fallback tests
- widget regression for Favorites → Back → Home

Do not merge PR #1 until the simulator visual pass is complete.
