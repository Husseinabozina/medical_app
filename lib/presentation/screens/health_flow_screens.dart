import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/motion.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/health_widgets.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../cubit/health_cubit.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDay = 2;
  int selectedTime = 2;
  String patient = 'other';
  String gender = 'female';

  @override
  Widget build(BuildContext context) {
    const days = [('9', 'MON'), ('10', 'TUE'), ('11', 'WED'), ('12', 'THU'), ('13', 'FRI'), ('12', 'SAT')];
    const times = ['9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM'];
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 3),
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(24, MediaQuery.paddingOf(context).top + 10, 24, 18),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
            child: Column(
              children: [
                Row(children: [IconButton(onPressed: () => context.pop(), icon: Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_right : CupertinoIcons.chevron_left, color: Colors.white)), const SizedBox(width: 4), Expanded(child: Container(height: 30, padding: const EdgeInsetsDirectional.symmetric(horizontal: 12), alignment: AlignmentDirectional.centerStart, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)), child: const Text('Dr. Emma Hall, M.D.', style: TextStyle(color: AppColors.aqua))), const SizedBox(width: 8), const Icon(CupertinoIcons.phone_circle_fill, color: Colors.white), const SizedBox(width: 7), const Icon(CupertinoIcons.video_camera_solid, color: Colors.white), const SizedBox(width: 7), const Icon(CupertinoIcons.heart, color: Colors.white)]),
                const SizedBox(height: 20),
                Row(children: [Expanded(child: Text('home.upcoming'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))), Text('schedule.month'.tr(), style: const TextStyle(color: Colors.white))]),
                const Divider(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(days.length, (index) => GestureDetector(onTap: () => setState(() => selectedDay = index), child: _DayChip(day: days[index].$1, label: days[index].$2, selected: index == selectedDay))),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 18, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('schedule.available'.tr(), style: const TextStyle(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 7, runSpacing: 8, children: List.generate(times.length, (i) => Pill(label: times[i], selected: selectedTime == i, padding: const EdgeInsetsDirectional.fromSTEB(9, 5, 9, 5), onTap: () => setState(() => selectedTime = i)))),
                  const Divider(height: 34),
                  Text('schedule.patient_details'.tr(), style: const TextStyle(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, children: [Pill(label: 'schedule.yourself'.tr(), selected: patient == 'self', padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4), onTap: () => setState(() => patient = 'self')), Pill(label: 'schedule.other_person'.tr(), selected: patient == 'other', padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4), onTap: () => setState(() => patient = 'other'))]),
                  const SizedBox(height: 16),
                  HealthTextField(label: 'auth.full_name'.tr(), hint: 'Jane Doe'),
                  const SizedBox(height: 12),
                  HealthTextField(label: 'filters.age'.tr(), hint: '30'),
                  const SizedBox(height: 12),
                  Text('filters.gender'.tr(), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Wrap(spacing: 8, children: [Pill(label: 'filters.male'.tr(), selected: gender == 'male', padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4), onTap: () => setState(() => gender = 'male')), Pill(label: 'filters.female'.tr(), selected: gender == 'female', padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4), onTap: () => setState(() => gender = 'female')), Pill(label: 'filters.other'.tr(), selected: gender == 'other', padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4), onTap: () => setState(() => gender = 'other'))]),
                  const Divider(height: 30),
                  HealthTextField(label: 'schedule.problem'.tr(), hint: 'schedule.problem_hint'.tr(), maxLines: 4),
                  const SizedBox(height: 20),
                  GradientButton(label: 'schedule.continue'.tr(), onPressed: () => context.push(AppRoutes.appointmentDetails)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HealthCubit>().state;
    final docs = {for (final d in state.doctors) d.id: d};
    final items = state.appointments.where((a) => a.status == state.appointmentStatus).toList();
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 3),
      child: Column(
        children: [
          AquaHeader(title: 'appointments.title'.tr(), onBack: () => context.go(AppRoutes.home)),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 22, 30, 30),
              children: [
                Row(
                  children: [
                    Expanded(child: Pill(label: 'appointments.complete'.tr(), selected: state.appointmentStatus == AppointmentStatus.complete, onTap: () => context.read<HealthCubit>().selectAppointmentStatus(AppointmentStatus.complete))),
                    const SizedBox(width: 6),
                    Expanded(child: Pill(label: 'appointments.upcoming'.tr(), selected: state.appointmentStatus == AppointmentStatus.upcoming, onTap: () => context.read<HealthCubit>().selectAppointmentStatus(AppointmentStatus.upcoming))),
                    const SizedBox(width: 6),
                    Expanded(child: Pill(label: 'appointments.cancelled'.tr(), selected: state.appointmentStatus == AppointmentStatus.cancelled, onTap: () => context.read<HealthCubit>().selectAppointmentStatus(AppointmentStatus.cancelled))),
                  ],
                ),
                const Divider(height: 30),
                if (items.isEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 90),
                    child: Column(children: [const Icon(CupertinoIcons.calendar_badge_minus, color: AppColors.aqua, size: 70), const SizedBox(height: 14), Text('appointments.empty'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.aqua))]),
                  )
                else
                  ...items.map((appointment) => _AppointmentCard(appointment: appointment, doctor: docs[appointment.doctorId], onDetails: () => context.push(AppRoutes.appointmentDetails))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 3),
      child: Column(
        children: [
          AquaHeader(title: 'appointments.your'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ScreenBody(
              children: [
                SoftCard(
                  color: Colors.white,
                  child: Row(children: [const InitialAvatar(name: 'Dr. Emma Hall', size: 70, emphasized: true), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Dr. Emma Hall, M.D.', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)), Text('specialty.general'.tr()), const SizedBox(height: 6), const Row(children: [InfoChip(icon: CupertinoIcons.star_fill, label: '5'), SizedBox(width: 6), InfoChip(icon: CupertinoIcons.chat_bubble, label: '30')])])), const Icon(CupertinoIcons.heart_fill, color: AppColors.aqua)]),
                ),
                const Divider(height: 26),
                Row(children: [Expanded(child: Pill(label: 'Month 24, Year', selected: true)), const Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.aqua, size: 30), const SizedBox(width: 8), const Icon(CupertinoIcons.xmark_circle, color: AppColors.aqua, size: 30)]),
                const SizedBox(height: 6),
                const Text('WED, 10:00 AM'),
                const Divider(height: 34),
                _KeyValue(label: 'appointments.booking_for'.tr(), value: 'schedule.other_person'.tr()),
                _KeyValue(label: 'auth.full_name'.tr(), value: 'Jane Doe'),
                _KeyValue(label: 'filters.age'.tr(), value: '30'),
                _KeyValue(label: 'filters.gender'.tr(), value: 'filters.female'.tr()),
                const Divider(height: 34),
                Text('schedule.problem'.tr(), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('appointments.problem_body'.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35)),
                const SizedBox(height: 54),
                Row(children: [Expanded(child: GradientButton(label: 'payment.title'.tr(), outlined: true, onPressed: () => context.push(AppRoutes.paymentMethod))), const SizedBox(width: 28), Expanded(child: GradientButton(label: 'common.cancel'.tr(), onPressed: () => context.go(AppRoutes.appointments)))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int rating = 4;

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 3),
      child: Column(
        children: [
          AquaHeader(title: 'review.title'.tr(), onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(32, 24, 32, 30),
              child: Column(
                children: [
                  Text('review.body'.tr(), textAlign: TextAlign.center),
                  const SizedBox(height: 28),
                  const InitialAvatar(name: 'Dr. Emma Hall, M.D.', size: 145, emphasized: true),
                  const SizedBox(height: 18),
                  Text('Dr. Emma Hall, M.D.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                  Text('specialty.general'.tr()),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => rating = i + 1), icon: Icon(i < rating ? CupertinoIcons.star_fill : CupertinoIcons.star, color: AppColors.aqua)))),
                  const SizedBox(height: 10),
                  HealthTextField(label: 'review.comment'.tr(), hint: 'review.comment_hint'.tr(), maxLines: 5),
                  const SizedBox(height: 48),
                  GradientButton(label: 'review.add'.tr(), width: 250, onPressed: () => context.go(AppRoutes.appointments)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = context.watch<HealthCubit>().state.pharmacies;
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'pharmacy.title'.tr(), subtitle: 'pharmacy.find'.tr(), onBack: () => context.pop(), height: 156),
          Transform.translate(offset: const Offset(0, -58), child: const Padding(padding: EdgeInsetsDirectional.symmetric(horizontal: 30), child: SearchField())),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -34),
              child: ListView(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 26),
                children: [
                  Row(children: [Text('doctors.sort_by'.tr()), const SizedBox(width: 8), const Pill(label: 'A→Z', selected: true, padding: EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4)), const SizedBox(width: 12), Pill(label: 'common.info'.tr(), padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4)), const SizedBox(width: 8), Pill(label: 'home.favorite'.tr(), padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4))]),
                  const Divider(height: 24),
                  ...pharmacies.map((p) => Column(children: [_PharmacyRow(name: p.name, address: p.address, hours: p.hours, rating: p.rating, favorite: p.favorite), const Divider()])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'records.title'.tr(), onBack: () => context.pop()),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 42),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.doc_on_clipboard, color: AppColors.aqua, size: 130),
                    const SizedBox(height: 38),
                    Text('records.empty'.tr(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 82),
                    GradientButton(label: 'records.add'.tr(), width: 220, onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selected = 'card';

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: 'payment.method'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
              children: [
                Text('payment.card_title'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.aqua)),
                const SizedBox(height: 16),
                _PaymentChoice(icon: CupertinoIcons.creditcard, label: 'payment.add_card'.tr(), value: 'card', selected: selected, onTap: () => setState(() => selected = 'card')),
                const SizedBox(height: 32),
                Text('payment.more'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.aqua)),
                const SizedBox(height: 16),
                _PaymentChoice(icon: CupertinoIcons.device_phone_portrait, label: 'Apple Pay', value: 'apple', selected: selected, onTap: () => setState(() => selected = 'apple')),
                const SizedBox(height: 10),
                _PaymentChoice(icon: CupertinoIcons.money_dollar_circle, label: 'PayPal', value: 'paypal', selected: selected, onTap: () => setState(() => selected = 'paypal')),
                const SizedBox(height: 10),
                _PaymentChoice(icon: CupertinoIcons.globe, label: 'Google Pay', value: 'google', selected: selected, onTap: () => setState(() => selected = 'google')),
                const SizedBox(height: 52),
                GradientButton(label: 'common.continue'.tr(), onPressed: () => context.push(AppRoutes.paymentSummary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.fromSTEB(24, MediaQuery.paddingOf(context).top + 12, 24, 28),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
            child: Column(children: [Stack(alignment: Alignment.center, children: [Align(alignment: AlignmentDirectional.centerStart, child: IconButton(onPressed: () => context.pop(), icon: Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_right : CupertinoIcons.chevron_left, color: Colors.white))), Text('payment.title'.tr(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600))]), const SizedBox(height: 18), const Text(r'$ 100.00', style: TextStyle(color: Colors.white, fontSize: 46, fontWeight: FontWeight.w700))]),
          ),
          Expanded(
            child: ScreenBody(
              children: [
                const Row(children: [InitialAvatar(name: 'Dr. Emma Hall, M.D.', size: 84, emphasized: true), SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Dr. Emma Hall, M.D.', style: TextStyle(color: AppColors.aqua, fontSize: 18, fontWeight: FontWeight.w600)), Text('General Doctor'), SizedBox(height: 4), Row(children: [InfoChip(icon: CupertinoIcons.star_fill, label: '5'), SizedBox(width: 6), InfoChip(icon: CupertinoIcons.chat_bubble, label: '30')])]))]),
                const Divider(height: 30),
                _KeyValue(label: 'payment.date_hour'.tr(), value: 'Month 24, Year / 10:00 AM', accentLabel: true),
                _KeyValue(label: 'payment.duration'.tr(), value: '30 ${'payment.minutes'.tr()}', accentLabel: true),
                _KeyValue(label: 'appointments.booking_for'.tr(), value: 'John Doe', accentLabel: true),
                const Divider(height: 30),
                _KeyValue(label: 'payment.amount'.tr(), value: r'$100.00', accentLabel: true),
                _KeyValue(label: 'payment.duration'.tr(), value: '30 ${'payment.minutes'.tr()}', accentLabel: true),
                _KeyValue(label: 'payment.total'.tr(), value: r'$100', accentLabel: true),
                const Divider(height: 30),
                Row(children: [Expanded(child: Text('payment.method'.tr(), style: const TextStyle(color: AppColors.aqua))), const Text('Card'), const SizedBox(width: 12), TextButton(onPressed: () => context.pop(), child: Text('common.change'.tr()))]),
                const SizedBox(height: 28),
                GradientButton(label: 'payment.pay_now'.tr(), onPressed: () => context.push(AppRoutes.paymentSuccess)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: AppMotion.emphasized)..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: 'payment.title'.tr(), onBack: () => context.go(AppRoutes.home)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 28),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, child) => Transform.scale(scale: Curves.easeOutBack.transform(controller.value.clamp(0.0, 1.0)), child: child),
                    child: Container(width: 180, height: 180, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.aqua, width: 9)), child: const Icon(CupertinoIcons.check_mark, color: AppColors.aqua, size: 94)),
                  ),
                  const SizedBox(height: 24),
                  Text('payment.congratulation'.tr(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)),
                  Text('payment.success'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 30),
                  SoftCard(
                    child: Column(children: [Text('payment.booked_with'.tr(), textAlign: TextAlign.center), const SizedBox(height: 14), Text('Dr. Emma Hall, M.D.', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 12), const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(CupertinoIcons.calendar, size: 17), SizedBox(width: 6), Text('Month 24, Year'), SizedBox(width: 18), Icon(CupertinoIcons.clock, size: 17), SizedBox(width: 6), Text('10:00 AM')])]),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 28, width: double.infinity, alignment: Alignment.center, decoration: BoxDecoration(color: AppColors.ice, borderRadius: BorderRadius.circular(100)), child: Text('payment.download'.tr())),
                  const SizedBox(height: 62),
                  GradientButton(label: 'payment.return'.tr(), onPressed: () => context.go(AppRoutes.home)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.day, required this.label, required this.selected});
  final String day;
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.quick),
        width: 42,
        height: 64,
        decoration: BoxDecoration(color: selected ? Colors.white : Colors.transparent, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(18)),
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: [Text(day, style: TextStyle(color: selected ? AppColors.aqua : Colors.white, fontSize: 20, fontWeight: FontWeight.w600)), Text(label, style: TextStyle(color: selected ? AppColors.aqua : Colors.white, fontSize: 11))]),
      );
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment, required this.onDetails, this.doctor});
  final Appointment appointment;
  final Doctor? doctor;
  final VoidCallback onDetails;
  @override
  Widget build(BuildContext context) {
    final d = doctor ?? const Doctor(id: 'demo', name: 'Dr. Emma Hall, M.D.', specialty: 'General Doctor', rating: 5, reviews: 30, years: 10);
    return Column(
      children: [
        Row(children: [InitialAvatar(name: d.name, size: 64), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(d.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)), Text(d.specialty)]))]),
        const SizedBox(height: 10),
        Row(children: [Expanded(child: InfoChip(icon: CupertinoIcons.calendar, label: appointment.dateLabel)), const SizedBox(width: 6), Expanded(child: InfoChip(icon: CupertinoIcons.clock, label: appointment.timeLabel))]),
        const SizedBox(height: 8),
        Row(children: [Expanded(child: GradientButton(label: 'appointments.details'.tr(), outlined: true, height: 30, onPressed: onDetails)), const SizedBox(width: 12), const Icon(CupertinoIcons.check_mark_circled, color: AppColors.aqua, size: 30), const SizedBox(width: 6), const Icon(CupertinoIcons.xmark_circle, color: AppColors.aqua, size: 30)]),
        const Divider(height: 26),
      ],
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.label, required this.value, this.accentLabel = false});
  final String label;
  final String value;
  final bool accentLabel;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsetsDirectional.symmetric(vertical: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Text(label, style: TextStyle(color: accentLabel ? AppColors.aqua : AppColors.ink))), Expanded(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w600)))]));
}

class _PharmacyRow extends StatelessWidget {
  const _PharmacyRow({required this.name, required this.address, required this.hours, required this.rating, required this.favorite});
  final String name;
  final String address;
  final String hours;
  final double rating;
  final bool favorite;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 82, height: 82, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.ice), child: const Icon(CupertinoIcons.cross_circle, color: AppColors.aqua, size: 55)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(color: AppColors.aqua, fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text('${'pharmacy.address'.tr()}: $address', style: Theme.of(context).textTheme.bodySmall), Text('${'pharmacy.schedule'.tr()}: $hours', style: Theme.of(context).textTheme.bodySmall), const SizedBox(height: 3), Row(children: [Text('pharmacy.recommended'.tr(), style: const TextStyle(color: AppColors.aqua, fontSize: 11)), const SizedBox(width: 6), StarRating(value: rating.round(), size: 12)])])), Icon(favorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: AppColors.aqua)]),
      );
}

class _PaymentChoice extends StatelessWidget {
  const _PaymentChoice({required this.icon, required this.label, required this.value, required this.selected, required this.onTap});
  final IconData icon;
  final String label;
  final String value;
  final String selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final active = selected == value;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(height: 48, padding: const EdgeInsetsDirectional.symmetric(horizontal: 16), decoration: BoxDecoration(color: AppColors.ice, borderRadius: BorderRadius.circular(16)), child: Row(children: [Icon(icon, color: AppColors.aqua), const SizedBox(width: 12), Expanded(child: Text(label, style: Theme.of(context).textTheme.titleLarge)), Icon(active ? CupertinoIcons.largecircle_fill_circle : CupertinoIcons.circle, color: AppColors.aqua)])),
    );
  }
}
