import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_colors.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/health_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label, String? route})>[
      (icon: CupertinoIcons.person, label: 'profile.profile'.tr(), route: null),
      (icon: CupertinoIcons.heart, label: 'home.favorite'.tr(), route: AppRoutes.favorites),
      (icon: CupertinoIcons.creditcard, label: 'payment.method'.tr(), route: AppRoutes.paymentMethod),
      (icon: CupertinoIcons.lock_shield, label: 'profile.privacy'.tr(), route: null),
      (icon: CupertinoIcons.gear, label: 'profile.settings'.tr(), route: AppRoutes.settings),
      (icon: CupertinoIcons.question_circle, label: 'profile.help'.tr(), route: null),
      (icon: CupertinoIcons.square_arrow_right, label: 'profile.logout'.tr(), route: AppRoutes.entry),
    ];
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 2),
      child: Column(
        children: [
          _ProfileHero(onBack: () => context.go(AppRoutes.home)),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 22, 30, 28),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: item.route == null ? null : () => context.push(item.route!),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(width: 42, height: 42, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])), child: Icon(item.icon, color: Colors.white, size: 22)),
                        const SizedBox(width: 18),
                        Expanded(child: Text(item.label, style: Theme.of(context).textTheme.titleLarge)),
                        Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_left : CupertinoIcons.chevron_right, color: AppColors.aqua, size: 22),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label})>[
      (icon: CupertinoIcons.bell, label: 'settings.notifications'.tr()),
      (icon: CupertinoIcons.key, label: 'settings.password'.tr()),
      (icon: CupertinoIcons.person_crop_circle_badge_xmark, label: 'settings.delete'.tr()),
    ];
    return HealthPage(
      child: Column(
        children: [
          AquaHeader(title: 'profile.settings'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 24, 30, 24),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) => Row(
                children: [
                  Container(width: 42, height: 42, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])), child: Icon(items[index].icon, color: Colors.white)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(items[index].label, style: Theme.of(context).textTheme.titleLarge)),
                  Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_left : CupertinoIcons.chevron_right, color: AppColors.aqua),
                ],
              ),
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
    final rows = [
      ('Today', 'notifications.appointment', '2 m', CupertinoIcons.calendar),
      ('Today', 'notifications.change', '2 h', CupertinoIcons.calendar_badge_plus),
      ('Today', 'notifications.notes', '3 h', CupertinoIcons.doc_text),
      ('Yesterday', 'notifications.appointment', '1 d', CupertinoIcons.calendar),
      ('15 April', 'notifications.history', '5 d', CupertinoIcons.chat_bubble_text),
    ];
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 0),
      child: Column(
        children: [
          AquaHeader(title: 'notifications.title'.tr(), onBack: () => context.pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 18, 30, 24),
              children: [
                Row(children: [const Pill(label: 'Today', selected: true), const SizedBox(width: 8), const Expanded(child: SearchField()), TextButton(onPressed: () {}, child: Text('notifications.mark_all'.tr()))]),
                const Divider(height: 28),
                for (var i = 0; i < rows.length; i++) ...[
                  if (i == 3 || i == 4) ...[
                    Pill(label: rows[i].$1, padding: const EdgeInsetsDirectional.fromSTEB(14, 5, 14, 5)),
                    const Divider(height: 18),
                  ],
                  _NotificationRow(title: rows[i].$2.tr(), time: rows[i].$3, icon: rows[i].$4, highlighted: i == 1),
                  const Divider(height: 14),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthPage(
      bottomNavigationBar: const HealthBottomNav(currentIndex: 1),
      child: Column(
        children: [
          AquaHeader(
            title: 'Dr. Emma Hall, M.D.',
            onBack: () => context.go(AppRoutes.home),
            trailing: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(CupertinoIcons.phone_circle_fill, color: Colors.white), SizedBox(width: 8), Icon(CupertinoIcons.video_camera_solid, color: Colors.white)]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 22, 30, 12),
              children: const [
                _ChatBubble(text: 'I reviewed your recent notes. Everything looks stable.', time: '09:00', mine: true),
                _ChatBubble(text: 'Thank you, doctor. Should I keep the same routine this week?', time: '09:30'),
                _ChatBubble(text: 'Yes. Keep the same schedule and let me know if anything changes.', time: '09:43', mine: true),
                _VoiceBubble(time: '09:50'),
                _ChatBubble(text: 'Perfect, thank you!', time: '09:55', mine: true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 8),
            child: Align(alignment: AlignmentDirectional.centerStart, child: Text('messages.typing'.tr(), style: const TextStyle(color: AppColors.aqua))),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
            child: Row(
              children: [
                _WhiteCircle(icon: CupertinoIcons.paperclip),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                    child: TextField(decoration: InputDecoration(filled: false, hintText: 'messages.write_here'.tr(), prefixIcon: const SizedBox(width: 8), suffixIcon: const Icon(CupertinoIcons.mic, color: AppColors.aqua), contentPadding: const EdgeInsetsDirectional.only(top: 10))),
                  ),
                ),
                const SizedBox(width: 8),
                const _WhiteCircle(icon: CupertinoIcons.paperplane_fill),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      height: 238 + top,
      padding: EdgeInsetsDirectional.fromSTEB(24, top + 10, 24, 20),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep])),
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [Align(alignment: AlignmentDirectional.centerStart, child: IconButton(onPressed: onBack, icon: Icon(Directionality.of(context) == TextDirection.rtl ? CupertinoIcons.chevron_right : CupertinoIcons.chevron_left, color: Colors.white))), Text('profile.my_profile'.tr(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 22),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [const InitialAvatar(name: 'Jane Doe', size: 108, emphasized: true), const SizedBox(width: 16), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Jane Doe', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)), const Text('+123 567 89000', style: TextStyle(color: Colors.white)), const Text('janedoe@example.com', style: TextStyle(color: Colors.white))])]),
        ],
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.title, required this.time, required this.icon, this.highlighted = false});
  final String title;
  final String time;
  final IconData icon;
  final bool highlighted;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(color: highlighted ? AppColors.ice : Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: Row(children: [Container(width: 46, height: 46, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.aquaBright, AppColors.aquaDeep]), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text('notifications.body'.tr(), maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall)])), Text(time)]),
      );
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.time, this.mine = false});
  final String text;
  final String time;
  final bool mine;
  @override
  Widget build(BuildContext context) => Align(
        alignment: mine ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 18),
          child: Column(crossAxisAlignment: mine ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [Container(constraints: const BoxConstraints(maxWidth: 215), padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: mine ? AppColors.ice : Colors.white, border: mine ? null : Border.all(color: AppColors.aqua), borderRadius: BorderRadius.circular(20)), child: Text(text)), const SizedBox(height: 3), Text(time, style: Theme.of(context).textTheme.bodySmall)]),
        ),
      );
}

class _VoiceBubble extends StatelessWidget {
  const _VoiceBubble({required this.time});
  final String time;
  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 210, height: 48, padding: const EdgeInsetsDirectional.symmetric(horizontal: 12), decoration: BoxDecoration(border: Border.all(color: AppColors.aqua), borderRadius: BorderRadius.circular(20)), child: Row(children: [const InitialAvatar(name: 'Emma', size: 34), const SizedBox(width: 6), const Icon(CupertinoIcons.play_circle_fill, color: AppColors.aqua), const SizedBox(width: 6), Expanded(child: Container(height: 3, color: AppColors.aqua)), const SizedBox(width: 8), const Text('02:50', style: TextStyle(fontSize: 10))])), const SizedBox(height: 3), Text(time, style: Theme.of(context).textTheme.bodySmall)]),
        ),
      );
}

class _WhiteCircle extends StatelessWidget {
  const _WhiteCircle({required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(width: 38, height: 38, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Icon(icon, color: AppColors.aqua, size: 20));
}
