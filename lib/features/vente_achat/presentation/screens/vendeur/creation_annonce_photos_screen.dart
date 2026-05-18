import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../transaction/vendre_form_screen.dart';
import 'creation_widgets.dart';

@RoutePage()
class CreationAnnoncePhotosScreen extends StatefulWidget {
  const CreationAnnoncePhotosScreen({super.key});

  @override
  State<CreationAnnoncePhotosScreen> createState() =>
      _CreationAnnoncePhotosScreenState();
}

class _CreationAnnoncePhotosScreenState
    extends State<CreationAnnoncePhotosScreen> {
  // Simule des photos ajoutées (couleurs de fond)
  final List<Color> _photos = [
    VAColors.primary,
    const Color(0xFFFFCC80),
    const Color(0xFFFFB74D),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      appBar: CreationAppBar(
        title: 'Nouvelle annonce',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Barre de progression ─────────────────────────────────────
            CreationStepBar(current: 1, total: 4),
            const SizedBox(height: 20),

            // ── Étape label ──────────────────────────────────────────────
            const Text('ÉTAPE 1 SUR 4',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: VAColors.primary)),
            const SizedBox(height: 6),

            // ── Titre ────────────────────────────────────────────────────
            RichText(
              text: const TextSpan(
                style: TextStyle(fontFamily: 'Poppins', fontSize: 26, height: 1.2, color: VAColors.black),
                children: [
                  TextSpan(text: 'Ajoutez vos\n', style: TextStyle(fontWeight: FontWeight.w300)),
                  TextSpan(text: 'photos', style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: VAColors.greyText),
                children: [
                  TextSpan(text: 'La '),
                  TextSpan(text: 'première photo',
                      style: TextStyle(fontWeight: FontWeight.w700, color: VAColors.black)),
                  TextSpan(text: ' est la plus importante.'),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // ── Zone d'upload ────────────────────────────────────────────
            _UploadZone(),
            const SizedBox(height: 14),

            // ── Tips inline ──────────────────────────────────────────────
            _TipRow(Icons.check_circle_outline_rounded, '5 photos minimum pour de meilleurs résultats'),
            const SizedBox(height: 8),
            _TipRow(Icons.check_circle_outline_rounded, 'Bonne luminosité et fond neutre recommandés'),
            const SizedBox(height: 22),

            // ── Grille photos ajoutées ───────────────────────────────────
            _PhotoGrid(
              photos: _photos,
              onRemove: (i) => setState(() => _photos.removeAt(i)),
              onAdd: () {},
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      // ── Bottom bar ───────────────────────────────────────────────────
      bottomNavigationBar: CreationBottomBar(
        onBack: () => Navigator.of(context).pop(),
        onNext: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const VendreFormScreen()),
        ),
        canContinue: _photos.isNotEmpty,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  SPÉCIFIQUES PHOTOS
// ═══════════════════════════════════════════════════════════════════════════

class _UploadZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 168,
        decoration: BoxDecoration(
          color: VAColors.primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: VAColors.primary.withValues(alpha: 0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Motif décoratif semi-transparent
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Contenu
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Prendre une photo',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'ou choisir depuis la galerie',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12),
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

class _TipRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _TipRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, color: VAColors.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 12, color: VAColors.greyText)),
          ),
        ],
      );
}

class _PhotoGrid extends StatelessWidget {
  final List<Color> photos;
  final ValueChanged<int> onRemove;
  final VoidCallback onAdd;
  const _PhotoGrid(
      {required this.photos, required this.onRemove, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PHOTOS AJOUTÉES (${photos.length}/10)',
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: VAColors.grey),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 78,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...photos.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: e.value,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: e.key == 0
                              ? Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text('PRINCIPAL',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w800)),
                                  ),
                                )
                              : null,
                        ),
                        // Bouton supprimer
                        Positioned(
                          top: 3,
                          right: 3,
                          child: GestureDetector(
                            onTap: () => onRemove(e.key),
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.close,
                                  color: Colors.white, size: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              // Bouton ajouter
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 72,
                  height: 72,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: VAColors.greyBorder, width: 1.5),
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: VAColors.grey, size: 26),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
