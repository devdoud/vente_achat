import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:achat_vente/features/router/router.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class AnnoncePubileeScreen extends StatefulWidget {
  final Annonce annonce;
  final String? localImagePath;
  const AnnoncePubileeScreen({super.key, required this.annonce, this.localImagePath});

  @override
  State<AnnoncePubileeScreen> createState() => _AnnoncePubileeScreenState();
}

class _AnnoncePubileeScreenState extends State<AnnoncePubileeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VAPadding.xl),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              children: [
                const Spacer(),
                ScaleTransition(scale: _scaleAnim, child: _SuccessAnimation()),
                const SizedBox(height: 32),
                const Text('Annonce publiée !', style: VATextStyles.displayTitle, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                const Text(
                  'Votre produit est maintenant visible\npar des milliers d\'acheteurs.',
                  textAlign: TextAlign.center,
                  style: VATextStyles.body,
                ),
                const SizedBox(height: 32),
                _AnnoncePreviewCard(annonce: widget.annonce, localImagePath: widget.localImagePath),
                const Spacer(),
                VAPrimaryButton(
                  label: 'Voir mon annonce →',
                  backgroundColor: VAColors.primary,
                  // Retour à l'accueil — l'annonce y sera visible dans le feed
                  onPressed: () => context.router.replaceAll([const SuperAppHomeRoute()]),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  // Recommencer une création depuis zéro
                  onTap: () => context.router.popUntil((route) => route.isFirst),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: VAColors.primary, size: 16),
                      SizedBox(width: 4),
                      Text('Publier une autre annonce', style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 15)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160, height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 160, height: 160,
            decoration: BoxDecoration(color: VAColors.green.withValues(alpha: 0.06), shape: BoxShape.circle),
          ),
          Container(
            width: 130, height: 130,
            decoration: BoxDecoration(
              color: VAColors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: VAColors.green.withValues(alpha: 0.2), width: 2, style: BorderStyle.solid),
            ),
          ),
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF43A047), Color(0xFF66BB6A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(VARadius.xl),
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 52),
          ),
        ],
      ),
    );
  }
}

// ─── Avatar produit ───────────────────────────────────────────────────────────

class _ProductAvatar extends StatelessWidget {
  final Annonce annonce;
  const _ProductAvatar({required this.annonce});

  /// Extraie les initiales pertinentes depuis le titre (1 à 2 lettres).
  String get _initials {
    final words = annonce.titre
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) return words.first[0].toUpperCase();
    // Deux premiers mots significatifs (ignore les petits mots)
    final meaningful = words.where((w) => w.length > 2).toList();
    if (meaningful.length >= 2) {
      return '${meaningful[0][0]}${meaningful[1][0]}'.toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  /// Couleur de fond dérivée de la première lettre du titre (palette fixe).
  Color get _bg {
    const palette = [
      Color(0xFFD6EBFF), Color(0xFFFFDDE9), Color(0xFFD9F2DD),
      Color(0xFFFFF0C2), Color(0xFFF0DCF9), Color(0xFFD4F0FC),
      Color(0xFFD6F5E3), Color(0xFFFFEBCC),
    ];
    if (annonce.titre.isEmpty) return palette[0];
    return palette[annonce.titre.codeUnitAt(0) % palette.length];
  }

  Color get _textColor {
    final bg = _bg;
    return Color.fromRGBO(
      (bg.r * 0.45).toInt(),
      (bg.g * 0.45).toInt(),
      (bg.b * 0.45).toInt(),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56, height: 56,
      decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(VARadius.sm)),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            fontSize: _initials.length == 1 ? 24 : 18,
            fontWeight: FontWeight.w900,
            color: _textColor,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _AnnoncePreviewCard extends StatelessWidget {
  final Annonce annonce;
  final String? localImagePath;
  const _AnnoncePreviewCard({required this.annonce, this.localImagePath});

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
          // Image : locale → réseau → initiales
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
                          placeholder: (_, __) => _ProductAvatar(annonce: annonce),
                          errorWidget: (_, __, ___) => _ProductAvatar(annonce: annonce),
                        )
                      : _ProductAvatar(annonce: annonce),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(color: VAColors.green, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text('EN LIGNE',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800,
                          color: VAColors.green, letterSpacing: 0.5)),
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
}
