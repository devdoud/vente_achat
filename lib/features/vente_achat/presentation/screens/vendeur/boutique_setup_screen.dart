import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/va_theme.dart';
import 'boutique_atelier_screen.dart';

const _kBoutiqueSetupDone = 'boutique_setup_done';
const _kBoutiqueName      = 'boutique_name';
const _kBoutiqueEmoji     = 'boutique_emoji';
const _kBoutiqueVille     = 'boutique_ville';
const _kBoutiqueQuartier  = 'boutique_quartier';
const _kBoutiqueAdresse   = 'boutique_adresse';

// ─── Villes béninoises ────────────────────────────────────────────────────────
const _villes = [
  'Cotonou', 'Abomey-Calavi', 'Porto-Novo',
  'Parakou', 'Bohicon', 'Lokossa', 'Ouidah', 'Natitingou',
];

// ─── Emojis ───────────────────────────────────────────────────────────────────
const _logos = ['🛍', '📱', '👜', '🏠', '💄', '🖥', '⚽', '📚'];

// ═══════════════════════════════════════════════════════════════════════════
//  ÉCRAN PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════

class BoutiqueSetupScreen extends StatefulWidget {
  const BoutiqueSetupScreen({super.key});

  @override
  State<BoutiqueSetupScreen> createState() => _BoutiqueSetupState();
}

class _BoutiqueSetupState extends State<BoutiqueSetupScreen> {
  int    _step     = 0;
  String _nom      = '';
  String _emoji    = '🛍';
  String _ville    = 'Cotonou';
  String _quartier = '';
  String _adresse  = '';

  void _toStep(int s) => setState(() => _step = s);

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBoutiqueSetupDone, true);
    await prefs.setString(_kBoutiqueName,    _nom);
    await prefs.setString(_kBoutiqueEmoji,   _emoji);
    await prefs.setString(_kBoutiqueVille,   _ville);
    await prefs.setString(_kBoutiqueQuartier, _quartier);
    await prefs.setString(_kBoutiqueAdresse,  _adresse);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BoutiqueAtelierScreen(
          nom: _nom, emoji: _emoji,
          ville: _ville, quartier: _quartier,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 340),
      switchInCurve:  Curves.easeOutCubic,
      switchOutCurve: Curves.easeInQuart,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween(begin: const Offset(0.04, 0), end: Offset.zero)
              .animate(anim),
          child: child,
        ),
      ),
      child: switch (_step) {
        0 => _StepIdentite(
            key: const ValueKey(0),
            onNext: (nom, emoji) {
              setState(() { _nom = nom; _emoji = emoji; });
              _toStep(1);
            },
          ),
        1 => _StepLieu(
            key: const ValueKey(1),
            ville: _ville,
            onBack: () => _toStep(0),
            onNext: (ville, quartier, adresse) {
              setState(() {
                _ville    = ville;
                _quartier = quartier;
                _adresse  = adresse;
              });
              _toStep(2);
            },
          ),
        _ => _StepPret(
            key: const ValueKey(2),
            nom:     _nom,
            emoji:   _emoji,
            ville:   _ville,
            quartier: _quartier,
            onFinish: _finish,
          ),
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  ÉTAPE 1 — IDENTITÉ BOUTIQUE
// ═══════════════════════════════════════════════════════════════════════════

class _StepIdentite extends StatefulWidget {
  final void Function(String nom, String emoji) onNext;
  const _StepIdentite({super.key, required this.onNext});

  @override
  State<_StepIdentite> createState() => _StepIdentiteState();
}

class _StepIdentiteState extends State<_StepIdentite> {
  final _nomCtrl = TextEditingController();
  String _emoji  = '';
  bool   get _ok => _nomCtrl.text.trim().length > 1 && _emoji.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nomCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() { _nomCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Progress ────────────────────────────────────────────────
            _SetupHeader(step: 1, onBack: () => Navigator.of(context).pop()),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontFamily: 'Poppins',
                            fontSize: 28, height: 1.2, color: VAColors.black),
                        children: [
                          TextSpan(text: 'Créons votre\n',
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(text: 'boutique.',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Choisissez un nom et une icône qui vous ressemblent.',
                      style: TextStyle(fontSize: 13, color: VAColors.greyText, height: 1.5),
                    ),
                    const SizedBox(height: 28),

                    // Champ nom
                    _Label('Nom de la boutique'),
                    const SizedBox(height: 8),
                    _InputCard(
                      child: TextField(
                        controller: _nomCtrl,
                        autofocus: true,
                        maxLength: 30,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ex : Adjoa Store, Tech Bénin…',
                          hintStyle: TextStyle(color: VAColors.grey, fontSize: 15),
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600,
                            color: VAColors.black),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Icône
                    _Label('Icône de votre boutique'),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: _logos.length,
                      itemBuilder: (_, i) {
                        final e = _logos[i];
                        final sel = _emoji == e;
                        return GestureDetector(
                          onTap: () => setState(() => _emoji = e),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: sel ? VAColors.primaryLight : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: sel ? VAColors.primary : VAColors.greyBorder,
                                width: sel ? 2 : 1,
                              ),
                              boxShadow: sel
                                  ? [BoxShadow(
                                      color: VAColors.primary.withValues(alpha: 0.18),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4))]
                                  : [const BoxShadow(
                                      color: Color(0x08000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2))],
                            ),
                            child: Center(
                              child: Text(e,
                                  style: TextStyle(
                                      fontSize: sel ? 32 : 28)),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // CTA
            _SetupCTA(
              label: 'Continuer →',
              enabled: _ok,
              onTap: () => widget.onNext(_nomCtrl.text.trim(), _emoji),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  ÉTAPE 2 — LIEU DE RETRAIT
// ═══════════════════════════════════════════════════════════════════════════

class _StepLieu extends StatefulWidget {
  final String ville;
  final VoidCallback onBack;
  final void Function(String ville, String quartier, String adresse) onNext;
  const _StepLieu({
    super.key,
    required this.ville,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<_StepLieu> createState() => _StepLieuState();
}

class _StepLieuState extends State<_StepLieu> {
  late String _ville;
  final _quartierCtrl = TextEditingController();
  final _adresseCtrl  = TextEditingController();

  bool get _ok => _quartierCtrl.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ville = widget.ville;
    _quartierCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _quartierCtrl.dispose();
    _adresseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: SafeArea(
        child: Column(
          children: [
            // Progress
            _SetupHeader(step: 2, onBack: widget.onBack),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontFamily: 'Poppins',
                            fontSize: 28, height: 1.2, color: VAColors.black),
                        children: [
                          TextSpan(text: 'Où récupère-t-on\n',
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(text: 'vos colis ?',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Les acheteurs et livreurs ont besoin de savoir où vous trouver.',
                      style: TextStyle(fontSize: 13, color: VAColors.greyText, height: 1.5),
                    ),
                    const SizedBox(height: 28),

                    // Carte info offre sûre
                    _InfoCard(
                      icon: '🔒',
                      text: 'Avec l\'Offre sûre, les livreurs récupèrent vos articles directement chez vous.',
                    ),
                    const SizedBox(height: 24),

                    // Ville
                    _Label('Votre ville'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _villes.map((v) {
                        final sel = _ville == v;
                        return GestureDetector(
                          onTap: () => setState(() => _ville = v),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: sel ? VAColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: sel ? VAColors.primary : VAColors.greyBorder,
                              ),
                              boxShadow: sel
                                  ? [BoxShadow(
                                      color: VAColors.primary.withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3))]
                                  : null,
                            ),
                            child: Text(v,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: sel ? Colors.white : VAColors.greyText)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 22),

                    // Quartier
                    _Label('Quartier / Zone *'),
                    const SizedBox(height: 8),
                    _InputCard(
                      child: TextField(
                        controller: _quartierCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ex : Cadjehoun, Akpakpa, Haie Vive…',
                          hintStyle: TextStyle(color: VAColors.grey, fontSize: 14),
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: VAColors.black),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Adresse précise
                    _Label('Adresse précise (optionnel)'),
                    const SizedBox(height: 8),
                    _InputCard(
                      child: TextField(
                        controller: _adresseCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ex : Rue des Bâtisseurs, immeuble Kola…',
                          hintStyle: TextStyle(color: VAColors.grey, fontSize: 14),
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: VAColors.black),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // CTA
            _SetupCTA(
              label: 'Continuer →',
              enabled: _ok,
              onTap: () => widget.onNext(
                  _ville, _quartierCtrl.text.trim(), _adresseCtrl.text.trim()),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  ÉTAPE 3 — PRÊT
// ═══════════════════════════════════════════════════════════════════════════

class _StepPret extends StatefulWidget {
  final String nom, emoji, ville, quartier;
  final Future<void> Function() onFinish;
  const _StepPret({
    super.key,
    required this.nom, required this.emoji,
    required this.ville, required this.quartier,
    required this.onFinish,
  });

  @override
  State<_StepPret> createState() => _StepPretState();
}

class _StepPretState extends State<_StepPret>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>  _scale;
  late Animation<double>  _fade;
  late Animation<Offset>  _slide;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 650));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _slide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: SafeArea(
        child: Column(
          children: [
            _SetupHeader(step: 3, showBack: false),

            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FadeTransition(
                    opacity: _fade,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icône succès
                        Text(widget.emoji,
                            style: const TextStyle(fontSize: 64)),
                        const SizedBox(height: 20),

                        // Titre
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontFamily: 'Poppins',
                                fontSize: 30, height: 1.2, color: VAColors.black),
                            children: [
                              TextSpan(text: 'Votre boutique\n',
                                  style: TextStyle(fontWeight: FontWeight.w300)),
                              TextSpan(text: 'est prête !',
                                  style: TextStyle(fontWeight: FontWeight.w800,
                                      color: VAColors.primaryDark)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Carte boutique
                        SlideTransition(
                          position: _slide,
                          child: ScaleTransition(
                            scale: _scale,
                            child: _RecapCard(
                              nom:      widget.nom,
                              emoji:    widget.emoji,
                              ville:    widget.ville,
                              quartier: widget.quartier,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // CTAs
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: GestureDetector(
                onTap: widget.onFinish,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(
                      color: VAColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14, offset: const Offset(0, 5),
                    )],
                  ),
                  child: const Text('Publier mon premier produit →',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,
                          fontSize: 15, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GestureDetector(
                onTap: widget.onFinish,
                child: const Text('Personnaliser plus tard',
                    style: TextStyle(fontSize: 13, color: VAColors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Carte récap boutique ─────────────────────────────────────────────────────

class _RecapCard extends StatelessWidget {
  final String nom, emoji, ville, quartier;
  const _RecapCard({
    required this.nom, required this.emoji,
    required this.ville, required this.quartier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.07),
          blurRadius: 24, offset: const Offset(0, 10),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + nom
          Row(
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(child: Text(emoji,
                    style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nom,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: VAColors.black),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: VAColors.greenLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('OUVERTE',
                          style: TextStyle(color: VAColors.green,
                              fontSize: 9, fontWeight: FontWeight.w800,
                              letterSpacing: 0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (quartier.isNotEmpty) ...[
            const Divider(height: 20, color: VAColors.greyBorder),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: VAColors.primary),
                const SizedBox(width: 6),
                Text(
                  '$quartier, $ville',
                  style: const TextStyle(fontSize: 13,
                      fontWeight: FontWeight.w500, color: VAColors.greyText),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  COMPOSANTS PARTAGÉS
// ═══════════════════════════════════════════════════════════════════════════

// ── Header avec progress et retour ───────────────────────────────────────────

class _SetupHeader extends StatelessWidget {
  final int step;
  final VoidCallback? onBack;
  final bool showBack;
  const _SetupHeader({required this.step, this.onBack, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F3EF),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Color(0x0E000000), blurRadius: 6)
                        ]),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 15, color: VAColors.black),
                  ),
                )
              else
                const SizedBox(width: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Étape $step sur 3',
                      style: const TextStyle(
                          fontSize: 11, color: VAColors.primary,
                          fontWeight: FontWeight.w700, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 6),
                    // Barres de progression
                    Row(
                      children: List.generate(3, (i) => Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 3.5,
                          margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                          decoration: BoxDecoration(
                            color: i < step
                                ? VAColors.primary
                                : VAColors.greyBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 36), // balance
            ],
          ),
        ],
      ),
    );
  }
}

// ── Bouton principal ──────────────────────────────────────────────────────────

class _SetupCTA extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  const _SetupCTA({required this.label, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: enabled ? VAColors.primary : VAColors.greyBorder,
              borderRadius: BorderRadius.circular(14),
              boxShadow: enabled
                  ? [BoxShadow(
                      color: VAColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5))]
                  : null,
            ),
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: enabled ? Colors.white : VAColors.grey)),
          ),
        ),
      );
}

// ── Label de champ ────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black));
}

// ── Carte d'input (fond blanc, arrondis) ──────────────────────────────────────

class _InputCard extends StatelessWidget {
  final Widget child;
  const _InputCard({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: child,
      );
}

// ── Carte info ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final String icon, text;
  const _InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VAColors.primaryLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: VAColors.primaryLight),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 12, color: VAColors.primaryDark, height: 1.45)),
            ),
          ],
        ),
      );
}
