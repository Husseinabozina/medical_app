import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_colors.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/health_widgets.dart';
import '../../domain/entities/doctor.dart';
import '../cubit/health_cubit.dart';

const _specialties = <({String key, IconData icon})>[
  (key: 'specialty.cardiology', icon: CupertinoIcons.heart_circle),
  (key: 'specialty.dermatology', icon: CupertinoIcons.sparkles),
  (key: 'specialty.general', icon: CupertinoIcons.person_crop_circle_badge_checkmark),
  (key: 'specialty.gynecology', icon: CupertinoIcons.circle_grid_hex),
  (key: 'specialty.odontology', icon: CupertinoIcons.smiley),
  (key: 'specialty.oncology', icon: CupertinoIcons.scope),
  (key: 'specialty.ophthalmology', icon: CupertinoIcons.eye),
  (key: 'specialty.orthopedics', icon: CupertinoIcons.bandage),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
                    child: Row(
                      children: [
                        _RoundAction(icon: CupertinoIcons.bell, onTap: () => context.push(AppRoutes.notifications)),
                        const SizedBox(width: 8),
                        _RoundAction(icon: CupertinoIcons.gear, onTap: () => context.push(AppRoutes.settings)),
                        const SizedBox(width: 8),
                        _RoundAction(icon: CupertinoIcons.search, onTap: () => context.push(AppRoutes.doctors)),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('home.welcome'.tr(), style: const TextStyle(color: AppColors.aqua)),
                            Text('home.user_name'.tr(), style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const InitialAvatar(name: 'Jane Doe', size: 38, emphasized: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SectionTitle('home.categories'.tr(), action: 'common.see_all'.tr(), onAction: () => context.push(AppRoutes.specialties)),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CategoryShortcut(icon: CupertinoIcons.heart, label: 'home.favorite'.tr(), onTap: () => context.push(AppRoutes.favorites)),
                            _CategoryShortcut(icon: CupertinoIcons.person_2, label: 'home.doctors'.tr(), onTap: () => context.push(AppRoutes.doctors)),
                            _CategoryShortcut(icon: CupertinoIcons.add_circled, label: 'home.pharmacy'.tr(), onTap: () => context.push(AppRoutes.pharmacy)),
                            _CategoryShortcut(icon: CupertinoIcons.square_grid_2x2, label: 'home.specialties'.tr(), onTap: () => context.push(AppRoutes.specialties)),
                            _CategoryShortcut(icon: CupertinoIcons.doc_text, label: 'home.record'.tr(), onTap: () => context.push(AppRoutes.medicalRecord)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _UpcomingPanel(onSeeAll: () => context.push(AppRoutes.appointments)),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 12, 30, 28),
                    child: Column(
                      children: [
                        SectionTitle('home.specialties'.tr(), action: 'common.see_all'.tr(), onAction: () => context.push(AppRoutes.specialties)),
                        const SizedBox(height: 8),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 12, childAspectRatio: .86),
                          itemBuilder: (context, index) => SpecialtyTile(
                            label: _specialties[index].key.tr(),
                            icon: _specialties[index].icon,
                            onTap: () => context.push(index == 0 ? AppRoutes.cardiology : AppRoutes.doctors),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'home.specialties'.tr(), subtitle: 'doctors.find'.tr(), onBack: () => context.pop(), height: 156),
          Transform.translate(
            offset: const Offset(0, -58),
            child: Padding(padding: const EdgeInsetsDirectional.symmetric(horizontal: 30), child: const SearchField()),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -34),
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _SortBar(),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _specialties.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 12, childAspectRatio: 1.05),
                      itemBuilder: (context, index) => SpecialtyTile(
                        label: _specialties[index].key.tr(),
                        icon: _specialties[index].icon,
                        onTap: () => context.push(index == 0 ? AppRoutes.cardiology : AppRoutes.doctors),
                      ),
                    ),
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

class CardiologyDoctorsScreen extends StatelessWidget {
  const CardiologyDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) => _DoctorListScreen(title: 'specialty.cardiology'.tr(), cardiologyOnly: true);
}

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) => _DoctorListScreen(title: 'home.doctors'.tr());
}

class _DoctorListScreen extends StatelessWidget {
  const _DoctorListScreen({required this.title, this.cardiologyOnly = false});

  final String title;
  final bool cardiologyOnly;

  @override
  Widget build(BuildContext context) {
    final doctors = context.watch<HealthCubit>().state.doctors;
    final visible = cardiologyOnly
        ? doctors.where((d) => d.specialty.toLowerCase().contains('cardio')).toList()
        : doctors;
    final fallback = doctors.isNotEmpty ? doctors : const <Doctor>[];
    final items = visible.isNotEmpty ? visible : fallback;

    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: title, subtitle: 'doctors.find'.tr(), onBack: () => context.pop(), height: 156),
          Transform.translate(offset: const Offset(0, -58), child: const Padding(padding: EdgeInsetsDirectional.symmetric(horizontal: 30), child: SearchField())),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -34),
              child: ListView(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 24),
                children: [
                  if (!cardiologyOnly) ...[
                    SizedBox(
                      height: 56,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, i) => Container(
                          width: 52,
                          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep]), borderRadius: BorderRadius.circular(15)),
                          child: Icon(_specialties[(i + 3) % _specialties.length].icon, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const _SortBar(),
                  const SizedBox(height: 6),
                  ...List.generate(items.length, (index) {
                    final doctor = items[index];
                    return Column(
                      children: [
                        DoctorRow(
                          name: doctor.name,
                          specialty: doctor.specialty,
                          favorite: doctor.favorite,
                          onTap: () => context.push(index.isEven ? AppRoutes.doctorInfo : AppRoutes.doctorProfile),
                          onFavorite: () => context.read<HealthCubit>().toggleFavorite(doctor.id),
                        ),
                        const Divider(),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          _DoctorHero(
            name: 'Dr. Jacob Lopez, M.D.',
            specialty: 'Surgical Dermatology',
            onBack: () => context.pop(),
            onSchedule: () => context.push(AppRoutes.schedule),
          ),
          Expanded(
            child: ScreenBody(
              children: [
                SoftCard(
                  child: Text.rich(
                    TextSpan(children: [TextSpan(text: '${'doctors.focus'.tr()}: ', style: const TextStyle(fontWeight: FontWeight.w700)), TextSpan(text: 'doctors.focus_body'.tr())]),
                  ),
                ),
                const SizedBox(height: 24),
                _TextSection(title: 'doctors.profile'.tr(), body: 'doctors.profile_body'.tr()),
                const SizedBox(height: 16),
                _TextSection(title: 'doctors.career'.tr(), body: 'doctors.career_body'.tr()),
                const SizedBox(height: 16),
                _TextSection(title: 'doctors.highlights'.tr(), body: 'doctors.highlights_body'.tr()),
              ],
            ),
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
    final doctors = context.watch<HealthCubit>().state.doctors;
    final favorites = doctors.where((d) => d.favorite).toList();
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'home.favorite'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 14, 30, 24),
              children: [
                const _SortBar(),
                const SizedBox(height: 16),
                Row(children: [Expanded(child: Pill(label: 'home.doctors'.tr(), selected: true)), const SizedBox(width: 8), Expanded(child: Pill(label: 'favorite.services'.tr()))]),
                const SizedBox(height: 12),
                const Divider(),
                ...favorites.map(
                  (doctor) => Column(
                    children: [
                      DoctorRow(
                        name: doctor.name,
                        specialty: doctor.specialty,
                        favorite: true,
                        cta: SizedBox(height: 24, child: GradientButton(label: 'favorite.make_appointment'.tr(), onPressed: () => context.push(AppRoutes.schedule))),
                        onFavorite: () => context.read<HealthCubit>().toggleFavorite(doctor.id),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool available = true;
  String gender = 'female';
  String experience = '1-5';
  double age = 45;

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'filters.title'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
              children: [
                Align(alignment: AlignmentDirectional.centerEnd, child: TextButton(onPressed: () => setState(() { available = true; gender = 'female'; experience = '1-5'; age = 45; }), child: Text('common.reset'.tr()))),
                _SettingLine(label: 'filters.available_today'.tr(), trailing: Switch(value: available, activeTrackColor: AppColors.aqua, onChanged: (v) => setState(() => available = v))),
                _FilterSection(title: 'filters.gender'.tr(), child: Wrap(spacing: 10, children: [Pill(label: 'filters.male'.tr(), selected: gender == 'male', onTap: () => setState(() => gender = 'male')), Pill(label: 'filters.female'.tr(), selected: gender == 'female', onTap: () => setState(() => gender = 'female'))])),
                _FilterSection(title: 'filters.top_rated'.tr(), child: const StarRating(value: 3)),
                _FilterSection(
                  title: 'filters.experience'.tr(),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Pill(label: '1 - 5', selected: experience == '1-5', onTap: () => setState(() => experience = '1-5')),
                    Pill(label: '6 - 9', selected: experience == '6-9', onTap: () => setState(() => experience = '6-9')),
                    Pill(label: '10 >', selected: experience == '10+', onTap: () => setState(() => experience = '10+')),
                  ]),
                ),
                _FilterSection(
                  title: 'filters.specialty'.tr(),
                  child: SizedBox(
                    height: 58,
                    child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: 6, separatorBuilder: (_, __) => const SizedBox(width: 10), itemBuilder: (_, i) => Container(width: 52, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep]), borderRadius: BorderRadius.circular(14)), child: Icon(_specialties[i].icon, color: Colors.white))),
                  ),
                ),
                _FilterSection(
                  title: 'filters.age'.tr(),
                  child: Column(children: [Slider(value: age, min: 20, max: 80, activeColor: AppColors.aqua, onChanged: (v) => setState(() => age = v)), const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('20'), Text('40'), Text('60'), Text('80')])]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          _DoctorHero(name: 'Dr. Emma Hall, M.D.', specialty: 'General Doctor', onBack: () => context.pop(), onSchedule: () => context.push(AppRoutes.schedule)),
          Expanded(
            child: ScreenBody(
              children: [
                _TextSection(title: 'doctors.profile'.tr(), body: 'doctors.profile_body'.tr()),
                const SizedBox(height: 16),
                const Divider(),
                Row(children: [Expanded(child: Text('schedule.choose_date'.tr(), style: const TextStyle(color: AppColors.aqua, fontWeight: FontWeight.w600))), Text('schedule.month'.tr()), const SizedBox(width: 6), const Icon(CupertinoIcons.chevron_down, color: AppColors.aqua, size: 16)]),
                const SizedBox(height: 14),
                const _MiniCalendar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingPanel extends StatelessWidget {
  const _UpcomingPanel({required this.onSeeAll});
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    const days = [('9', 'MON'), ('10', 'TUE'), ('11', 'WED'), ('12', 'THU'), ('13', 'FRI'), ('12', 'SAT')];
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(30, 12, 30, 24),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text('home.upcoming'.tr(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600))), Text('schedule.month'.tr(), style: const TextStyle(color: Colors.white))]),
          const Divider(color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.asMap().entries.map((entry) {
              final selected = entry.key == 2;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 42,
                height: 64,
                decoration: BoxDecoration(color: selected ? Colors.white : Colors.transparent, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(18)),
                alignment: Alignment.center,
                child: Column(mainAxisSize: MainAxisSize.min, children: [Text(entry.value.$1, style: TextStyle(color: selected ? AppColors.aqua : Colors.white, fontSize: 20, fontWeight: FontWeight.w600)), Text(entry.value.$2, style: TextStyle(color: selected ? AppColors.aqua : Colors.white, fontSize: 11))]),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Align(alignment: AlignmentDirectional.centerEnd, child: TextButton(onPressed: onSeeAll, child: Text('common.see_all'.tr(), style: const TextStyle(color: Colors.white)))),
                _ScheduleLine(time: '10:00 AM', doctor: 'Dr. Olivia Turner'),
                const Divider(color: Colors.white),
                _ScheduleLine(time: '08:00 AM', doctor: 'Dr. Alexander Bennett'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleLine extends StatelessWidget {
  const _ScheduleLine({required this.time, required this.doctor});
  final String time;
  final String doctor;
  @override
  Widget build(BuildContext context) => Row(children: [const Icon(CupertinoIcons.circle_fill, color: Colors.white, size: 7), const SizedBox(width: 8), Text(time, style: const TextStyle(color: Colors.white)), const SizedBox(width: 14), Expanded(child: Text(doctor, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)))]);
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(100), child: Container(width: 30, height: 30, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.ice), child: Icon(icon, size: 17, color: AppColors.ink)));
}

class _CategoryShortcut extends StatelessWidget {
  const _CategoryShortcut({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, child: SizedBox(width: 53, child: Column(children: [Icon(icon, color: AppColors.aqua, size: 26), const SizedBox(height: 5), Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.aqua, fontSize: 11))])));
}

class _SortBar extends StatelessWidget {
  const _SortBar();
  @override
  Widget build(BuildContext context) => Row(children: [Text('doctors.sort_by'.tr()), const SizedBox(width: 6), const Pill(label: 'A→Z', selected: true, padding: EdgeInsetsDirectional.fromSTEB(9, 4, 9, 4)), const SizedBox(width: 8), Pill(label: 'filters.title'.tr(), padding: const EdgeInsetsDirectional.fromSTEB(9, 4, 9, 4)), const Spacer(), TextButton(onPressed: () {}, child: Text('common.see_all'.tr()))]);
}

class _DoctorHero extends StatelessWidget {
  const _DoctorHero({required this.name, required this.specialty, required this.onBack, required this.onSchedule});
  final String name;
  final String specialty;
  final VoidCallback onBack;
  final VoidCallback onSchedule;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      height: 244 + top,
      padding: EdgeInsetsDirectional.fromSTEB(24, top + 12, 24, 0),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
      child: Column(
        children: [
          Row(children: [IconButton(onPressed: onBack, icon: Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_right : CupertinoIcons.chevron_left, color: Colors.white)), const Spacer(), Pill(label: 'schedule.title'.tr(), selected: false, onTap: onSchedule), const SizedBox(width: 8), const Icon(CupertinoIcons.phone_circle, color: Colors.white), const SizedBox(width: 8), const Icon(CupertinoIcons.video_camera_solid, color: Colors.white), const SizedBox(width: 8), const Icon(CupertinoIcons.heart, color: Colors.white)]),
          const SizedBox(height: 18),
          Row(children: [InitialAvatar(name: name, size: 96, emphasized: true), const SizedBox(width: 18), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)), Text(specialty, style: const TextStyle(color: Colors.white)), const SizedBox(height: 6), const Row(children: [InfoChip(icon: CupertinoIcons.star_fill, label: '5'), SizedBox(width: 6), InfoChip(icon: CupertinoIcons.chat_bubble, label: '30')])]))]),
          const Spacer(),
          Transform.translate(
            offset: const Offset(0, 16),
            child: Container(
              height: 34,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColors.aqua)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(CupertinoIcons.alarm, color: AppColors.aqua, size: 16), const SizedBox(width: 8), Text('schedule.hours'.tr())]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection({required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)), const Divider(), Text(body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35))]);
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Divider(height: 34), Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua, fontWeight: FontWeight.w600)), const SizedBox(height: 12), child]);
}

class _SettingLine extends StatelessWidget {
  const _SettingLine({required this.label, required this.trailing});
  final String label;
  final Widget trailing;
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.aqua))), trailing]);
}

class _MiniCalendar extends StatelessWidget {
  const _MiniCalendar();
  @override
  Widget build(BuildContext context) {
    final days = List.generate(31, (i) => i + 1);
    return SoftCard(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: days.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8, crossAxisSpacing: 6),
        itemBuilder: (_, i) {
          final selected = days[i] == 24;
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: selected ? AppColors.aqua : Colors.transparent),
            child: Text('${days[i]}', style: TextStyle(color: selected ? Colors.white : AppColors.ink, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
          );
        },
      ),
    );
  }
}
