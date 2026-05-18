import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';
import '../../models/export.dart';

@RoutePage()
class ActiviteScreen extends StatefulWidget {
  const ActiviteScreen({super.key});

  @override
  State<ActiviteScreen> createState() => _ActiviteScreenState();
}

class _ActiviteScreenState extends State<ActiviteScreen> {
  int _tabIndex = 0;
  static const _tabs = ['Toutes', 'Messages', 'Transactions'];

  @override
  Widget build(BuildContext context) {
    final items = ConversationsMock.activities;
    final aujourd = items.where((i) => DateTime.now().difference(i.heure).inHours < 24).toList();
    final hier = items.where((i) {
      final diff = DateTime.now().difference(i.heure);
      return diff.inHours >= 24 && diff.inHours < 48;
    }).toList();

    return Scaffold(
      backgroundColor: VAColors.background,
      appBar: VAAppBar(
        title: 'Activité',
        showBack: false,
        actions: [IconButton(icon: const Icon(Icons.check_rounded), onPressed: () {})],
      ),
      body: Column(
        children: [
          _TabBar(tabs: _tabs, selected: _tabIndex, nonLus: 7, onSelect: (i) => setState(() => _tabIndex = i)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: VAPadding.sm),
              children: [
                if (aujourd.isNotEmpty) ...[
                  const _SectionHeader(label: 'AUJOURD\'HUI'),
                  ...aujourd.map((item) => _ActivityTile(item: item)),
                ],
                if (hier.isNotEmpty) ...[
                  const _SectionHeader(label: 'HIER'),
                  ...hier.map((item) => _ActivityTile(item: item)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final int nonLus;
  final ValueChanged<int> onSelect;
  const _TabBar({required this.tabs, required this.selected, required this.nonLus, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 8),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => VAFilterChip(
          label: tabs[i],
          isSelected: i == selected,
          count: i == 0 ? nonLus : null,
          onTap: () => onSelect(i),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: VAPadding.xs),
      child: Text(label, style: VATextStyles.label),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivityItem item;
  const _ActivityTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final (iconData, color, bg) = _iconForType(item.type);

    return Container(
      color: item.isLu ? Colors.transparent : VAColors.primaryLight.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(VARadius.md)),
            child: Icon(iconData, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.titre, style: TextStyle(fontSize: 14, fontWeight: item.isLu ? FontWeight.w500 : FontWeight.w700, color: VAColors.black)),
                const SizedBox(height: 3),
                Text(item.sousTitre, style: VATextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(item.heureFormatee, style: VATextStyles.caption),
              ],
            ),
          ),
          if (!item.isLu)
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: VAColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }

  (IconData, Color, Color) _iconForType(MessageType type) => switch (type) {
        MessageType.message => (Icons.chat_bubble_outline_rounded, VAColors.primary, VAColors.primaryLight),
        MessageType.livraison => (Icons.delivery_dining_rounded, VAColors.green, VAColors.greenLight),
        MessageType.paiement => (Icons.check_circle_outline_rounded, VAColors.blue, VAColors.blueLight),
        MessageType.alertePrix => (Icons.bolt_rounded, VAColors.purple, VAColors.purpleLight),
        MessageType.action => (Icons.info_outline_rounded, VAColors.red, VAColors.redLight),
      };
}
