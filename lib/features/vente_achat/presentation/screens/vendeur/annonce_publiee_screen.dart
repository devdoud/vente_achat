import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class AnnoncePubileeScreen extends StatefulWidget {
  final Annonce annonce;
  const AnnoncePubileeScreen({super.key, required this.annonce});

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
                _AnnoncePreviewCard(annonce: widget.annonce),
                const Spacer(),
                VAPrimaryButton(
                  label: 'Voir mon annonce →',
                  backgroundColor: VAColors.cardBlack,
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
          Positioned(top: 8, left: 16, child: Text('🎉', style: const TextStyle(fontSize: 22))),
          Positioned(top: 8, right: 16, child: Text('⭐', style: const TextStyle(fontSize: 18))),
          Positioned(bottom: 8, left: 8, child: Text('🎊', style: const TextStyle(fontSize: 20))),
          Positioned(bottom: 12, right: 12, child: Text('✨', style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class _AnnoncePreviewCard extends StatelessWidget {
  final Annonce annonce;
  const _AnnoncePreviewCard({required this.annonce});

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(VARadius.sm)),
            child: Center(child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 28))),
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
                  const Text('EN LIGNE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: VAColors.green, letterSpacing: 0.5)),
                ]),
                const SizedBox(height: 4),
                Text(annonce.titre, style: VATextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(annonce.prixFormate, style: VATextStyles.price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
