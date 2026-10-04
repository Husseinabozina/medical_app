import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../../core/health_state.dart';

class _SourceFrameScaffold extends StatelessWidget {
  const _SourceFrameScaffold({
    required this.title,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                Container(
                  height: 72,
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.aqua, AppColors.cyan],
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          CupertinoIcons.back,
                          color: AppColors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                      SizedBox(
                        width: 44,
                        child: actions.isEmpty ? null : actions.first,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 32),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final holder = TextEditingController(text: 'John Doe');
  final number = TextEditingController(text: '000 000 000 00');
  final expiry = TextEditingController(text: '04/28');
  final cvv = TextEditingController(text: '0000');

  @override
  void dispose() {
    holder.dispose();
    number.dispose();
    expiry.dispose();
    cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Add Card',
      child: Column(
        children: [
          Container(
            height: 179,
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.aqua, AppColors.cyan],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withValues(alpha: .18),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.creditcard,
                  color: AppColors.white,
                  size: 30,
                ),
                Spacer(),
                Text(
                  '000 000 000 00',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'John Doe',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Text(
                      '04/28',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: holder,
            decoration: const InputDecoration(labelText: 'Card holder name'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: number,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Card number'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: expiry,
                  decoration: const InputDecoration(labelText: 'Expiry date'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: cvv,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'CVV'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Save Card',
            onPressed: () {
              context.read<BookingCubit>().selectPayment('Card');
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}

class MedicalRecordAddScreen extends StatefulWidget {
  const MedicalRecordAddScreen({super.key});

  @override
  State<MedicalRecordAddScreen> createState() => _MedicalRecordAddScreenState();
}

class _MedicalRecordAddScreenState extends State<MedicalRecordAddScreen> {
  String gender = 'Female';
  String bloodType = 'AB +';
  double age = 26;
  double weight = 75;
  double height = 178;

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Add Record',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('What is your gender'),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Female', label: Text('Female')),
              ButtonSegment(value: 'Male', label: Text('Male')),
              ButtonSegment(value: 'Other', label: Text('Other')),
            ],
            selected: <String>{gender},
            onSelectionChanged: (value) {
              setState(() => gender = value.first);
            },
          ),
          const SizedBox(height: 24),
          _MetricSlider(
            label: 'How old are you',
            value: age,
            suffix: ' years',
            min: 1,
            max: 100,
            onChanged: (value) => setState(() => age = value),
          ),
          _MetricSlider(
            label: 'What is your weight',
            value: weight,
            suffix: ' kg',
            min: 30,
            max: 200,
            onChanged: (value) => setState(() => weight = value),
          ),
          _MetricSlider(
            label: 'What is your height',
            value: height,
            suffix: ' cm',
            min: 100,
            max: 220,
            onChanged: (value) => setState(() => height = value),
          ),
          const SizedBox(height: 10),
          const _SectionLabel('What is your blood type'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: bloodType,
            items: const [
              DropdownMenuItem(value: 'A +', child: Text('A +')),
              DropdownMenuItem(value: 'A -', child: Text('A -')),
              DropdownMenuItem(value: 'B +', child: Text('B +')),
              DropdownMenuItem(value: 'B -', child: Text('B -')),
              DropdownMenuItem(value: 'AB +', child: Text('AB +')),
              DropdownMenuItem(value: 'O +', child: Text('O +')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => bloodType = value);
            },
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Save',
            onPressed: () => context.go('/medical-record/menu'),
          ),
        ],
      ),
    );
  }
}

class _MetricSlider extends StatelessWidget {
  const _MetricSlider({
    required this.label,
    required this.value,
    required this.suffix,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final String suffix;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                width: 82,
                child: Text(
                  value.toStringAsFixed(0) + suffix,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MedicalRecordMenuScreen extends StatelessWidget {
  const MedicalRecordMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const cards = [
      ('Allergies', CupertinoIcons.exclamationmark_triangle, '/medical-record/allergies'),
      ('Analysis', CupertinoIcons.doc_text_search, '/medical-record/analysis'),
      ('Vaccinations', CupertinoIcons.check_mark_circled, '/medical-record/vaccinations'),
      ('Medical History', CupertinoIcons.heart, '/medical-record/history'),
    ];

    return _SourceFrameScaffold(
      title: 'Medical Record',
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Find your medical information',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 18),
          const SoftCard(
            color: AppColors.softBlue,
            child: Wrap(
              spacing: 14,
              runSpacing: 10,
              children: [
                _SummaryChip(label: 'Gender', value: 'Female'),
                _SummaryChip(label: 'Blood Type', value: 'AB +'),
                _SummaryChip(label: 'Age', value: '26 Years'),
                _SummaryChip(label: 'Weight', value: '65 kg'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final card = cards[index];
              return AnimatedAppear(
                delay: Duration(milliseconds: 55 * index),
                child: SoftCard(
                  color: index.isEven ? AppColors.softBlue : AppColors.white,
                  onTap: () => context.push(card.$3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(card.$2, color: AppColors.primary, size: 42),
                      const SizedBox(height: 14),
                      Text(
                        card.$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w900),
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

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'Insulin',
        'Skin Symptoms: redness, itching and swelling at injection site.',
        'Added Manually 10 February 20XX'
      ),
      (
        'Codeine',
        'Respiratory Symptoms: Wheezing, difficulty breathing.',
        'Added Manually 06 June 20XX'
      ),
      (
        'Pollen',
        'Respiratory Symptoms: Sneezing, runny nose, nasal congestion.',
        'Added Manually 20 October 20XX'
      ),
      (
        'Latex',
        'Skin Symptoms: Itching, redness, rash.',
        'Added Manually 20 October 20XX'
      ),
    ];

    return _SourceFrameScaffold(
      title: 'Allergies',
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 14),
              child: AnimatedAppear(
                delay: Duration(milliseconds: 55 * i),
                child: SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[i].$1,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(items[i].$2),
                      const SizedBox(height: 10),
                      Text(
                        items[i].$3,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          PrimaryButton(
            label: 'Add More',
            icon: CupertinoIcons.add,
            onPressed: () => context.push('/medical-record/add'),
          ),
        ],
      ),
    );
  }
}

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool newest = true;

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'Blood Test',
        'Glucose: Elevated levels may indicate diabetes.',
        'Added Manually 10 February 20XX'
      ),
      (
        'Urine Tests',
        'Color and odor abnormalities may indicate urinary or kidney issues.',
        'Added Manually 06 June 20XX'
      ),
      (
        'Lipid Profile',
        'Triglycerides: Elevated levels may indicate increased cardiovascular risk.',
        'Added Manually 20 October 20XX'
      ),
      (
        'Thyroid Tests',
        'T3 and T4: Abnormal levels may indicate thyroid dysfunction.',
        'Added Manually 20 October 20XX'
      ),
    ];

    return _SourceFrameScaffold(
      title: 'Analysis',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Search By'),
          const SizedBox(height: 10),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Newest')),
              ButtonSegment(value: false, label: Text('Oldest')),
            ],
            selected: <bool>{newest},
            onSelectionChanged: (value) {
              setState(() => newest = value.first);
            },
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                onTap: i == 0
                    ? () => context.push('/medical-record/analysis/detail')
                    : null,
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        CupertinoIcons.doc_text,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[i].$1,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            items[i].$2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.muted),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            items[i].$3,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
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

class AnalysisDetailScreen extends StatelessWidget {
  const AnalysisDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const metrics = [
      ('Fasting Levels', '12 mg/dL'),
      ('Hemoglobin A1c (HbA1c)', '10%'),
      ('Oral Glucose Tolerance Test (OGTT)', '6%'),
      ('Sodium', '6 mg/dL'),
      ('Chloride', '23%'),
      ('Potassium', '19%'),
      ('ALT', '16 mg/dL'),
      ('ALP', '12%'),
      ('Bilirubin', '14g%'),
    ];

    return _SourceFrameScaffold(
      title: 'Blood Test',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SoftCard(
            color: AppColors.softBlue,
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam rutrum gravida mauris, eu commodo lectus dapibus at.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          const _SectionLabel('Glucose · Electrolytes · Liver Enzymes'),
          const SizedBox(height: 12),
          for (var i = 0; i < metrics.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: SoftCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        metrics[i].$1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      metrics[i].$2,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
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

class VaccinationsScreen extends StatelessWidget {
  const VaccinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const history = [
      ('Covid', '18 / 09 / 2022', 'Second dose'),
      ('Tetanus', '15 / 08 / 2020', 'Third dose'),
      ('Typus', '02 / 06 / 2019', 'Completed'),
      ('Hepatitis', '03 / 20 / 2017', 'Completed'),
      ('Human Papillomavirus (HPV)', '17 / 24 / 2026', 'Next due'),
    ];

    return _SourceFrameScaffold(
      title: 'Vaccinations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Immunisation history'),
          const SizedBox(height: 14),
          for (var i = 0; i < history.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                color: i == history.length - 1
                    ? AppColors.softBlue
                    : AppColors.white,
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.check_mark_circled,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            history[i].$1,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            history[i].$2,
                            style: const TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      history[i].$3,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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

class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Medical History',
      child: Column(
        children: [
          const SoftCard(
            color: AppColors.softBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paroxysmal Tachycardia',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(height: 1.5),
                ),
                Divider(height: 26),
                _InfoRow(
                  icon: CupertinoIcons.calendar,
                  title: 'Appointment date',
                  value: '24 / 01 / 2026',
                ),
                _InfoRow(
                  icon: CupertinoIcons.heart,
                  title: 'Treatment Plan',
                  value: '5mg Morning · 15mg Night',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionLabel('Doctors'),
          const SizedBox(height: 12),
          const _MiniDoctorRow(
            initials: 'EH',
            name: 'Dr. Emma Hall, M.D.',
            specialty: 'General Doctor',
          ),
          const SizedBox(height: 12),
          const _MiniDoctorRow(
            initials: 'JT',
            name: 'Dr. James Taylor, M.D.',
            specialty: 'Doctor',
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: 'Download history',
            icon: CupertinoIcons.arrow_down_doc,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo history downloaded')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PharmacyFilterScreen extends StatefulWidget {
  const PharmacyFilterScreen({super.key});

  @override
  State<PharmacyFilterScreen> createState() => _PharmacyFilterScreenState();
}

class _PharmacyFilterScreenState extends State<PharmacyFilterScreen> {
  final city = TextEditingController(text: 'Oakland, CA');
  final address = TextEditingController(text: '778 Locust View Drive');

  @override
  void dispose() {
    city.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Filter',
      actions: [
        TextButton(
          onPressed: () {
            city.clear();
            address.clear();
          },
          child: const Text(
            'Clear',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: city,
            decoration: const InputDecoration(
              labelText: '+ Add your City',
              prefixIcon: Icon(CupertinoIcons.location),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: address,
            decoration: const InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(CupertinoIcons.map_pin_ellipse),
            ),
          ),
          const SizedBox(height: 18),
          const _MapPreview(),
          const SizedBox(height: 22),
          const _SectionLabel('Find your nearest pharmacy'),
          const SizedBox(height: 12),
          const _PharmacyResult(
            name: 'MediCure Pharmacy',
            distance: '2.5 km',
            schedule: '7:15 AM - 6:30 PM',
            recommended: true,
          ),
          const SizedBox(height: 12),
          const _PharmacyResult(
            name: 'Vitality Pharmacy',
            distance: '5 km',
            schedule: '9:00 AM - 8:30 PM',
            recommended: true,
          ),
          const SizedBox(height: 12),
          const _PharmacyResult(
            name: 'PureHealth Pharmacy',
            distance: '6.3 km',
            schedule: '8:00 AM - 9:00 PM',
            recommended: false,
          ),
        ],
      ),
    );
  }
}

class PharmacyDetailsScreen extends StatelessWidget {
  const PharmacyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SourceFrameScaffold(
      title: 'MediCure Pharmacy',
      child: Column(
        children: [
          _MapPreview(height: 190),
          SizedBox(height: 18),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MediCure Pharmacy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8),
                TinyRating(4.8),
                SizedBox(height: 12),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam rhoncus nulla ac porttitor rutrum.',
                  style: TextStyle(color: AppColors.muted, height: 1.5),
                ),
                Divider(height: 26),
                _InfoRow(
                  icon: CupertinoIcons.location,
                  title: 'Address',
                  value: '778 Locust View Drive Oakland, CA',
                ),
                _InfoRow(
                  icon: CupertinoIcons.phone,
                  title: 'Phone',
                  value: '(323) 302-9912',
                ),
                _InfoRow(
                  icon: CupertinoIcons.clock,
                  title: 'Attention schedule',
                  value: '7:15 AM - 6:30 PM',
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          _SectionLabel('User frequency'),
          SizedBox(height: 12),
          _UsageBar(label: 'Morning', value: .2),
          _UsageBar(label: 'Afternoon', value: .8),
          _UsageBar(label: 'Evening', value: .5),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({this.height = 150});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(22),
      ),
      child: CustomPaint(
        painter: _MapPreviewPainter(),
        child: const Center(
          child: Icon(
            CupertinoIcons.location_solid,
            color: AppColors.primary,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class _MapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = AppColors.white
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final secondary = Paint()
      ..color = AppColors.paleLilac
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * .05, size.height * .22),
      Offset(size.width * .95, size.height * .78),
      road,
    );
    canvas.drawLine(
      Offset(size.width * .1, size.height * .8),
      Offset(size.width * .88, size.height * .12),
      secondary,
    );
    canvas.drawLine(
      Offset(size.width * .48, 0),
      Offset(size.width * .55, size.height),
      road,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PharmacyResult extends StatelessWidget {
  const _PharmacyResult({
    required this.name,
    required this.distance,
    required this.schedule,
    required this.recommended,
  });

  final String name;
  final String distance;
  final String schedule;
  final bool recommended;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: () => context.push('/pharmacy/details'),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              CupertinoIcons.add_circled,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(
                  schedule,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Distance: $distance',
                  style: const TextStyle(color: AppColors.primary, fontSize: 12),
                ),
              ],
            ),
          ),
          if (recommended)
            const Icon(
              CupertinoIcons.star_fill,
              color: Color(0xFFFFC857),
              size: 18,
            ),
        ],
      ),
    );
  }
}

class _UsageBar extends StatelessWidget {
  const _UsageBar({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 82, child: Text(label)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: value,
                backgroundColor: AppColors.softBlue,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${(value * 100).round()}%',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class AppointmentCompleteScreen extends StatelessWidget {
  const AppointmentCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const completed = [
      ('LP', 'Dr. Lucy Perez, Ph.D.', 'Clinical Dermatology', 5.0),
      ('EH', 'Dr. Emma Hall, M.D.', 'General Doctor', 4.0),
      ('JL', 'Dr. Jacob Lopez, M.D.', 'Surgical Dermatology', 5.0),
      ('QC', 'Dr. Quinn Cooper, M.D.', 'Geriatric Gynecology', 5.0),
    ];

    return _SourceFrameScaffold(
      title: 'Complete',
      child: Column(
        children: [
          const _AppointmentStatusNav(selected: 'Complete'),
          const SizedBox(height: 18),
          for (var i = 0; i < completed.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                child: Column(
                  children: [
                    _MiniDoctorRow(
                      initials: completed[i].$1,
                      name: completed[i].$2,
                      specialty: completed[i].$3,
                      rating: completed[i].$4,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                context.push('/doctor/emma/schedule'),
                            child: const Text('Re-Book'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => context.push('/review'),
                            child: const Text('Add Review'),
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
    );
  }
}

class AppointmentCancelledScreen extends StatelessWidget {
  const AppointmentCancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const cancelled = [
      ('RK', 'Dr. Rachel Kim', 'Oncology'),
      ('JR', 'Dr. Jonathan Rodriguez', 'Ophthalmology'),
      ('CE', 'Dr. Christopher Evans', 'Orthopedics'),
      ('SP', 'Dr. Samantha Patel', 'Ophthalmology'),
    ];

    return _SourceFrameScaffold(
      title: 'Cancelled',
      child: Column(
        children: [
          const _AppointmentStatusNav(selected: 'Cancelled'),
          const SizedBox(height: 18),
          for (var i = 0; i < cancelled.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                child: _MiniDoctorRow(
                  initials: cancelled[i].$1,
                  name: cancelled[i].$2,
                  specialty: cancelled[i].$3,
                  trailing: TextButton(
                    onPressed: () => context.push('/review'),
                    child: const Text('Add Review'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AppointmentStatusNav extends StatelessWidget {
  const _AppointmentStatusNav({required this.selected});

  final String selected;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Complete', '/appointments/complete'),
      ('Upcoming', '/appointments/upcoming'),
      ('Cancelled', '/appointments/cancelled'),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: ChoiceChip(
              label: Text(items[i].$1),
              selected: selected == items[i].$1,
              onSelected: (_) => context.go(items[i].$2),
            ),
          ),
          if (i != items.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class CancelAppointmentScreen extends StatefulWidget {
  const CancelAppointmentScreen({super.key});

  @override
  State<CancelAppointmentScreen> createState() => _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  String reason = 'rescheduling';
  final notes = TextEditingController();

  @override
  void dispose() {
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const reasons = [
      'rescheduling',
      'weather conditions',
      'unexpected work',
      'others',
    ];

    return _SourceFrameScaffold(
      title: 'Cancel Appointment',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Choose a reason'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in reasons)
                ChoiceChip(
                  label: Text(item),
                  selected: reason == item,
                  onSelected: (_) => setState(() => reason = item),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: notes,
            minLines: 5,
            maxLines: 7,
            decoration: const InputDecoration(
              hintText: 'Enter your reason here...',
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Cancel Appointment',
            onPressed: () => context.go('/appointments/cancelled'),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final name = TextEditingController(text: 'Jane Doe');
  final phone = TextEditingController(text: '+123 567 89000');
  final email = TextEditingController(text: 'Janedoe@example.com');
  final birth = TextEditingController(text: 'DD / MM / YYYY');

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    birth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Profile',
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const DoctorAvatar(initials: 'JD', size: 107),
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Phone number'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: birth,
            decoration: const InputDecoration(labelText: 'Date of birth'),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Update Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated for demo')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  final values = <String, bool>{
    'General Notification': true,
    'Sound': true,
    'Sound Call': true,
    'Vibrate': false,
    'Special Offers': false,
    'Payments': false,
    'Promo and discount': false,
    'Cashback': false,
  };

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Notification Setting',
      child: SoftCard(
        child: Column(
          children: [
            for (var i = 0; i < values.length; i++) ...[
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(values.keys.elementAt(i)),
                value: values.values.elementAt(i),
                onChanged: (value) {
                  setState(() {
                    values[values.keys.elementAt(i)] = value;
                  });
                },
              ),
              if (i != values.length - 1) const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }
}

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({super.key});

  @override
  State<PasswordManagerScreen> createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  final current = TextEditingController();
  final next = TextEditingController();
  final confirm = TextEditingController();

  @override
  void dispose() {
    current.dispose();
    next.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Password Manager',
      child: Column(
        children: [
          TextField(
            controller: current,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Current Password'),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => context.push('/set-password'),
              child: const Text('Forgot password?'),
            ),
          ),
          TextField(
            controller: next,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'New Password'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: confirm,
            obscureText: true,
            decoration:
                const InputDecoration(labelText: 'Confirm New Password'),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Change Password',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed in demo state')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SourceFrameScaffold(
      title: 'Privacy Policy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last update: 14/08/2024',
            style: TextStyle(color: AppColors.muted),
          ),
          SizedBox(height: 14),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam. Fusce a scelerisque neque, sed accumsan metus.',
            style: TextStyle(height: 1.6),
          ),
          SizedBox(height: 24),
          Text(
            'Terms & Conditions',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '1. Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci.\n\n2. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisi tellus ac turpis.\n\n3. Morbi pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor.',
            style: TextStyle(height: 1.65),
          ),
        ],
      ),
    );
  }
}

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  final expanded = <int>{0};

  @override
  Widget build(BuildContext context) {
    const questions = [
      'How can I book a doctor?',
      'How do payments work?',
      'Can I change an appointment?',
      'Where can I find my medical records?',
      'How do I contact support?',
    ];

    return _SourceFrameScaffold(
      title: 'Help center',
      child: Column(
        children: [
          const Text(
            'How can we help you?',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 18),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('FAQ')),
              ButtonSegment(value: 1, label: Text('Contact Us')),
            ],
            selected: const <int>{0},
            onSelectionChanged: (_) => context.go('/help/contact'),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < questions.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: SoftCard(
                onTap: () {
                  setState(() {
                    expanded.contains(i) ? expanded.remove(i) : expanded.add(i);
                  });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            questions[i],
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Icon(
                          expanded.contains(i)
                              ? CupertinoIcons.chevron_up
                              : CupertinoIcons.chevron_down,
                          size: 18,
                        ),
                      ],
                    ),
                    AnimatedCrossFade(
                      duration: AppMotion.quick,
                      crossFadeState: expanded.contains(i)
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox.shrink(),
                      secondChild: const Padding(
                        padding: EdgeInsetsDirectional.only(top: 12),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem.',
                          style: TextStyle(
                            color: AppColors.muted,
                            height: 1.45,
                          ),
                        ),
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

class HelpContactScreen extends StatelessWidget {
  const HelpContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const options = [
      (CupertinoIcons.chat_bubble_2, 'Customer service'),
      (CupertinoIcons.globe, 'Website'),
      (CupertinoIcons.phone, 'WhatsApp'),
      (CupertinoIcons.person_2, 'Facebook'),
      (CupertinoIcons.camera, 'Instagram'),
    ];

    return _SourceFrameScaffold(
      title: 'Help center',
      child: Column(
        children: [
          const Text(
            'How can we help you?',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 18),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('FAQ')),
              ButtonSegment(value: 1, label: Text('Contact Us')),
            ],
            selected: const <int>{1},
            onSelectionChanged: (_) => context.go('/help/faq'),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < options.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(options[i].$1, color: AppColors.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        options[i].$2,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.chevron_forward,
                      color: AppColors.muted,
                      size: 18,
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

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: 'Logout',
      child: Column(
        children: [
          const DoctorAvatar(initials: 'JD', size: 107),
          const SizedBox(height: 14),
          const Text(
            'Jane Doe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          const Text(
            '+123 567 89000 · Janedoe@example.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 30),
          const SoftCard(
            color: AppColors.softBlue,
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.square_arrow_right,
                  color: AppColors.danger,
                  size: 38,
                ),
                SizedBox(height: 12),
                Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Yes, Logout',
            onPressed: () => context.go('/login'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class DoctorRatingScreen extends StatelessWidget {
  const DoctorRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const doctors = [
      ('EH', 'Dr. Emma Hall, M.D.', 'General Doctor', 5.0),
      ('QC', 'Dr. Quinn Cooper, M.D.', 'Geriatric Gynecology', 4.9),
      ('JL', 'Dr. Jacob Lopez, M.D.', 'Surgical Dermatology', 4.8),
      ('LP', 'Dr. Lucy Perez, Ph.D.', 'Clinical Dermatology', 4.8),
    ];

    return _SourceFrameScaffold(
      title: 'Rating',
      actions: [
        IconButton(
          onPressed: () => context.push('/filter'),
          icon: const Icon(
            CupertinoIcons.slider_horizontal_3,
            color: AppColors.white,
          ),
        ),
      ],
      child: Column(
        children: [
          const _SortStrip(),
          const SizedBox(height: 16),
          for (var i = 0; i < doctors.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                onTap: () => context.push('/doctor/emma'),
                child: _MiniDoctorRow(
                  initials: doctors[i].$1,
                  name: doctors[i].$2,
                  specialty: doctors[i].$3,
                  rating: doctors[i].$4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FavoriteServicesScreen extends StatelessWidget {
  const FavoriteServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const services = [
      ('Cardiology', CupertinoIcons.heart),
      ('Dermatology', CupertinoIcons.sparkles),
      ('General Medicine', CupertinoIcons.add_circled),
      ('Gynecology', CupertinoIcons.circle_grid_hex),
      ('Odontology', CupertinoIcons.smiley),
      ('Oncology', CupertinoIcons.burst),
    ];

    return _SourceFrameScaffold(
      title: 'Favorite Services',
      child: Column(
        children: [
          const _FavoriteTabs(selected: 'Services'),
          const SizedBox(height: 16),
          const _SortStrip(),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.12,
            ),
            itemBuilder: (context, index) {
              return SoftCard(
                onTap: () => context.push('/specialties'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      services[index].$2,
                      size: 40,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      services[index].$1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FavoriteFemaleDoctorsScreen extends StatelessWidget {
  const FavoriteFemaleDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GenderFavoriteScreen(
      title: 'Female',
      selected: 'Female',
      doctors: [
        ('HL', 'Dr. Hannah Lewis, M.D.', 'Dermatopathology'),
        ('AW', 'Dr. Ava Williams, M.D.', 'Maternal-Fetal Medicine'),
        ('EW', 'Dr. Emily Wang', 'Neuro-Ophthalmologist'),
        ('CG', 'Dr. Chloe Green, M.D.', 'Obstetrics and Gynecology'),
        ('EH', 'Dr. Emma Hall, M.D.', 'General Doctor'),
      ],
    );
  }
}

class FavoriteMaleDoctorsScreen extends StatelessWidget {
  const FavoriteMaleDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GenderFavoriteScreen(
      title: 'Male',
      selected: 'Male',
      doctors: [
        ('JT', 'Dr. James Taylor, M.D.', 'General Doctor'),
        ('HD', 'Dr. Henry Davis, Ph.D.', 'Prosthodontics'),
        ('BD', 'Dr. Benjamin Davis', 'Retinal Specialist'),
        ('CE', 'Dr. Christopher Evans', 'Spine Surgeon'),
        ('JL', 'Dr. Jacob Lopez, M.D.', 'Surgical Dermatology'),
      ],
    );
  }
}

class _GenderFavoriteScreen extends StatelessWidget {
  const _GenderFavoriteScreen({
    required this.title,
    required this.selected,
    required this.doctors,
  });

  final String title;
  final String selected;
  final List<(String, String, String)> doctors;

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: title,
      child: Column(
        children: [
          const _FavoriteTabs(selected: 'Doctors'),
          const SizedBox(height: 14),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Female', label: Text('Female')),
              ButtonSegment(value: 'Male', label: Text('Male')),
            ],
            selected: <String>{selected},
            onSelectionChanged: (value) {
              context.go(
                value.first == 'Female'
                    ? '/favorites/female'
                    : '/favorites/male',
              );
            },
          ),
          const SizedBox(height: 14),
          const _SortStrip(),
          const SizedBox(height: 18),
          for (var i = 0; i < doctors.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: SoftCard(
                onTap: () => context.push('/doctor/emma'),
                child: _MiniDoctorRow(
                  initials: doctors[i].$1,
                  name: doctors[i].$2,
                  specialty: doctors[i].$3,
                  rating: 4.8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FavoriteTabs extends StatelessWidget {
  const _FavoriteTabs({required this.selected});

  final String selected;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'Doctors', label: Text('Doctors')),
        ButtonSegment(value: 'Services', label: Text('Services')),
      ],
      selected: <String>{selected},
      onSelectionChanged: (value) {
        context.go(
          value.first == 'Services' ? '/favorites/services' : '/favorites',
        );
      },
    );
  }
}

class _SortStrip extends StatelessWidget {
  const _SortStrip();

  @override
  Widget build(BuildContext context) {
    return const SoftCard(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(CupertinoIcons.arrow_up_arrow_down, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Sort by'),
          Spacer(),
          Text(
            'A→Z',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 12),
          Icon(CupertinoIcons.slider_horizontal_3, color: AppColors.primary),
          SizedBox(width: 4),
          Text('Filter'),
        ],
      ),
    );
  }
}

class DermatologyDoctorsVariantScreen extends StatelessWidget {
  const DermatologyDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Dermatology',
      doctors: [
        ('LP', 'Dr. Lucy Perez, Ph.D.', 'Clinical Dermatology'),
        ('HL', 'Dr. Hannah Lewis, M.D.', 'Dermatopathology'),
        ('LW', 'Dr. Logan Williams, M.D.', 'Dermatology'),
        ('JL', 'Dr. Jacob Lopez, M.D.', 'Surgical Dermatology'),
      ],
    );
  }
}

class GeneralDoctorsVariantScreen extends StatelessWidget {
  const GeneralDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'General Medicine',
      doctors: [
        ('MC', 'Dr. Madison Clark, Ph.D.', 'General Doctor'),
        ('EH', 'Dr. Emma Hall, M.D.', 'General Doctor'),
        ('TR', 'Dr. Thomas Rivera, M.D.', 'General Doctor'),
        ('JT', 'Dr. James Taylor, M.D.', 'General Medicine'),
      ],
    );
  }
}

class GynecologyDoctorsVariantScreen extends StatelessWidget {
  const GynecologyDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Gynecology',
      doctors: [
        ('DL', 'Dr. Daniel Lee, Ph.D.', 'Gynecologic Oncology'),
        ('AW', 'Dr. Ava Williams, M.D.', 'Maternal-Fetal Medicine'),
        ('QC', 'Dr. Quinn Cooper, M.D.', 'Geriatric Gynecology'),
        ('CG', 'Dr. Chloe Green, M.D.', 'OB/GYN'),
      ],
    );
  }
}

class OdontologyDoctorsVariantScreen extends StatelessWidget {
  const OdontologyDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Odontology',
      doctors: [
        ('HD', 'Dr. Henry Davis, Ph.D.', 'Prosthodontics'),
        ('DL', 'Dr. Dylan Lewis, M.D.', 'Endodontics'),
        ('JG', 'Dr. Joseph Green, M.D.', 'Special Care Dentistry'),
        ('HM', 'Dr. Hazel Mitchell, M.D.', 'Periodontics'),
      ],
    );
  }
}

class OncologyDoctorsVariantScreen extends StatelessWidget {
  const OncologyDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Oncology',
      doctors: [
        ('SP', 'Dr. Sophia Patel', 'Radiation Oncologist'),
        ('RK', 'Dr. Rachel Kim', 'Medical Oncologist'),
        ('DS', 'Dr. David Smith', 'Oncologist'),
        ('ML', 'Dr. Matthew Lee', 'Surgical Oncologist'),
      ],
    );
  }
}

class OphthalmologyDoctorsVariantScreen extends StatelessWidget {
  const OphthalmologyDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Ophthalmology',
      doctors: [
        ('SP', 'Dr. Samantha Patel', 'Glaucoma Specialist'),
        ('JR', 'Dr. Jonathan Rodriguez', 'Ophthalmologist'),
        ('BD', 'Dr. Benjamin Davis', 'Retinal Specialist'),
        ('EW', 'Dr. Emily Wang', 'Neuro-Ophthalmologist'),
      ],
    );
  }
}

class OrthopedicsDoctorsVariantScreen extends StatelessWidget {
  const OrthopedicsDoctorsVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SpecialtyDoctorsVariant(
      title: 'Orthopedics',
      doctors: [
        ('MC', 'Dr. Megan Chen', 'Orthopedic Doctor'),
        ('SC', 'Dr. Sarah Chang', 'Orthopedic Doctor'),
        ('CE', 'Dr. Christopher Evans', 'Spine Surgeon'),
        ('JK', 'Dr. Jessica Kim', 'Sports Medicine Specialist'),
      ],
    );
  }
}

class _SpecialtyDoctorsVariant extends StatelessWidget {
  const _SpecialtyDoctorsVariant({
    required this.title,
    required this.doctors,
  });

  final String title;
  final List<(String, String, String)> doctors;

  @override
  Widget build(BuildContext context) {
    return _SourceFrameScaffold(
      title: title,
      actions: [
        IconButton(
          onPressed: () => context.push('/filter'),
          icon: const Icon(
            CupertinoIcons.slider_horizontal_3,
            color: AppColors.white,
          ),
        ),
      ],
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(height: 14),
          const _SortStrip(),
          const SizedBox(height: 18),
          for (var i = 0; i < doctors.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: AnimatedAppear(
                delay: Duration(milliseconds: 55 * i),
                child: SoftCard(
                  onTap: () => context.push('/doctor/emma'),
                  child: _MiniDoctorRow(
                    initials: doctors[i].$1,
                    name: doctors[i].$2,
                    specialty: doctors[i].$3,
                    rating: 4.8,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MiniDoctorRow extends StatelessWidget {
  const _MiniDoctorRow({
    required this.initials,
    required this.name,
    required this.specialty,
    this.rating,
    this.trailing,
  });

  final String initials;
  final String name;
  final String specialty;
  final double? rating;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DoctorAvatar(initials: initials, size: 58),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(
                specialty,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              if (rating != null) ...[
                const SizedBox(height: 6),
                TinyRating(rating!),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
