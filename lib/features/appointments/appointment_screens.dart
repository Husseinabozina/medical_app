import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../../core/health_domain.dart';
import '../../core/health_state.dart';
import '../home/home_screens.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctors = context.read<HealthRepository>().doctors;
    final doctor = doctors.firstWhere(
      (item) => item.id == doctorId,
      orElse: () => doctors.first,
    );

    return HealthScaffold(
      title: 'Doctor profile',
      showBack: true,
      trailing: BlocBuilder<FavoritesCubit, Set<String>>(
        builder: (context, favorites) {
          final selected = favorites.contains(doctor.id);
          return IconButton(
            onPressed: () => context.read<FavoritesCubit>().toggle(doctor.id),
            icon: Icon(
              selected ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: selected ? AppColors.primary : AppColors.ink,
            ),
          );
        },
      ),
      child: Column(
        children: [
          const SizedBox(height: 6),
          DoctorAvatar(initials: doctor.initials, size: 126),
          const SizedBox(height: 18),
          Text(
            doctor.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            doctor.specialty,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 10),
          TinyRating(doctor.rating),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _ProfileMetric(
                  icon: CupertinoIcons.person_2,
                  value: doctor.experience,
                  label: 'Experience',
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: _ProfileMetric(
                  icon: CupertinoIcons.chat_bubble_2,
                  value: '2.4k',
                  label: 'Patients',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ProfileMetric(
                  icon: CupertinoIcons.star,
                  value: doctor.rating.toStringAsFixed(1),
                  label: 'Rating',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About doctor',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '${doctor.name} focuses on clear communication, preventive care and comfortable follow-up for every patient.',
                  style: const TextStyle(
                    color: AppColors.muted,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.location,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        doctor.location,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: 'Book appointment',
            onPressed: () => context.push('/doctor/${doctor.id}/schedule'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side: const BorderSide(color: AppColors.primary),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            ),
            onPressed: () => context.push('/message'),
            icon: const Icon(CupertinoIcons.chat_bubble_2),
            label: const Text('Message doctor'),
          ),
        ],
      ),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctors = context.read<HealthRepository>().doctors;
    final doctor = doctors.firstWhere(
      (item) => item.id == doctorId,
      orElse: () => doctors.first,
    );
    const dates = ['10', '11', '12', '13', '14', '15', '16'];
    const times = [
      '09:00 AM',
      '10:30 AM',
      '12:00 PM',
      '02:30 PM',
      '04:00 PM',
      '05:30 PM',
    ];

    return HealthScaffold(
      title: 'Schedule',
      showBack: true,
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SoftCard(
                color: AppColors.softBlue,
                child: Row(
                  children: [
                    DoctorAvatar(initials: doctor.initials, size: 62),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
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
              const SizedBox(height: 24),
              Text(
                'October 2026',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 78,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final date = dates[index];
                    final selected = state.date == date;
                    return GestureDetector(
                      onTap: () =>
                          context.read<BookingCubit>().selectDate(date),
                      child: AnimatedContainer(
                        duration: AppMotion.quick,
                        width: 54,
                        decoration: BoxDecoration(
                          color:
                              selected ? AppColors.primary : AppColors.softBlue,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri']
                                  [index],
                              style: TextStyle(
                                color:
                                    selected ? Colors.white : AppColors.muted,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              date,
                              style: TextStyle(
                                color:
                                    selected ? Colors.white : AppColors.ink,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Available times',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: times.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 48,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final time = times[index];
                  final selected = state.time == time;
                  return GestureDetector(
                    onTap: () =>
                        context.read<BookingCubit>().selectTime(time),
                    child: AnimatedContainer(
                      duration: AppMotion.quick,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primary : AppColors.softBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.push('/payment/method'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppointmentUpcomingScreen extends StatelessWidget {
  const AppointmentUpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointment = context.read<HealthRepository>().appointments.first;

    return Scaffold(
      bottomNavigationBar: const HealthBottomNav(selectedIndex: 2),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.fromSTEB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointments',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _AppointmentTab(
                          label: 'Upcoming',
                          selected: true,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _AppointmentTab(
                          label: 'Completed',
                          selected: false,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AnimatedAppear(
                    child: SoftCard(
                      color: AppColors.softBlue,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              DoctorAvatar(
                                initials: appointment.doctor.initials,
                                size: 70,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment.doctor.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      appointment.doctor.specialty,
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TinyRating(appointment.doctor.rating),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 8),
                                Expanded(child: Text('Monday, 12 Oct')),
                                Icon(
                                  CupertinoIcons.clock,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 6),
                                Text('10:30 AM'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: FilledButton(
                                  onPressed: () =>
                                      context.push('/appointments/details'),
                                  child: const Text('Details'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointment = context.read<HealthRepository>().appointments.first;

    return HealthScaffold(
      title: 'Appointment details',
      showBack: true,
      child: Column(
        children: [
          DoctorAvatar(initials: appointment.doctor.initials, size: 96),
          const SizedBox(height: 14),
          Text(
            appointment.doctor.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            appointment.doctor.specialty,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          const SoftCard(
            child: Column(
              children: [
                _DetailRow(
                  icon: CupertinoIcons.calendar,
                  title: 'Date',
                  value: 'Monday, 12 October 2026',
                ),
                Divider(height: 1),
                _DetailRow(
                  icon: CupertinoIcons.clock,
                  title: 'Time',
                  value: '10:30 AM',
                ),
                Divider(height: 1),
                _DetailRow(
                  icon: CupertinoIcons.location,
                  title: 'Location',
                  value: 'Central Medical Center',
                ),
                Divider(height: 1),
                _DetailRow(
                  icon: CupertinoIcons.creditcard,
                  title: 'Payment',
                  value: 'Card · Paid',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Message doctor',
            onPressed: () => context.push('/message'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            ),
            onPressed: () => context.push('/review'),
            child: const Text('Review appointment'),
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
  int rating = 5;

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Review',
      showBack: true,
      child: Column(
        children: [
          const SizedBox(height: 18),
          const DoctorAvatar(initials: 'EW', size: 98),
          const SizedBox(height: 14),
          Text(
            'How was your visit?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your feedback helps improve the experience.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => IconButton(
                onPressed: () => setState(() => rating = index + 1),
                icon: AnimatedScale(
                  duration: AppMotion.quick,
                  scale: index < rating ? 1.08 : .94,
                  child: Icon(
                    index < rating
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    color: const Color(0xFFFFC857),
                    size: 34,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const TextField(
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Write a short review...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Submit review',
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.all(12),
      color: AppColors.softBlue,
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _AppointmentTab extends StatelessWidget {
  const _AppointmentTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        alignment: Alignment.center,
        height: 46,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.softBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.muted,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 13),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
