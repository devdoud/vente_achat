import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import 'boutique_atelier_screen.dart';

/// Écran statique affiché quand le produit est en modération (status = draft).
class AnnoncePendingScreen extends StatefulWidget {
  final Annonce annonce;
  final String  productUuid;
  final String? localImagePath;

  const AnnoncePendingScreen({
    super.key,
    required this.annonce,
    required this.productUuid,
    this.localImagePath,
  });

  @override
  State<AnnoncePendingScreen> createState() => _AnnoncePendingScreenState();
}

class _AnnoncePendingScreenState extends State<AnnoncePendingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final Animation<double>   _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.88, end: 1.0)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  Future<void> _goToBoutique(BuildContext ctx) async {
    final prefs    = await SharedPreferences.getInstance();
    final nom      = prefs.getString('boutique_name')     ?? '';
    final ville    = prefs.getString('boutique_ville')    ?? '';
    final quartier = prefs.getString('boutique_quartier') ?? '';
    if (!ctx.mounted) return;
    // Retour à la racine puis ouverture directe du dashboard boutique
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.of(ctx).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => BoutiqueAtelierScreen(nom: nom, ville: ville, quartier: quartier),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: VAPadding.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Icône animée
              Center(
                child: ScaleTransition(
                  scale: _pulseAnim,
                  child: SizedBox(
                    width: 140, height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140, height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1).withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 112, height: 112,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFFFFD54F).withValues(alpha: 0.5),
                                width: 2),
                          ),
                        ),
                        Container(
                          width: 84, height: 84,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF57C00), Color(0xFFFFB300)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(VARadius.xl),
                          ),
                          child: const Icon(
                            Icons.hourglass_top_rounded,
                            color: Colors.white, size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'En attente de validation',
                style: VATextStyles.displayTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Votre annonce a bien été soumise.\nNos équipes la vérifient avant de la mettre en ligne.',
                textAlign: TextAlign.center,
                style: VATextStyles.body,
              ),

              const SizedBox(height: 24),

              // Carte produit avec image
              _PendingProductCard(
                annonce:        widget.annonce,
                localImagePath: widget.localImagePath,
              ),

              const SizedBox(height: 16),

              // Bandeau info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE082)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFFF57C00)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'La validation prend généralement moins de 24h. Vous serez notifié une fois approuvée.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF7B5800), height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Retour boutique
              VAPrimaryButton(
                label: 'Retour à la boutique',
                onPressed: () => _goToBoutique(context),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Carte produit ────────────────────────────────────────────────────────────

class _PendingProductCard extends StatelessWidget {
  final Annonce annonce;
  final String? localImagePath;
  const _PendingProductCard({required this.annonce, this.localImagePath});

  @override
  Widget build(BuildContext context) {
    final networkUrl = annonce.photos.isNotEmpty ? annonce.photos.first : null;

    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8)],
      ),
      child: Row(
        children: [
          // Image : locale → réseau → placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(VARadius.sm),
            child: SizedBox(
              width: 56, height: 56,
              child: localImagePath != null
                  ? Image.file(File(localImagePath!), fit: BoxFit.cover)
                  : networkUrl != null
                      ? CachedNetworkImage(
                          imageUrl: networkUrl,
                          fit: BoxFit.cover,
                          fadeInDuration: Duration.zero,
                          placeholder: (_, __) => _imagePlaceholder(),
                          errorWidget: (_, __, ___) => _imagePlaceholder(),
                        )
                      : _imagePlaceholder(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 7, height: 7,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFB300), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text('EN MODÉRATION',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w800,
                          color: Color(0xFFF57C00), letterSpacing: 0.5)),
                ]),
                const SizedBox(height: 4),
                Text(annonce.titre, style: VATextStyles.bodyMedium,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(annonce.prixFormate, style: VATextStyles.price),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
        color: const Color(0xFFFFF3CD),
        child: const Center(
          child: Icon(Icons.inventory_2_outlined, color: Color(0xFFF57C00), size: 24),
        ),
      );
}
