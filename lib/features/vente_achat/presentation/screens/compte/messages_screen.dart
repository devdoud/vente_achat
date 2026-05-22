import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../transaction/chat_screen.dart';

@RoutePage()
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _filterIndex = 0;
  static const _filters = ['Tout', 'Non lus', 'Acheteurs', 'Vendeurs'];

  @override
  Widget build(BuildContext context) {
    final conversations = ConversationsMock.all;
    final nonLus = conversations.where((c) => c.nonLus > 0).length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VAAppBar(
        title: 'Messages',
        showBack: false,
        actions: [IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})],
      ),
      body: Column(
        children: [
          _SearchBar(),
          _FilterBar(filters: _filters, selectedIndex: _filterIndex, nonLus: nonLus, onSelected: (i) => setState(() => _filterIndex = i)),
          Expanded(
            child: ListView.separated(
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: VAColors.greyBorder, indent: 72),
              itemBuilder: (_, i) => _ConversationTile(
                conv: conversations[i],
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ChatScreen(vendeur: conversations[i].interlocuteur)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(VAPadding.base),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.md),
      height: 44,
      decoration: BoxDecoration(
        color: VAColors.greyLight,
        borderRadius: BorderRadius.circular(VARadius.md),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: VAColors.grey, size: 20),
          SizedBox(width: 8),
          Text('Rechercher une conversation...', style: TextStyle(color: VAColors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final int nonLus;
  final ValueChanged<int> onSelected;

  const _FilterBar({required this.filters, required this.selectedIndex, required this.nonLus, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => VAFilterChip(
          label: filters[i],
          isSelected: i == selectedIndex,
          count: i == 1 ? nonLus : null,
          onTap: () => onSelected(i),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conv;
  final VoidCallback onTap;
  const _ConversationTile({required this.conv, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: conv.nonLus > 0 ? VAColors.primaryLight.withValues(alpha: 0.3) : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                VAAvatarVendeur(vendeur: conv.interlocuteur, size: 50),
                if (conv.isEnLigne)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(color: VAColors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(conv.interlocuteur.nom,
                            style: TextStyle(fontSize: 15, fontWeight: conv.nonLus > 0 ? FontWeight.w700 : FontWeight.w600, color: VAColors.black)),
                      ),
                      Text(conv.heureFormatee,
                          style: TextStyle(fontSize: 12, color: conv.nonLus > 0 ? VAColors.primary : VAColors.grey, fontWeight: conv.nonLus > 0 ? FontWeight.w700 : FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(conv.dernierMessage,
                            style: TextStyle(fontSize: 13, color: conv.nonLus > 0 ? VAColors.black : VAColors.grey,
                                fontWeight: conv.nonLus > 0 ? FontWeight.w600 : FontWeight.w400),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      if (conv.nonLus > 0)
                        Container(
                          width: 20, height: 20,
                          decoration: const BoxDecoration(color: VAColors.primary, shape: BoxShape.circle),
                          child: Center(child: Text('${conv.nonLus}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800))),
                        )
                      else if (conv.isLu)
                        const Icon(Icons.done_all, size: 14, color: VAColors.primary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
