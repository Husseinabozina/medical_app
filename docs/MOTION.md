# Motion language

HealthTrack motion is calm and functional: it should signal continuity, confidence and successful completion without feeling playful or distracting.

- Splash: one soft scale/fade reveal with a tiny settling rotation.
- Onboarding: content fades/slides into place; page changes remain direct and quick.
- Buttons: subtle 0.975 press scale.
- Pills/date/time selections: short `AnimatedContainer` transitions.
- Lists/cards: reusable fade-up `Appear` wrapper is available for staged entrances.
- Payment success: one emphasized checkmark scale reveal.
- Reduced motion: durations resolve to zero when `MediaQuery.disableAnimations` is enabled where the shared motion helper is used.

Default timing: 150 ms quick, 240 ms standard, 420 ms emphasized.
