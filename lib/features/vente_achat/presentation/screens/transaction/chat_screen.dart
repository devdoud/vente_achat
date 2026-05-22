import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Vendeur vendeur;
  final Annonce? annonce;
  const ChatScreen({super.key, required this.vendeur, this.annonce});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = List.from(ConversationsMock.chatMessages);

  static const _suggestions = ['D\'accord', 'Lancer Offre Sûre', 'Adresse de retrait'];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        contenu: _controller.text.trim(),
        heure: DateTime.now(),
        isMe: true,
      ));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _ChatAppBar(vendeur: widget.vendeur),
      body: Column(
        children: [
          if (widget.annonce != null) _AnnonceSticky(annonce: widget.annonce!),
          _DateDivider(label: '— Aujourd\'hui —'),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: VAPadding.sm),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _MessageBubble(message: _messages[i]),
            ),
          ),
          _SuggestionsRow(
            suggestions: _suggestions,
            onTap: (s) { _controller.text = s; _send(); },
          ),
          _InputBar(controller: _controller, onSend: _send),
        ],
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Vendeur vendeur;
  const _ChatAppBar({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_rounded, color: VAColors.black, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          VAAvatarVendeur(vendeur: vendeur, size: 36),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vendeur.nom, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
              const Text('En ligne', style: TextStyle(fontSize: 11, color: VAColors.green, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.phone_outlined, color: VAColors.primary), onPressed: () {}),
      ],
      bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider(height: 1, color: VAColors.greyBorder)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

class _AnnonceSticky extends StatelessWidget {
  final Annonce annonce;
  const _AnnonceSticky({required this.annonce});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: VAPadding.sm),
      color: VAColors.primaryLight,
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(VARadius.sm)),
            child: Center(child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(annonce.titre, style: VATextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(annonce.prixFormate, style: VATextStyles.price),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: VAColors.primary),
        ],
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  final String label;
  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(label, style: VATextStyles.caption, textAlign: TextAlign.center),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: message.isMe ? VAColors.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(VARadius.lg),
                topRight: const Radius.circular(VARadius.lg),
                bottomLeft: Radius.circular(message.isMe ? VARadius.lg : VARadius.xs),
                bottomRight: Radius.circular(message.isMe ? VARadius.xs : VARadius.lg),
              ),
              boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4)],
            ),
            child: Text(
              message.contenu,
              style: TextStyle(fontSize: 14, color: message.isMe ? Colors.white : VAColors.black, height: 1.4),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${message.heure.hour.toString().padLeft(2, '0')}:${message.heure.minute.toString().padLeft(2, '0')}',
                style: VATextStyles.caption,
              ),
              if (message.isMe && message.isLu) ...[
                const SizedBox(width: 4),
                const Icon(Icons.done_all, size: 12, color: VAColors.primary),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionsRow extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onTap;
  const _SuggestionsRow({required this.suggestions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 4),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => onTap(suggestions[i]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(VARadius.xxl),
              border: Border.all(color: VAColors.greyBorder),
            ),
            child: Text(suggestions[i], style: const TextStyle(fontSize: 13, color: VAColors.black, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: VAColors.greyBorder))),
      child: Row(
        children: [
          const Icon(Icons.nightlight_round, color: VAColors.grey, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Tapez un message...',
                hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
                filled: true,
                fillColor: VAColors.greyLight,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.xxl), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.xxl), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.xxl), borderSide: BorderSide.none),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 42, height: 42,
              decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(VARadius.xxl)),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
