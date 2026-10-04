import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system.dart';
import '../home/home_screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HealthBottomNav(selectedIndex: 3),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.fromSTEB(20, 14, 20, 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Profile',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.push('/settings'),
                        icon: const Icon(CupertinoIcons.settings),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const DoctorAvatar(initials: 'HA', size: 104),
                  const SizedBox(height: 16),
                  Text(
                    'Hussein Abozina',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'hussein@example.com',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 26),
                  SoftCard(
                    child: Column(
                      children: [
                        _ProfileRow(
                          icon: CupertinoIcons.person_crop_circle,
                          title: 'Edit profile',
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        _ProfileRow(
                          icon: CupertinoIcons.heart,
                          title: 'Favorites',
                          onTap: () => context.push('/favorites'),
                        ),
                        const Divider(height: 1),
                        _ProfileRow(
                          icon: CupertinoIcons.doc_text,
                          title: 'Medical record',
                          onTap: () => context.push('/medical-record'),
                        ),
                        const Divider(height: 1),
                        _ProfileRow(
                          icon: CupertinoIcons.creditcard,
                          title: 'Payment methods',
                          onTap: () => context.push('/payment/method'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SoftCard(
                    child: _ProfileRow(
                      icon: CupertinoIcons.arrow_right,
                      title: 'Log out',
                      destructive: true,
                      onTap: () => context.go('/login'),
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool reminders = true;
  bool messages = true;
  bool biometrics = false;

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Settings',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notifications',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _SwitchRow(
                  title: 'Appointment reminders',
                  value: reminders,
                  onChanged: (value) => setState(() => reminders = value),
                ),
                const Divider(height: 1),
                _SwitchRow(
                  title: 'Doctor messages',
                  value: messages,
                  onChanged: (value) => setState(() => messages = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Security',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _SwitchRow(
                  title: 'Biometric unlock',
                  value: biometrics,
                  onChanged: (value) => setState(() => biometrics = value),
                ),
                const Divider(height: 1),
                _ProfileRow(
                  icon: CupertinoIcons.lock,
                  title: 'Password manager',
                  onTap: () => context.push('/set-password'),
                ),
                const Divider(height: 1),
                _ProfileRow(
                  icon: CupertinoIcons.lock,
                  title: 'Privacy policy',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const notifications = [
      (
        CupertinoIcons.calendar,
        'Appointment confirmed',
        'Your visit with Dr. Emma is scheduled for Monday at 10:30 AM.',
        '2 min'
      ),
      (
        CupertinoIcons.chat_bubble_2,
        'New message',
        'Dr. Emma sent you a follow-up note.',
        '1 hr'
      ),
      (
        CupertinoIcons.add_circled,
        'Pharmacy reminder',
        'Your saved pharmacy closes at 10:00 PM.',
        'Yesterday'
      ),
    ];

    return HealthScaffold(
      title: 'Notifications',
      showBack: true,
      child: Column(
        children: notifications
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 14),
                child: AnimatedAppear(
                  delay: Duration(milliseconds: 70 * entry.key),
                  child: SoftCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.softBlue,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            entry.value.$1,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      entry.value.$2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    entry.value.$4,
                                    style: const TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                entry.value.$3,
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  height: 1.45,
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
            )
            .toList(),
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthScaffold(
      title: 'Dr. Emma',
      showBack: true,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 22),
      child: Column(
        children: [
          const _MessageBubble(
            text: 'Hello Hussein, I reviewed your latest notes.',
            incoming: true,
          ),
          const _MessageBubble(
            text: 'Thank you. Is there anything I should do before Monday?',
            incoming: false,
          ),
          const _MessageBubble(
            text:
                'Please keep your current routine and bring your recent reports with you.',
            incoming: true,
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 4, 4),
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: false,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.paperplane_fill),
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
  String specialty = 'Cardiology';
  double maxFee = 80;
  bool availableToday = true;

  @override
  Widget build(BuildContext context) {
    const specialties = [
      'Cardiology',
      'Dermatology',
      'General',
      'Gynecology',
    ];

    return HealthScaffold(
      title: 'Filter',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specialty',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: specialties
                .map(
                  (item) => ChoiceChip(
                    label: Text(item),
                    selected: specialty == item,
                    onSelected: (_) => setState(() => specialty = item),
                    selectedColor: AppColors.softBlue,
                    side: const BorderSide(color: AppColors.border),
                    labelStyle: TextStyle(
                      color: specialty == item
                          ? AppColors.primary
                          : AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          Text(
            'Maximum consultation fee',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '\${maxFee.toStringAsFixed(0)}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          Slider(
            value: maxFee,
            min: 20,
            max: 150,
            divisions: 13,
            onChanged: (value) => setState(() => maxFee = value),
          ),
          const SizedBox(height: 10),
          SoftCard(
            child: _SwitchRow(
              title: 'Available today',
              value: availableToday,
              onChanged: (value) => setState(() => availableToday = value),
            ),
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            label: 'Apply filters',
            onPressed: () => context.go('/doctors'),
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.danger : AppColors.ink;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: destructive ? AppColors.danger : AppColors.primary),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
      trailing: Icon(
        CupertinoIcons.chevron_forward,
        size: 18,
        color: destructive ? AppColors.danger : AppColors.muted,
      ),
      onTap: onTap,
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 13),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        CupertinoSwitch(
          value: value,
          activeTrackColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.text, required this.incoming});

  final String text;
  final bool incoming;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          incoming ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
      child: AnimatedAppear(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 286),
          margin: const EdgeInsetsDirectional.only(bottom: 12),
          padding: const EdgeInsetsDirectional.fromSTEB(14, 11, 14, 11),
          decoration: BoxDecoration(
            color: incoming ? AppColors.softBlue : AppColors.primary,
            borderRadius: BorderRadiusDirectional.only(
              topStart: const Radius.circular(18),
              topEnd: const Radius.circular(18),
              bottomStart: Radius.circular(incoming ? 5 : 18),
              bottomEnd: Radius.circular(incoming ? 18 : 5),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: incoming ? AppColors.ink : Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ),
    );
  }
}
