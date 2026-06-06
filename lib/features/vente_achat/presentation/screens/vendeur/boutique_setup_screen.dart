import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../../logic/export.dart';
import 'boutique_atelier_screen.dart';
import 'creation_widgets.dart';

const _kBoutiqueSetupDone = 'boutique_setup_done';
const _kBoutiqueName      = 'boutique_name';
// _kBoutiqueEmoji conservé pour rétrocompatibilité avec les prefs existantes
const _kBoutiqueVille     = 'boutique_ville';
const _kBoutiqueQuartier  = 'boutique_quartier';
const _kBoutiqueAdresse   = 'boutique_adresse';
const _kBoutiqueShopUuid  = 'boutique_shop_uuid';

//  Villes béninoises 
const _villes = [
  'Cotonou', 'Abomey-Calavi', 'Porto-Novo',
  'Parakou', 'Bohicon', 'Lokossa', 'Ouidah', 'Natitingou',
];

//  Icônes boutique avec palette de couleurs 
const _logos = [
  (e: '',  l: 'Boutique',   bg: Color(0xFFFFF3E0), ring: Color(0xFFFF6D00)),
  (e: '',  l: 'Téléphones', bg: Color(0xFFE3F2FD), ring: Color(0xFF1976D2)),
  (e: '',  l: 'Mode',       bg: Color(0xFFFCE4EC), ring: Color(0xFFE91E63)),
  (e: '',  l: 'Maison',     bg: Color(0xFFE8F5E9), ring: Color(0xFF388E3C)),
  (e: '',  l: 'Beauté',     bg: Color(0xFFF3E5F5), ring: Color(0xFF8E24AA)),
  (e: '',  l: 'High-tech',  bg: Color(0xFFE8EAF6), ring: Color(0xFF3949AB)),
  (e: '',  l: 'Sport',      bg: Color(0xFFF1F8E9), ring: Color(0xFF558B2F)),
  (e: '',  l: 'Livres',     bg: Color(0xFFFFF8E1), ring: Color(0xFFF57F17)),
];

// 
//  ÉCRAN PRINCIPAL
// 

class BoutiqueSetupScreen extends StatefulWidget {
  const BoutiqueSetupScreen({super.key});

  @override
  State<BoutiqueSetupScreen> createState() => _BoutiqueSetupState();
}

class _BoutiqueSetupState extends State<BoutiqueSetupScreen> {
  int    _step = 0;
  String _nom  = '';
  String _ville    = 'Cotonou';
  String _quartier = '';
  String _adresse  = '';

  late final ShopCubit _shopCubit;

  void _toStep(int s) => setState(() => _step = s);

  @override
  void initState() {
    super.initState();
    _shopCubit = getIt<ShopCubit>();
  }

  @override
  void dispose() {
    _shopCubit.close();
    super.dispose();
  }

  Future<void> _finish() async {
    // Accès direct au cubit via la variable d'instance (pas via context.read)
    _shopCubit.createShop(
      name:        _nom,
      description: _quartier.isNotEmpty ? '$_quartier, $_ville' : _ville,
    );
  }

  Future<void> _onShopCreated(String shopUuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBoutiqueSetupDone, true);
    await prefs.setString(_kBoutiqueName,     _nom);
    await prefs.setString(_kBoutiqueVille,    _ville);
    await prefs.setString(_kBoutiqueQuartier, _quartier);
    await prefs.setString(_kBoutiqueAdresse,  _adresse);
    await prefs.setString(_kBoutiqueShopUuid, shopUuid);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BoutiqueAtelierScreen(
          nom: _nom, ville: _ville, quartier: _quartier,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _shopCubit,
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (ctx, state) {
          if (state is ShopCreated) {
            _onShopCreated(state.shopUuid);
          } else if (state is ShopFailure) {
            ScaffoldMessenger.of(ctx)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(state.failure.toMsg,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                backgroundColor: VAColors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              ));
          }
        },
        builder: (ctx, shopState) => AnimatedSwitcher(
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
              setState(() { _nom = nom; });
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
        2 => _StepRCCM(
            key: const ValueKey(2),
            onBack: () => _toStep(1),
            onNext: (_) => _toStep(3),
          ),
        _ => _StepPret(
            key: const ValueKey(3),
            nom:      _nom,
            ville:    _ville,
            quartier: _quartier,
            onFinish: _finish,
            isLoading: shopState is ShopLoading,
          ),
      },
        ), // AnimatedSwitcher
      ),   // BlocConsumer
    );     // BlocProvider
  }
}

// 
//  ÉTAPE 1 — IDENTITÉ BOUTIQUE
// 

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //  Progress 
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
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: _logos.length,
                      itemBuilder: (_, i) {
                        final item = _logos[i];
                        final sel = _emoji == item.l;
                        return GestureDetector(
                          onTap: () => setState(() => _emoji = item.l),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: sel ? item.bg : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: sel ? item.ring : const Color(0xFFEEEEEE),
                                    width: sel ? 2.5 : 1.5,
                                  ),
                                  boxShadow: sel
                                      ? [BoxShadow(
                                          color: item.ring.withValues(alpha: 0.22),
                                          blurRadius: 14,
                                          offset: const Offset(0, 5))]
                                      : [const BoxShadow(
                                          color: Color(0x0A000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 2))],
                                ),
                                child: Center(
                                  child: AnimatedScale(
                                    scale: sel ? 1.18 : 1.0,
                                    duration: const Duration(milliseconds: 220),
                                    child: Text(
                                      item.l.substring(0, 1),
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: sel ? item.ring : VAColors.greyText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: sel
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: sel ? item.ring : VAColors.greyText,
                                ),
                                child: Text(item.l, textAlign: TextAlign.center),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(top: 3),
                                width: sel ? 5 : 0,
                                height: sel ? 5 : 0,
                                decoration: BoxDecoration(
                                  color: item.ring,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
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

// 
//  ÉTAPE 2 — LIEU DE RETRAIT
// 

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
      backgroundColor: Colors.white,
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
                      icon: '',
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

// 
//  ÉTAPE 3 — PRÊT
// 

class _StepPret extends StatefulWidget {
  final String nom, ville, quartier;
  final Future<void> Function() onFinish;
  final bool isLoading;
  const _StepPret({
    super.key,
    required this.nom,
    required this.ville, required this.quartier,
    required this.onFinish,
    this.isLoading = false,
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
  bool _cgv = false;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _SetupHeader(step: 4, total: 4, showBack: false),

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
                        Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            color: VAColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.storefront_outlined,
                              size: 36, color: VAColors.primaryDark),
                        ),
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

            //  CGV 
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: GestureDetector(
                onTap: () => setState(() => _cgv = !_cgv),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _cgv ? VAColors.primary : const Color(0xFFEEEEEE),
                      width: _cgv ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 22, height: 22,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: _cgv ? VAColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _cgv ? VAColors.primary : VAColors.greyBorder,
                            width: 1.5,
                          ),
                          boxShadow: _cgv ? [BoxShadow(
                            color: VAColors.primary.withValues(alpha: 0.22),
                            blurRadius: 6,
                          )] : null,
                        ),
                        child: _cgv
                            ? const Icon(Icons.check_rounded,
                                size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'J\'accepte les conditions générales de vente',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: VAColors.black,
                                  height: 1.4),
                            ),
                            const SizedBox(height: 3),
                            GestureDetector(
                              onTap: () {},
                              child: const Text('Lire les conditions →',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: VAColors.primary,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CTA principal
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: GestureDetector(
                onTap: (_cgv && !widget.isLoading) ? widget.onFinish : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: (_cgv && !widget.isLoading)
                        ? VAColors.primary : VAColors.greyBorder,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: (_cgv && !widget.isLoading) ? [BoxShadow(
                      color: VAColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14, offset: const Offset(0, 5),
                    )] : null,
                  ),
                  child: widget.isLoading
                      ? const Center(child: SizedBox(
                          width: 20, height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.5, color: Colors.white)))
                      : Text(
                          'Publier mon premier produit →',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _cgv ? Colors.white : VAColors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GestureDetector(
                onTap: widget.isLoading ? null : widget.onFinish,
                child: Text('Personnaliser plus tard',
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.isLoading ? VAColors.greyBorder : VAColors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  Carte récap boutique 

class _RecapCard extends StatelessWidget {
  final String nom, ville, quartier;
  const _RecapCard({
    required this.nom,
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
                child: const Center(child: Icon(Icons.storefront_outlined,
                    size: 26, color: VAColors.primaryDark)),
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

// 
//  ÉTAPE 3 — JUSTIFICATIF PROFESSIONNEL (RCCM)
// 

class _StepRCCM extends StatefulWidget {
  final VoidCallback onBack;
  final void Function(XFile? rccm) onNext;
  const _StepRCCM({super.key, required this.onBack, required this.onNext});

  @override
  State<_StepRCCM> createState() => _StepRCCMState();
}

class _StepRCCMState extends State<_StepRCCM> {
  XFile? _rccm;
  final _picker = ImagePicker();

  Future<void> _pick() async {
    final file = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1920, imageQuality: 90);
    if (file != null && mounted) setState(() => _rccm = file);
  }

  Future<void> _pickFromCamera() async {
    final file = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 1920, imageQuality: 90);
    if (file != null && mounted) setState(() => _rccm = file);
  }

  void _showSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFE0DDD8),
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 18),
            const Text('Ajouter le RCCM',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('Document ou photo du registre',
                style: TextStyle(fontSize: 12, color: VAColors.greyText)),
            const SizedBox(height: 16),
            _RCCMSheetOption(
              icon: Icons.camera_alt_outlined,
              color: VAColors.primary,
              label: 'Photographier le document',
              sub: 'Utiliser l\'appareil photo',
              onTap: () { Navigator.pop(ctx); _pickFromCamera(); },
            ),
            Divider(height: 1, indent: 66, color: Colors.grey.shade100),
            _RCCMSheetOption(
              icon: Icons.photo_library_outlined,
              color: const Color(0xFF6B7FD4),
              label: 'Choisir depuis la galerie',
              sub: 'Scan ou photo existante',
              onTap: () { Navigator.pop(ctx); _pick(); },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _SetupHeader(step: 3, total: 4, onBack: widget.onBack),

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
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            height: 1.2,
                            color: VAColors.black),
                        children: [
                          TextSpan(
                              text: 'Justificatif\n',
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(
                              text: 'professionnel',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Registre du Commerce et du Crédit Mobilier (RCCM)',
                      style: TextStyle(
                          fontSize: 13,
                          color: VAColors.greyText,
                          height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    // Info carte
                    _InfoCard(
                      icon: '',
                      text:
                          'Les boutiques vérifiées bénéficient d\'un badge de confiance visible par tous les acheteurs sur chaque annonce.',
                    ),
                    const SizedBox(height: 24),

                    // Zone upload
                    _rccm == null
                        ? GestureDetector(
                            onTap: _showSheet,
                            child: DashedBorder(
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 46, height: 46,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8EAF6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                          Icons.badge_outlined,
                                          size: 22,
                                          color: Color(0xFF3949AB)),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Ajouter votre RCCM',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: VAColors.black),
                                    ),
                                    const SizedBox(height: 3),
                                    const Text(
                                      'Photo ou scan du document',
                                      style: TextStyle(
                                          fontSize: 11, color: VAColors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  File(_rccm!.path),
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 8, left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3949AB),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.verified_outlined,
                                          size: 12, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text('RCCM ajouté',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8, right: 8,
                                child: GestureDetector(
                                  onTap: () => setState(() => _rccm = null),
                                  child: Container(
                                    width: 28, height: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.black
                                            .withValues(alpha: 0.55),
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),

                    const SizedBox(height: 16),

                    // Note "pas encore de RCCM"
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EDE8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              size: 15, color: VAColors.greyText),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Vous pouvez ajouter votre RCCM plus tard depuis les paramètres de votre boutique.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: VAColors.greyText,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            _SetupCTA(
              label: _rccm != null
                  ? 'Continuer →'
                  : 'Passer cette étape →',
              enabled: true,
              onTap: () => widget.onNext(_rccm),
            ),
          ],
        ),
      ),
    );
  }
}

class _RCCMSheetOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, sub;
  final VoidCallback onTap;
  const _RCCMSheetOption(
      {required this.icon,
      required this.color,
      required this.label,
      required this.sub,
      required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(sub,
                        style: const TextStyle(
                            fontSize: 12, color: VAColors.greyText)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

// 
//  COMPOSANTS PARTAGÉS
// 

//  Header avec progress et retour 

class _SetupHeader extends StatelessWidget {
  final int step;
  final int total;
  final VoidCallback? onBack;
  final bool showBack;
  const _SetupHeader(
      {required this.step,
      this.total = 4,
      this.onBack,
      this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
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
                  'Étape $step sur $total',
                  style: const TextStyle(
                      fontSize: 11,
                      color: VAColors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(
                    total,
                    (i) => Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 3.5,
                        margin:
                            EdgeInsets.only(right: i < total - 1 ? 4 : 0),
                        decoration: BoxDecoration(
                          color: i < step
                              ? VAColors.primary
                              : VAColors.greyBorder,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

//  Bouton principal 

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

//  Label de champ 

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black));
}

//  Carte d'input (fond blanc, arrondis) 

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

//  Carte info 

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
