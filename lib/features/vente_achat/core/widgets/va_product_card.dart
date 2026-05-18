import 'package:flutter/material.dart';
import '../../models/annonce.dart';
import '../va_theme.dart';

class VAProductCard extends StatefulWidget {
  final Annonce annonce;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const VAProductCard({
    super.key,
    required this.annonce,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  State<VAProductCard> createState() => _VAProductCardState();
}

class _VAProductCardState extends State<VAProductCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.lg),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(annonce: widget.annonce, isFavorite: _isFavorite, onFavorite: () {
              setState(() => _isFavorite = !_isFavorite);
              widget.onFavorite?.call();
            }),
            Padding(
              padding: const EdgeInsets.all(VAPadding.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.annonce.titre, style: VATextStyles.cardTitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  if (widget.annonce.ancienPrix != null)
                    Text(widget.annonce.ancienPrixFormate!, style: VATextStyles.priceStrike),
                  Text(widget.annonce.prixFormate, style: VATextStyles.price),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 11, color: VAColors.grey),
                      const SizedBox(width: 2),
                      Text(widget.annonce.localisation, style: VATextStyles.caption),
                      const Spacer(),
                      Text(widget.annonce.tempsPublication, style: VATextStyles.caption),
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

class _ProductImage extends StatelessWidget {
  final Annonce annonce;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const _ProductImage({required this.annonce, required this.isFavorite, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: _bgColor(annonce.categorie),
            child: Center(
              child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 48)),
            ),
          ),
        ),
        if (annonce.isPro)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: VAColors.primary,
                borderRadius: BorderRadius.circular(VARadius.xs),
              ),
              child: const Text('✓ Pro', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
          ),
        if (annonce.remisePourcent != null)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: VAColors.red,
                borderRadius: BorderRadius.circular(VARadius.xs),
              ),
              child: Text('+ -${annonce.remisePourcent}%', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
          ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onFavorite,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: isFavorite ? VAColors.red : VAColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _bgColor(AnnonceCategorie cat) => switch (cat) {
        AnnonceCategorie.telephones => const Color(0xFFE3F2FD),
        AnnonceCategorie.mode => const Color(0xFFFCE4EC),
        AnnonceCategorie.hightech => const Color(0xFFE8F5E9),
        AnnonceCategorie.auto => const Color(0xFFFFF8E1),
        _ => const Color(0xFFF3E5F5),
      };
}

// Card compacte pour la liste "Mes annonces"
class VAAnnonceListCard extends StatelessWidget {
  final Annonce annonce;
  final VoidCallback? onEdit;
  final VoidCallback? onOptions;

  const VAAnnonceListCard({super.key, required this.annonce, this.onEdit, this.onOptions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: VAPadding.sm),
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(VARadius.sm),
            ),
            child: Center(child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: VAPadding.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _StatusBadge(status: annonce.status),
                    if (annonce.vues > 0) ...[
                      const SizedBox(width: 8),
                      Row(children: [
                        const Icon(Icons.remove_red_eye_outlined, size: 12, color: VAColors.grey),
                        const SizedBox(width: 2),
                        Text('${annonce.vues} vues', style: VATextStyles.caption),
                      ]),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(annonce.titre, style: VATextStyles.cardTitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(annonce.prixFormate, style: VATextStyles.price),
              ],
            ),
          ),
          Column(
            children: [
              if (annonce.status == AnnonceStatus.active)
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined, size: 18, color: VAColors.grey)),
              IconButton(onPressed: onOptions, icon: const Icon(Icons.more_horiz, size: 20, color: VAColors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AnnonceStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, bg) = switch (status) {
      AnnonceStatus.active => (VAColors.green, VAColors.greenLight),
      AnnonceStatus.enAttente => (const Color(0xFFF57C00), const Color(0xFFFFF3E0)),
      AnnonceStatus.vendue => (VAColors.grey, VAColors.greyLight),
      AnnonceStatus.enLigne => (VAColors.green, VAColors.greenLight),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(status.label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
    );
  }
}
