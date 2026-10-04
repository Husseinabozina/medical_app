import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../../core/health_domain.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = context.read<HealthRepository>().pharmacies;

    return HealthScaffold(
      title: 'Pharmacy',
      showBack: true,
      trailing: IconButton(
        onPressed: () => context.push('/pharmacy/filter'),
        icon: const Icon(CupertinoIcons.slider_horizontal_3),
      ),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search pharmacy',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 18),
          ...pharmacies.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 14),
              child: AnimatedAppear(
                delay: Duration(milliseconds: 65 * entry.key),
                child: SoftCard(
                  onTap: () => context.push('/pharmacy/details'),
                  child: Row(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppColors.softBlue,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          CupertinoIcons.add_circled,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.value.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                TinyRating(entry.value.rating),
                                const SizedBox(width: 12),
                                const Icon(
                                  CupertinoIcons.location,
                                  size: 15,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  entry.value.distance,
                                  style: const TextStyle(
                                    color: AppColors.muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Open now · Delivery available',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.chevron_forward,
                        size: 18,
                        color: AppColors.muted,
                      ),
                    ],
                  ),
                ),
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
    return HealthScaffold(
      title: 'Medical record',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SoftCard(
            color: AppColors.softBlue,
            onTap: () => context.push('/medical-record/menu'),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    CupertinoIcons.doc_text,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Health summary',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Your main health information in one place.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Records',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 12),
          _RecordItem(
            icon: CupertinoIcons.heart,
            title: 'Medical history',
            subtitle: '2 records',
            onTap: () => context.push('/medical-record/history'),
          ),
          const SizedBox(height: 12),
          _RecordItem(
            icon: CupertinoIcons.doc_text,
            title: 'Analysis',
            subtitle: '5 reports',
            onTap: () => context.push('/medical-record/analysis'),
          ),
          const SizedBox(height: 12),
          _RecordItem(
            icon: CupertinoIcons.exclamationmark_triangle,
            title: 'Allergies',
            subtitle: 'No severe allergies',
            onTap: () => context.push('/medical-record/allergies'),
          ),
          const SizedBox(height: 12),
          _RecordItem(
            icon: CupertinoIcons.check_mark_circled,
            title: 'Vaccinations',
            subtitle: '8 records',
            onTap: () => context.push('/medical-record/vaccinations'),
          ),
          const SizedBox(height: 26),
          PrimaryButton(
            label: 'Add record',
            icon: CupertinoIcons.add,
            onPressed: () => context.push('/medical-record/add'),
          ),
        ],
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  const _RecordItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
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
          const Icon(
            CupertinoIcons.chevron_forward,
            size: 18,
            color: AppColors.muted,
          ),
        ],
      ),
    );
  }
}
