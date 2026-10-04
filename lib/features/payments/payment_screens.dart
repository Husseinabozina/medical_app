import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../../core/health_domain.dart';
import '../../core/health_state.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Payment method',
      showBack: true,
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a payment method',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 16),
              _PaymentChoice(
                icon: CupertinoIcons.creditcard,
                title: 'Credit / Debit card',
                subtitle: '•••• 4242',
                selected: state.paymentMethod == 'Card',
                onTap: () =>
                    context.read<BookingCubit>().selectPayment('Card'),
              ),
              const SizedBox(height: 12),
              _PaymentChoice(
                icon: CupertinoIcons.money_dollar_circle,
                title: 'Pay at clinic',
                subtitle: 'Pay when you arrive',
                selected: state.paymentMethod == 'Clinic',
                onTap: () =>
                    context.read<BookingCubit>().selectPayment('Clinic'),
              ),
              const SizedBox(height: 12),
              _PaymentChoice(
                icon: CupertinoIcons.device_phone_portrait,
                title: 'Digital wallet',
                subtitle: 'Fast and secure',
                selected: state.paymentMethod == 'Wallet',
                onTap: () =>
                    context.read<BookingCubit>().selectPayment('Wallet'),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => context.push('/payment/add-card'),
                icon: const Icon(CupertinoIcons.add),
                label: const Text('Add Card'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SoftCard(
                color: AppColors.softBlue,
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.lock,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This portfolio flow uses demo payment data only. No card is charged.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                              height: 1.45,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.push('/payment/summary'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = context.read<HealthRepository>().doctors.first;

    return HealthScaffold(
      title: 'Payment summary',
      showBack: true,
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return Column(
            children: [
              SoftCard(
                color: AppColors.softBlue,
                child: Row(
                  children: [
                    DoctorAvatar(initials: doctor.initials, size: 64),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialty,
                            style: const TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    TinyRating(doctor.rating),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SoftCard(
                child: Column(
                  children: [
                    const _SummaryRow(label: 'Date', value: '12 October 2026'),
                    const Divider(height: 1),
                    _SummaryRow(label: 'Time', value: state.time),
                    const Divider(height: 1),
                    _SummaryRow(
                      label: 'Payment',
                      value: state.paymentMethod,
                    ),
                    const Divider(height: 1),
                    const _SummaryRow(
                      label: 'Consultation',
                      value: '\$45.00',
                    ),
                    const Divider(height: 1),
                    const _SummaryRow(
                      label: 'Booking fee',
                      value: '\$3.00',
                    ),
                    const Divider(height: 20),
                    const _SummaryRow(
                      label: 'Total',
                      value: '\$48.00',
                      strong: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              PrimaryButton(
                label: 'Confirm & pay',
                icon: CupertinoIcons.lock,
                onPressed: () => context.go('/payment/success'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Payment',
      showBack: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 58),
        child: Column(
          children: [
            const SuccessPulse(),
            const SizedBox(height: 28),
            Text(
              'Payment successful!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your appointment has been booked successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 26),
            const SoftCard(
              color: AppColors.softBlue,
              child: Column(
                children: [
                  _SummaryRow(label: 'Doctor', value: 'Dr. Emma Wilson'),
                  Divider(height: 1),
                  _SummaryRow(label: 'Date', value: '12 October 2026'),
                  Divider(height: 1),
                  _SummaryRow(label: 'Time', value: '10:30 AM'),
                  Divider(height: 1),
                  _SummaryRow(
                    label: 'Status',
                    value: 'Confirmed',
                    strong: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            PrimaryButton(
              label: 'View appointment',
              onPressed: () => context.go('/appointments/details'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.go('/home'),
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentChoice extends StatelessWidget {
  const _PaymentChoice({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.softBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: AppMotion.quick,
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.strong = false,
  });

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 13),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: strong ? AppColors.ink : AppColors.muted,
                fontWeight: strong ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: strong ? AppColors.primary : AppColors.ink,
              fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
              fontSize: strong ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
