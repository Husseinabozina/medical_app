import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../../core/health_domain.dart';
import '../../core/health_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<HealthRepository>();
    final doctors = repository.doctors;

    return Scaffold(
      bottomNavigationBar: const HealthBottomNav(selectedIndex: 0),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientHeader(
                    height: 210,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(22, 24, 22, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const DoctorAvatar(initials: 'HA', size: 52),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Good morning',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.white.withValues(
                                              alpha: .85,
                                            ),
                                          ),
                                    ),
                                    Text(
                                      'Hussein',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              _HeaderIcon(
                                icon: CupertinoIcons.bell,
                                onTap: () => context.push('/notifications'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'How are you feeling today?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => context.push('/doctors'),
                            child: Container(
                              height: 52,
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.search,
                                    color: AppColors.muted,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Search doctors, specialties...',
                                      style: TextStyle(color: AppColors.muted),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionHeader(
                          title: 'Quick access',
                          action: 'View all',
                        ),
                        const SizedBox(height: 14),
                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 10,
                          childAspectRatio: .78,
                          children: [
                            _QuickAction(
                              icon: CupertinoIcons.person_2,
                              label: 'Doctors',
                              onTap: () => context.push('/doctors'),
                            ),
                            _QuickAction(
                              icon: CupertinoIcons.square_grid_2x2,
                              label: 'Specialties',
                              onTap: () => context.push('/specialties'),
                            ),
                            _QuickAction(
                              icon: CupertinoIcons.bandage,
                              label: 'Pharmacy',
                              onTap: () => context.push('/pharmacy'),
                            ),
                            _QuickAction(
                              icon: CupertinoIcons.doc_text,
                              label: 'Record',
                              onTap: () => context.push('/medical-record'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Upcoming appointment',
                          action: 'Details',
                        ),
                        const SizedBox(height: 14),
                        SoftCard(
                          color: AppColors.softBlue,
                          onTap: () => context.push('/appointments/upcoming'),
                          child: Row(
                            children: [
                              DoctorAvatar(
                                initials: doctors.first.initials,
                                size: 66,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctors.first.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctors.first.specialty,
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.calendar,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Mon, 12 Oct · 10:30 AM',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Recommended doctors',
                          action: 'See all',
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 188,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: doctors.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              return SizedBox(
                                width: 220,
                                child: SoftCard(
                                  onTap: () =>
                                      context.push('/doctor/${doctor.id}'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          DoctorAvatar(
                                            initials: doctor.initials,
                                            size: 54,
                                          ),
                                          const Spacer(),
                                          TinyRating(doctor.rating),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        doctor.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        doctor.specialty,
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final specialties = context.read<HealthRepository>().specialties;

    return HealthScaffold(
      title: 'Specialties',
      showBack: true,
      trailing: IconButton(
        onPressed: () => context.push('/filter'),
        icon: const Icon(CupertinoIcons.slider_horizontal_3),
      ),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search specialty',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specialties.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final item = specialties[index];
              return AnimatedAppear(
                delay: Duration(milliseconds: 45 * index),
                child: SoftCard(
                  onTap: () => context.push(
                    index == 0 ? '/specialties/cardiology' : '/doctors',
                  ),
                  color: index == 0 ? AppColors.softBlue : AppColors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.symbol,
                        style: const TextStyle(
                          fontSize: 38,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardiologyDoctorsScreen extends StatelessWidget {
  const CardiologyDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DoctorsScreen(
      title: 'Cardiology',
      specialtyFilter: 'Cardiologist',
    );
  }
}

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({
    super.key,
    this.title = 'Doctors',
    this.specialtyFilter,
  });

  final String title;
  final String? specialtyFilter;

  @override
  Widget build(BuildContext context) {
    final all = context.read<HealthRepository>().doctors;
    final doctors = specialtyFilter == null
        ? all
        : all.where((d) => d.specialty == specialtyFilter).toList();

    return HealthScaffold(
      title: title,
      showBack: true,
      trailing: IconButton(
        onPressed: () => context.push('/filter'),
        icon: const Icon(CupertinoIcons.slider_horizontal_3),
      ),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search doctors',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 18),
          if (doctors.isEmpty)
            const SoftCard(
              child: Text('No doctors found in this specialty yet.'),
            )
          else
            ...doctors.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 14),
                child: AnimatedAppear(
                  delay: Duration(milliseconds: 60 * entry.key),
                  child: DoctorListTile(doctor: entry.value),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctors = context.read<HealthRepository>().doctors;
    final doctor = doctors.firstWhere(
      (item) => item.id == doctorId,
      orElse: () => doctors.first,
    );

    return HealthScaffold(
      title: 'Doctor info',
      showBack: true,
      child: Column(
        children: [
          const SizedBox(height: 8),
          DoctorAvatar(initials: doctor.initials, size: 112),
          const SizedBox(height: 18),
          Text(
            doctor.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            doctor.specialty,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          TinyRating(doctor.rating),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  value: doctor.experience,
                  label: 'Experience',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  value: '\$${doctor.fee.toStringAsFixed(0)}',
                  label: 'Consultation',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '${doctor.name} provides patient-centered care with a calm, clear approach and evidence-based follow-up.',
                  style: const TextStyle(
                    color: AppColors.muted,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: 'View full profile',
            onPressed: () =>
                context.push('/doctor/${doctor.id}/profile'),
          ),
        ],
      ),
    );
  }
}

class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = context.read<HealthRepository>().doctors;

    return BlocBuilder<FavoritesCubit, Set<String>>(
      builder: (context, favorites) {
        final items =
            doctors.where((doctor) => favorites.contains(doctor.id)).toList();

        return HealthScaffold(
          title: 'Favorites',
          showBack: true,
          child: items.isEmpty
              ? const _EmptyFavorites()
              : Column(
                  children: items
                      .map(
                        (doctor) => Padding(
                          padding:
                              const EdgeInsetsDirectional.only(bottom: 14),
                          child: DoctorListTile(doctor: doctor),
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }
}

class DoctorListTile extends StatelessWidget {
  const DoctorListTile({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: () => context.push('/doctor/${doctor.id}'),
      child: Row(
        children: [
          DoctorAvatar(initials: doctor.initials, size: 64),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    TinyRating(doctor.rating),
                    const SizedBox(width: 12),
                    const Icon(
                      CupertinoIcons.location,
                      size: 15,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        doctor.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<FavoritesCubit, Set<String>>(
            builder: (context, favorites) {
              final selected = favorites.contains(doctor.id);
              return TweenAnimationBuilder<double>(
                duration: AppMotion.quick,
                tween: Tween(begin: 1, end: selected ? 1.08 : 1),
                builder: (context, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: IconButton(
                  onPressed: () =>
                      context.read<FavoritesCubit>().toggle(doctor.id),
                  icon: Icon(
                    selected
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color:
                        selected ? AppColors.primary : AppColors.muted,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HealthBottomNav extends StatelessWidget {
  const HealthBottomNav({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final entries = [
      (CupertinoIcons.house, '/home'),
      (CupertinoIcons.heart, '/favorites'),
      (CupertinoIcons.calendar, '/appointments/upcoming'),
      (CupertinoIcons.person, '/profile'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        height: 72,
        margin: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: .08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(entries.length, (index) {
            final selected = selectedIndex == index;
            return Expanded(
              child: IconButton(
                onPressed: () => context.go(entries[index].$2),
                icon: AnimatedContainer(
                  duration: AppMotion.quick,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.softBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    entries[index].$1,
                    color:
                        selected ? AppColors.primary : AppColors.muted,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: .18),
        foregroundColor: Colors.white,
      ),
      icon: Icon(icon),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      color: AppColors.softBlue,
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 80),
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.heart,
            size: 64,
            color: AppColors.primary,
          ),
          const SizedBox(height: 18),
          Text(
            'No favorites yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the heart on a doctor card to keep them here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
