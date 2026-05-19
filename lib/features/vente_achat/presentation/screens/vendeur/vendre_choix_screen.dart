import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/va_theme.dart';
import 'boutique_atelier_screen.dart';
import 'boutique_setup_screen.dart';
import 'creation_annonce_photos_screen.dart';
import 'vendre_onboarding_screen.dart';

class VendreChoixScreen extends StatefulWidget {
  const VendreChoixScreen({super.key});

  @override
  State<VendreChoixScreen> createState() => _VendreChoixScreenState();
}

class _VendreChoixScreenState extends State<VendreChoixScreen> {
  bool   _setupDone = false;
  bool   _onbDone   = false;
  String _nom       = '';
  String _emoji     = '🛍';
  String _ville     = '';
  String _quartier  = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _onbDone   = p.getBool('vendre_onboarding_done') ?? false;
      _setupDone = p.getBool('boutique_setup_done')    ?? false;
      _nom       = p.getString('boutique_name')        ?? '';
      _emoji     = p.getString('boutique_emoji')       ?? '🛍';
      _ville     = p.getString('boutique_ville')       ?? '';
      _quartier  = p.getString('boutique_quartier')    ?? '';
    });
  }

  void _goQuick() => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
      );

  void _goBoutique() {
    final Widget screen = !_onbDone
        ? const VendreOnboardingScreen()
        : !_setupDone
            ? const BoutiqueSetupScreen()
            : BoutiqueAtelierScreen(
                nom: _nom, emoji: _emoji,
                ville: _ville, quartier: _quartier);
    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Retour ──────────────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 15, color: VAColors.black),
                ),
              ),

              const SizedBox(height: 18),

              // ── Titre ────────────────────────────────────────────────────
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      height: 1.25,
                      color: VAColors.black),
                  children: [
                    TextSpan(
                        text: 'Que voulez-vous\n',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'faire ?',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Cartes (remplissent l'espace restant) ────────────────────
              Expanded(
                child: Column(
                  children: [

                    Expanded(
                      child: _OptionCard(
                        emoji:       '📦',
                        emojiColor:  VAColors.primaryLight,
                        title:       'Vendre un article',
                        description: 'Quelques effets perso à vendre ?\nSimple, rapide et sans engagement.',
                        hints: const ['Photos', 'Détails & prix', 'Justificatif'],
                        accentColor: VAColors.primary,
                        ctaLabel:    'Commencer',
                        onTap:       _goQuick,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Expanded(
                      child: _OptionCard(
                        emoji:       _setupDone ? _emoji : '🏪',
                        emojiColor:  const Color(0xFFEDE7F6),
                        title:       _setupDone
                            ? (_nom.isNotEmpty ? _nom : 'Ma boutique')
                            : 'Ouvrir ma boutique',
                        description: _setupDone
                            ? 'Accédez à votre atelier,\ngérez vos annonces et ventes.'
                            : 'Pour vendre régulièrement avec\nune vitrine et un badge confiance.',
                        hints: _setupDone
                            ? const ['Atelier', 'Annonces', 'Stats']
                            : const ['Identité', 'Lieu', 'RCCM', 'Prêt'],
                        accentColor: const Color(0xFF5C6BC0),
                        ctaLabel:    _setupDone ? 'Accéder' : 'Configurer',
                        onTap:       _goBoutique,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  CARTE — s'étire pour remplir sa moitié de l'écran
// ═══════════════════════════════════════════════════════════════════════════

class _OptionCard extends StatelessWidget {
  final String       emoji;
  final Color        emojiColor;
  final String       title;
  final String       description;
  final List<String> hints;
  final Color        accentColor;
  final String       ctaLabel;
  final VoidCallback onTap;

  const _OptionCard({
    required this.emoji,
    required this.emojiColor,
    required this.title,
    required this.description,
    required this.hints,
    required this.accentColor,
    required this.ctaLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Icône + titre
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                    color: emojiColor, shape: BoxShape.circle),
                child: Center(
                    child: Text(emoji,
                        style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: VAColors.black,
                      height: 1.3),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Description
          Text(
            description,
            style: const TextStyle(
                fontSize: 13,
                color: VAColors.greyText,
                height: 1.55),
          ),

          // Spacer pousse pills + bouton en bas
          const Spacer(),

          // Pills légères
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (int i = 0; i < hints.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15, height: 15,
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: accentColor)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(hints[i],
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: accentColor)),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          // Bouton
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.22),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ctaLabel,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
