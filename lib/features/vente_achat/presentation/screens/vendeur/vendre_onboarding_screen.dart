import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import 'boutique_setup_screen.dart';

const _kOnboardingDone = 'vendre_onboarding_done';

//  Données catégories pour l'étape de sélection 

const _onbCats = [
  (emoji: '', label: 'Téléphones',  cat: AnnonceCategorie.telephones),
  (emoji: '', label: 'Mode',        cat: AnnonceCategorie.mode),
  (emoji: '', label: 'Maison',      cat: AnnonceCategorie.maison),
  (emoji: '', label: 'Auto',        cat: AnnonceCategorie.auto),
  (emoji: '', label: 'Beauté',      cat: AnnonceCategorie.beaute),
  (emoji: '',  label: 'High-tech',  cat: AnnonceCategorie.hightech),
  (emoji: '', label: 'Sport',       cat: AnnonceCategorie.sport),
  (emoji: '', label: 'Livres',      cat: AnnonceCategorie.livres),
];

// 
//  ÉCRAN PRINCIPAL
// 

class VendreOnboardingScreen extends StatefulWidget {
  const VendreOnboardingScreen({super.key});

  @override
  State<VendreOnboardingScreen> createState() => _VendreOnboardingState();
}

class _VendreOnboardingState extends State<VendreOnboardingScreen> {
  final _ctrl = PageController();
  int _page = 0;
  final Set<AnnonceCategorie> _selCats = {};

  //  Navigation 

  void _next() {
    if (_page < 2) {
      _ctrl.nextPage(
          duration: const Duration(milliseconds: 380), curve: Curves.easeInOutCubic);
    } else {
      _finish();
    }
  }

  void _back() {
    if (_page > 0) {
      _ctrl.previousPage(
          duration: const Duration(milliseconds: 280), curve: Curves.easeInOut);
    }
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingDone, true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const BoutiqueSetupScreen(),
    ));
  }

  //  Build 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _ctrl,
        physics: const NeverScrollableScrollPhysics(), // contrôle manuel
        onPageChanged: (i) => setState(() => _page = i),
        children: [
          _StepWelcome(onStart: _next, onSkip: _finish),
          _StepCategories(
            page: 1,
            total: 2,
            selected: _selCats,
            onToggle: (c) => setState(() {
              if (_selCats.contains(c)) _selCats.remove(c);
              else _selCats.add(c);
            }),
            onBack: _back,
            onNext: _next,
            onClose: _finish,
          ),
          _StepReady(onFinish: _finish),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}

// 
//  ÉTAPE 0 — ACCROCHE ÉMOTIONNELLE (fond sombre, typographie géante)
// 

class _StepWelcome extends StatelessWidget {
  final VoidCallback onStart, onSkip;
  const _StepWelcome({required this.onStart, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fond avec dégradé
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D0D0D), Color(0xFF1A1A2E), Color(0xFF0D0D0D)],
            ),
          ),
        ),

        // Cercle décoratif (orange glow)
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VAColors.primary.withValues(alpha: 0.12),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -40,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VAColors.primary.withValues(alpha: 0.08),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fermer
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: _CloseBtn(onSkip, light: true),
                ),
              ),

              const Spacer(),

              const SizedBox(height: 8),

              // Titre principal — style unique, mixte poids léger + gras
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      height: 1.15,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Vendez ',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text: 'ce que\nvous avez',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: VAColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sous-titre
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  'Des milliers de Béninois transforment leurs affaires en argent chaque jour. À votre tour.',
                  style: TextStyle(
                      fontSize: 15, color: Colors.white.withValues(alpha: 0.65), height: 1.55),
                ),
              ),

              const Spacer(),

              // Stats rapides
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: [
                    _StatPill('50 000+', 'acheteurs'),
                    const SizedBox(width: 10),
                    _StatPill('2 min', 'pour publier'),
                    const SizedBox(width: 10),
                    _StatPill('0 F', "d'inscription"),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // CTA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _PrimaryBtn(
                      label: 'Commencer à vendre →',
                      onTap: onStart,
                      dark: false,
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: onSkip,
                      child: Text(
                        'Peut-être plus tard',
                        style: TextStyle(
                            fontSize: 13, color: Colors.white.withValues(alpha: 0.45)),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  final String value, label;
  const _StatPill(this.value, this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w800, color: VAColors.primary)),
            Text(label,
                style: TextStyle(
                    fontSize: 9, color: Colors.white.withValues(alpha: 0.55), fontWeight: FontWeight.w500)),
          ],
        ),
      );
}

// 
//  ÉTAPE 1 — CATÉGORIES
// 

class _StepCategories extends StatelessWidget {
  final int page, total;
  final Set<AnnonceCategorie> selected;
  final ValueChanged<AnnonceCategorie> onToggle;
  final VoidCallback onBack, onNext, onClose;

  const _StepCategories({
    required this.page, required this.total, required this.selected,
    required this.onToggle, required this.onBack, required this.onNext, required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NavBar(title: 'Mode vendeur', page: page, total: total,
                onBack: onBack, onClose: onClose),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 30, height: 1.2, color: VAColors.black),
                        children: [
                          TextSpan(text: "Qu'est-ce que\nvous ", style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(text: 'vendez ?', style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selected.isEmpty
                          ? 'Une ou plusieurs catégories, c\'est vous qui choisissez.'
                          : '${selected.length} catégorie${selected.length > 1 ? "s" : ""} sélectionnée${selected.length > 1 ? "s" : ""}',
                      style: TextStyle(
                          fontSize: 13,
                          color: selected.isEmpty ? VAColors.greyText : VAColors.primary,
                          fontWeight: selected.isEmpty ? FontWeight.w400 : FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _CascadeCats(
                          selected: selected,
                          onToggle: onToggle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: _PrimaryBtn(
                label: 'Suivant →',
                onTap: selected.isNotEmpty ? onNext : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 
//  ÉTAPE 3 — PRÊT À DÉMARRER (fond orange, excitant)
// 

class _StepReady extends StatelessWidget {
  final VoidCallback onFinish;
  const _StepReady({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dégradé orange
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFF8C00), VAColors.primary, Color(0xFFFFB74D)],
            ),
          ),
        ),

        // Cercles décoratifs
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: -30,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              // Close
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: _CloseBtn(onFinish, light: true, whiteOnOrange: true),
                ),
              ),

              const Spacer(),

              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.storefront_outlined,
                    color: Colors.white, size: 38),
              ),
              const SizedBox(height: 20),

              // Titre — décontracté, chaleureux
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 38, height: 1.15, color: Colors.white),
                    children: [
                      TextSpan(text: 'Vous êtes\n', style: TextStyle(fontWeight: FontWeight.w300)),
                      TextSpan(text: 'prêt(e) !', style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  "Votre boutique n'attend plus que vous.\nPubliez votre première annonce.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.80),
                      height: 1.55),
                ),
              ),

              const SizedBox(height: 36),

              // Avantages
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: const [
                    _BenefitRow(icon: '', text: 'Paiement sécurisé pour chaque vente'),
                    SizedBox(height: 12),
                    _BenefitRow(icon: '', text: 'Livraison intégrée, zéro tracas'),
                    SizedBox(height: 12),
                    _BenefitRow(icon: '', text: '+50 000 acheteurs actifs au Bénin'),
                    SizedBox(height: 12),
                    _BenefitRow(icon: '', text: 'Tableau de bord vendeur complet'),
                  ],
                ),
              ),

              const Spacer(),

              // CTA
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: _PrimaryBtn(
                  label: 'Publier ma première annonce →',
                  onTap: onFinish,
                  dark: true,
                ),
              ),
              GestureDetector(
                onTap: onFinish,
                child: Text(
                  'Configurer ma boutique plus tard',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white.withValues(alpha: 0.65)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String icon, text;
  const _BenefitRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 17))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      );
}

// 
//  CASCADE DE CATÉGORIES — 3 colonnes décalées en cascade diagonale
// 

// Distribution: col1 = [0,3,6], col2 = [1,4,7], col3 = [2,5]
// Décalage vertical:  col1 = 0px, col2 = 28px, col3 = 56px
// → effet cascade de gauche à droite et de haut en bas

class _CascadeCats extends StatelessWidget {
  final Set<AnnonceCategorie> selected;
  final ValueChanged<AnnonceCategorie> onToggle;

  const _CascadeCats({required this.selected, required this.onToggle});

  static const _col1 = [0, 3, 6];
  static const _col2 = [1, 4, 7];
  static const _col3 = [2, 5];

  static const _offsets = [0.0, 28.0, 56.0];

  @override
  Widget build(BuildContext context) {
    final cols = [_col1, _col2, _col3];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int c = 0; c < 3; c++)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: _offsets[c]),
                  for (final idx in cols[c])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _CatBubble(
                        data: _onbCats[idx],
                        isSelected: selected.contains(_onbCats[idx].cat),
                        onTap: () => onToggle(_onbCats[idx].cat),
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

class _CatBubble extends StatelessWidget {
  final ({String emoji, String label, AnnonceCategorie cat}) data;
  final bool isSelected;
  final VoidCallback onTap;

  const _CatBubble({
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  static const _catBgs = {
    AnnonceCategorie.telephones: Color(0xFFD6EBFF),
    AnnonceCategorie.mode:       Color(0xFFFFDDE9),
    AnnonceCategorie.maison:     Color(0xFFD9F2DD),
    AnnonceCategorie.auto:       Color(0xFFFFF0C2),
    AnnonceCategorie.beaute:     Color(0xFFF0DCF9),
    AnnonceCategorie.hightech:   Color(0xFFD4F0FC),
    AnnonceCategorie.sport:      Color(0xFFD6F5E3),
    AnnonceCategorie.livres:     Color(0xFFFFEBCC),
  };

  Color get _bg => _catBgs[data.cat] ?? VAColors.primaryLight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  Bulle ronde 
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: isSelected ? VAColors.primaryLight : _bg,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? VAColors.primary : Colors.transparent,
                width: 3,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: VAColors.primary.withValues(alpha: 0.30),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                data.label.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: VAColors.primaryDark),
              ),
            ),
          ),
          const SizedBox(height: 7),
          //  Label 
          Text(
            data.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? VAColors.primaryDark : VAColors.greyText,
            ),
            textAlign: TextAlign.center,
          ),
          //  Point indicateur de sélection 
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 4),
            width: isSelected ? 6 : 0,
            height: isSelected ? 6 : 0,
            decoration: const BoxDecoration(
              color: VAColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// 
//  COMPOSANTS PARTAGÉS
// 

//  Barre de navigation avec indicateur de progression 

class _NavBar extends StatelessWidget {
  final String title;
  final int page, total;
  final VoidCallback onBack, onClose;

  const _NavBar({
    required this.title, required this.page, required this.total,
    required this.onBack, required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: onBack,
                color: VAColors.black,
              ),
              Expanded(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: onClose,
                color: VAColors.grey,
              ),
            ],
          ),
        ),
        // Barres de progression
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(total, (i) => Expanded(
              child: Container(
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i < page ? VAColors.black : VAColors.greyBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            )),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

//  Bouton fermer 

class _CloseBtn extends StatelessWidget {
  final VoidCallback onTap;
  final bool light;
  final bool whiteOnOrange;
  const _CloseBtn(this.onTap, {this.light = false, this.whiteOnOrange = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: whiteOnOrange
                ? Colors.white.withValues(alpha: 0.20)
                : (light
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFFF0F0F0)),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close_rounded,
              size: 17, color: light ? Colors.white : VAColors.greyText),
        ),
      );
}

//  Bouton principal 

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool dark;

  const _PrimaryBtn({required this.label, required this.onTap, this.dark = false});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: dark
              ? VAColors.cardBlack
              : (enabled ? VAColors.primary : VAColors.greyBorder),
          borderRadius: BorderRadius.circular(16),
          boxShadow: enabled && !dark
              ? [BoxShadow(color: VAColors.primary.withValues(alpha: 0.35),
                  blurRadius: 12, offset: const Offset(0, 5))]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: enabled ? Colors.white : VAColors.grey,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
