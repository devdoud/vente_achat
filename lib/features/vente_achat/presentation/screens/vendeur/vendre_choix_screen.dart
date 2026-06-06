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
  bool   _loading   = true;
  bool   _setupDone = false;
  bool   _onbDone   = false;
  String _nom       = '';
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
      _loading   = false;
      _onbDone   = p.getBool('vendre_onboarding_done') ?? false;
      _setupDone = p.getBool('boutique_setup_done')    ?? false;
      _nom       = p.getString('boutique_name')        ?? '';
      _ville     = p.getString('boutique_ville')       ?? '';
      _quartier  = p.getString('boutique_quartier')    ?? '';
    });
  }

  // ─── Navigations ─────────────────────────────────────────────────────────

  void _goQuick() => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
      );

  void _goBoutique() {
    final screen = !_onbDone
        ? const VendreOnboardingScreen()
        : BoutiqueAtelierScreen(nom: _nom, ville: _ville, quartier: _quartier);
    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (_) => screen),
    );
  }

  void _goNewBoutique() => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const BoutiqueSetupScreen(),
        ),
      );

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Bouton retour
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8, offset: const Offset(0, 2),
                    )],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 15, color: VAColors.black),
                ),
              ),

              const SizedBox(height: 18),

              if (_loading)
                const Expanded(child: Center(
                  child: CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2),
                ))
              else if (!_setupDone)
                _NoBoutiqueLayout(onQuick: _goQuick, onBoutique: _goBoutique)
              else
                _HasBoutiqueLayout(
                  nom:      _nom,
                  ville:    _ville,
                  quartier: _quartier,
                  onAtelier:     _goBoutique,
                  onQuick:       _goQuick,
                  onNewBoutique: _goNewBoutique,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Layout : PAS de boutique ─────────────────────────────────────────────────

class _NoBoutiqueLayout extends StatelessWidget {
  final VoidCallback onQuick, onBoutique;
  const _NoBoutiqueLayout({required this.onQuick, required this.onBoutique});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontFamily: 'Poppins', fontSize: 26, height: 1.25, color: VAColors.black),
              children: [
                TextSpan(text: 'Que voulez-vous\n', style: TextStyle(fontWeight: FontWeight.w300)),
                TextSpan(text: 'faire ?',           style: TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text('Choisissez comment vous souhaitez vendre.',
              style: TextStyle(fontSize: 13, color: VAColors.greyText)),
          const SizedBox(height: 20),

          // Deux cartes égales
          Expanded(
            child: _OptionCard(
              icon: Icons.shopping_bag_outlined,
              iconColor: VAColors.primary,
              iconBg: VAColors.primaryLight,
              title: 'Vendre un article',
              description: 'Quelques effets perso à vendre ?\nSimple, rapide et sans engagement.',
              hints: const ['Photos', 'Détails & prix', 'Justificatif'],
              accentColor: VAColors.primary,
              ctaLabel: 'Commencer',
              onTap: onQuick,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _OptionCard(
              icon: Icons.storefront_outlined,
              iconColor: const Color(0xFF5C6BC0),
              iconBg: const Color(0xFFEDE7F6),
              title: 'Ouvrir ma boutique',
              description: 'Pour vendre régulièrement avec\nune vitrine et un badge confiance.',
              hints: const ['Identité', 'Lieu', 'RCCM', 'Prêt'],
              accentColor: const Color(0xFF5C6BC0),
              ctaLabel: 'Configurer',
              onTap: onBoutique,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Layout : A DÉJÀ une boutique ─────────────────────────────────────────────

class _HasBoutiqueLayout extends StatelessWidget {
  final String nom, ville, quartier;
  final VoidCallback onAtelier, onQuick, onNewBoutique;

  const _HasBoutiqueLayout({
    required this.nom,
    required this.ville,
    required this.quartier,
    required this.onAtelier,
    required this.onQuick,
    required this.onNewBoutique,
  });

  @override
  Widget build(BuildContext context) {
    final initials = nom.trim().split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          RichText(
            text: TextSpan(
              style: TextStyle(fontFamily: 'Poppins', fontSize: 26, height: 1.25, color: VAColors.black),
              children: [
                TextSpan(text: 'Que voulez-vous\n', style: TextStyle(fontWeight: FontWeight.w300)),
                TextSpan(text: 'faire ?',           style: TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text('Accédez à votre boutique ou vendez un article.',
              style: TextStyle(fontSize: 13, color: VAColors.greyText)),
          const SizedBox(height: 20),

          // Carte boutique principale (grande)
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: onAtelier,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [VAColors.primary, VAColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(
                    color: VAColors.primary.withValues(alpha: 0.30),
                    blurRadius: 18, offset: const Offset(0, 6),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header : logo + nom + badge
                    Row(
                      children: [
                        Container(
                          width: 52, height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(initials,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nom.isNotEmpty ? nom : 'Ma boutique',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17,
                                    fontWeight: FontWeight.w800, height: 1.2),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              if (quartier.isNotEmpty || ville.isNotEmpty)
                                Row(children: [
                                  const Icon(Icons.place_outlined, color: Colors.white60, size: 12),
                                  const SizedBox(width: 3),
                                  Flexible(
                                    child: Text(
                                      [if (quartier.isNotEmpty) quartier, if (ville.isNotEmpty) ville].join(', '),
                                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: VAColors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, size: 6, color: Colors.white),
                              SizedBox(width: 4),
                              Text('Ouverte',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // CTA
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dashboard_outlined, size: 16, color: VAColors.primary),
                          const SizedBox(width: 8),
                          Text('Accéder à l\'atelier',
                              style: TextStyle(
                                  color: VAColors.primary,
                                  fontSize: 14, fontWeight: FontWeight.w800)),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 14, color: VAColors.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Deux petites cartes côte à côte
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: _SmallCard(
                    icon: Icons.shopping_bag_outlined,
                    iconColor: VAColors.primary,
                    iconBg: VAColors.primaryLight,
                    title: 'Vendre\nun article',
                    ctaLabel: 'Vendre',
                    accentColor: VAColors.primary,
                    onTap: onQuick,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SmallCard(
                    icon: Icons.add_business_outlined,
                    iconColor: const Color(0xFF2E7D32),
                    iconBg: const Color(0xFFE8F5E9),
                    title: 'Créer une\nautre boutique',
                    ctaLabel: 'Créer',
                    accentColor: const Color(0xFF2E7D32),
                    onTap: onNewBoutique,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Grande carte option ──────────────────────────────────────────────────────

class _OptionCard extends StatelessWidget {
  final IconData     icon;
  final Color        iconColor, iconBg, accentColor;
  final String       title, description, ctaLabel;
  final List<String> hints;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
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
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 18, offset: const Offset(0, 5),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Center(child: Icon(icon, size: 20, color: iconColor)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontSize: 15,
                        fontWeight: FontWeight.w700, color: VAColors.black, height: 1.3),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(description,
                style: const TextStyle(fontSize: 12, color: VAColors.greyText, height: 1.5),
                overflow: TextOverflow.ellipsis, maxLines: 4),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: [
              for (int i = 0; i < hints.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
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
                            color: accentColor.withValues(alpha: 0.15), shape: BoxShape.circle),
                        child: Center(
                          child: Text('${i + 1}',
                              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: accentColor)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(hints[i],
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accentColor)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [BoxShadow(
                  color: accentColor.withValues(alpha: 0.22),
                  blurRadius: 10, offset: const Offset(0, 4),
                )],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ctaLabel, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Petite carte (layout boutique existante) ─────────────────────────────────

class _SmallCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg, accentColor;
  final String title, ctaLabel;
  final VoidCallback onTap;

  const _SmallCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.ctaLabel,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 14, offset: const Offset(0, 4),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Center(child: Icon(icon, size: 18, color: iconColor)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black, height: 1.3)),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(ctaLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700, color: accentColor)),
            ),
          ),
        ],
      ),
    );
  }
}
