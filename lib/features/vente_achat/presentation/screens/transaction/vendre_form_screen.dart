import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/injection/injection.dart';
import '../../theme/va_theme.dart';
import '../../utils/cat_helpers.dart';
import '../vendeur/creation_widgets.dart';
import '../vendeur/justificatif_screen.dart';
import '../../../domain/export.dart';
import '../../../domain/models/product_creation_data.dart';
import '../../../logic/export.dart';

@RoutePage()
class VendreFormScreen extends StatefulWidget {
  final List<XFile> photos;
  const VendreFormScreen({super.key, required this.photos});

  @override
  State<VendreFormScreen> createState() => _VendreFormScreenState();
}

class _VendreFormScreenState extends State<VendreFormScreen> {
  late final CategoryCubit _categoryCubit;

  Category?               _selectedCat;
  int                     _selectedEtatIdx = 0;
  List<CategoryFeature>   _features        = [];
  Map<String, dynamic>    _featureValues   = {};
  // Cache local des catégories — évite de les perdre quand le cubit
  // passe en état featuresLoading/featuresLoaded après sélection
  List<Category>          _cachedCats      = [];
  String                  _shopUuid        = '';

  final _titreCtrl = TextEditingController();
  final _prixCtrl  = TextEditingController();
  final _stockCtrl = TextEditingController(text: '1');
  final _locCtrl   = TextEditingController();
  final _descCtrl  = TextEditingController();

  static const _etats = ['Neuf', 'Comme neuf', 'Bon état', 'Correct'];

  bool get _canContinue =>
      _titreCtrl.text.trim().isNotEmpty &&
      _prixCtrl.text.trim().isNotEmpty &&
      _selectedCat != null;

  @override
  void initState() {
    super.initState();
    _categoryCubit = getIt<CategoryCubit>()..load();
    _titreCtrl.addListener(() => setState(() {}));
    _prixCtrl.addListener(() => setState(() {}));
    _loadShopUuid();
  }

  /// Résolution du shopUuid par ordre de priorité :
  /// 1. UUID de la boutique créée dans l'app (SharedPrefs) — le plus fiable
  /// 2. UUID depuis le profil API (user.shopUuid)
  /// 3. Vide → snackBar "créer votre boutique d'abord"
  Future<void> _loadShopUuid() async {
    // Priorité 1 : boutique créée localement (plus récent et spécifique)
    final prefs = await SharedPreferences.getInstance();
    final fromPrefs = prefs.getString('boutique_shop_uuid') ?? '';
    if (fromPrefs.isNotEmpty) {
      if (mounted) setState(() => _shopUuid = fromPrefs);
      return;
    }

    // Priorité 2 : UUID depuis le profil utilisateur (API)
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      final fromAuth = authState.user.shopUuid ?? '';
      if (fromAuth.isNotEmpty) {
        if (mounted) setState(() => _shopUuid = fromAuth);
        return;
      }
    }

    // Pas de boutique
    if (mounted) setState(() => _shopUuid = '');
  }

  @override
  void dispose() {
    _categoryCubit.close();
    _titreCtrl.dispose();
    _prixCtrl.dispose();
    _stockCtrl.dispose();
    _locCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_shopUuid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vous devez d\'abord créer votre boutique pour publier une annonce.',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final cat  = _selectedCat!;
    final prix = int.tryParse(_prixCtrl.text.replaceAll(RegExp(r'\D'), '')) ?? 0;

    final stock = int.tryParse(_stockCtrl.text.replaceAll(RegExp(r'\D'), '')) ?? 1;
    final data = ProductCreationData(
      photos:       widget.photos,
      name:         _titreCtrl.text.trim(),
      price:        prix,
      description:  _descCtrl.text.trim(),
      categoryUuid: cat.uuid,
      categoryName: cat.name,
      location:     _locCtrl.text.trim(),
      condition:    _etats[_selectedEtatIdx],
      shopUuid:     _shopUuid,
      features:     _featureValues.isEmpty ? null : Map.from(_featureValues),
      stock:        stock.clamp(1, 9999),
    );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => JustificatifScreen(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _categoryCubit,
      child: BlocListener<CategoryCubit, CategoryState>(
        listener: (ctx, state) {
          if (state is CategoryFeaturesLoaded &&
              state.categoryUuid == _selectedCat?.uuid) {
            setState(() {
              _features      = state.features
                  .where((f) => !f.isBoolean)
                  .toList()
                ..sort((a, b) => a.position.compareTo(b.position));
              _featureValues = {};
            });
          }
        },
        child: Scaffold(
        backgroundColor: Colors.white,
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
              CreationStepBar(current: 2, total: 3),
              const SizedBox(height: 20),

              const Text('ÉTAPE 2 SUR 3',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700,
                      letterSpacing: 1.2, color: VAColors.primary)),
              const SizedBox(height: 6),

              RichText(
                text: const TextSpan(
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 26,
                      height: 1.2, color: VAColors.black),
                  children: [
                    TextSpan(text: 'Décrivez votre\n',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                    TextSpan(text: 'produit',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Titre
                    _FormField(
                      label: 'Titre',
                      required: true,
                      child: _TextInput(
                        controller: _titreCtrl,
                        hint: 'Ex : iPhone 13 Pro 128Go',
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const _Divider(),

                    // Catégorie — chargée depuis l'API
                    _FormField(
                      label: 'Catégorie',
                      required: true,
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (ctx, state) {
                          // Met à jour le cache local quand les catégories sont chargées
                          if (state is CategoryLoaded && state.categories.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted && _cachedCats.isEmpty) {
                                setState(() => _cachedCats = state.categories);
                              }
                            });
                          }

                          if (state is CategoryLoading || state is CategoryInitial) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: SizedBox(
                                  width: 20, height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: VAColors.primary),
                                ),
                              ),
                            );
                          }

                          // Utilise le cache pour ne pas perdre les chips
                          // quand on passe en état featuresLoading/featuresLoaded
                          final cats = state is CategoryLoaded
                              ? state.categories
                              : _cachedCats;

                          if (cats.isEmpty) {
                            return const Text('Aucune catégorie disponible',
                                style: TextStyle(fontSize: 12, color: VAColors.grey));
                          }
                          return _ApiCatChips(
                            categories: cats,
                            selected: _selectedCat,
                            onSelect: (cat) {
                              setState(() {
                                _selectedCat   = cat;
                                _features      = [];
                                _featureValues = {};
                              });
                              _categoryCubit.loadFeatures(cat.uuid);
                            },
                          );
                        },
                      ),
                    ),
                    const _Divider(),

                    // État
                    _FormField(
                      label: 'État',
                      required: true,
                      child: _EtatChips(
                        items: _etats,
                        selected: _selectedEtatIdx,
                        onSelect: (i) => setState(() => _selectedEtatIdx = i),
                      ),
                    ),
                    const _Divider(),

                    // Features dynamiques selon la catégorie sélectionnée
                    if (_features.isNotEmpty) ...[
                      for (final feature in _features) ...[
                        _FeatureField(
                          feature: feature,
                          value:   _featureValues[feature.code],
                          onChanged: (val) => setState(() =>
                              _featureValues[feature.code] = val),
                        ),
                        const _Divider(),
                      ],
                    ] else if (_selectedCat != null &&
                        (_categoryCubit.state is CategoryFeaturesLoading)) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: VAColors.primary),
                        )),
                      ),
                      const _Divider(),
                    ],

                    // Prix
                    _FormField(
                      label: 'Prix',
                      required: true,
                      child: _TextInput(
                        controller: _prixCtrl,
                        hint: '0',
                        suffix: 'FCFA',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const _Divider(),

                    // Stock disponible
                    _FormField(
                      label: 'Stock disponible',
                      required: true,
                      child: _TextInput(
                        controller: _stockCtrl,
                        hint: '1',
                        suffix: 'unité(s)',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const _Divider(),

                    // Localisation
                    _FormField(
                      label: 'Localisation',
                      required: false,
                      child: _TextInput(
                        controller: _locCtrl,
                        hint: 'Votre ville ou quartier',
                        suffixIcon: Icons.location_on_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const _Divider(),

                    // Description
                    _FormField(
                      label: 'Description',
                      required: false,
                      child: TextField(
                        controller: _descCtrl,
                        maxLines: 4,
                        maxLength: 500,
                        decoration: const InputDecoration(
                          hintText:
                              'Décrivez votre produit : état, accessoires inclus, raison de vente...',
                          hintStyle: TextStyle(
                              color: VAColors.grey, fontSize: 13, height: 1.5),
                          border: InputBorder.none,
                          counterStyle:
                              TextStyle(fontSize: 11, color: VAColors.grey),
                        ),
                        style: const TextStyle(
                            fontSize: 14, color: VAColors.black, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: CreationBottomBar(
          onBack: () => Navigator.of(context).pop(),
          onNext: _canContinue ? _goNext : null,
          canContinue: _canContinue,
        ),
      ),    // Scaffold
        ),  // BlocListener
    );      // BlocProvider
  }
}

// ─── Chips catégories API ─────────────────────────────────────────────────────

class _ApiCatChips extends StatelessWidget {
  final List<Category> categories;
  final Category?      selected;
  final ValueChanged<Category> onSelect;
  const _ApiCatChips({
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSel = selected?.uuid == cat.uuid;
        final en    = _guessEnum(cat.name);
        final bg    = catBg(en);
        final ic    = catIcon(en);
        return GestureDetector(
          onTap: () => onSelect(cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: isSel ? VAColors.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSel ? VAColors.primary : VAColors.greyBorder,
                width: isSel ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(ic, size: 12,
                        color: bg
                            .withRed((bg.r * 0.5).toInt())
                            .withGreen((bg.g * 0.5).toInt())
                            .withBlue((bg.b * 0.5).toInt())),
                  ),
                ),
                const SizedBox(width: 6),
                Text(cat.name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSel ? VAColors.primaryDark : VAColors.greyText)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  static AnnonceCategorie _guessEnum(String name) {
    final n = name.toLowerCase();
    if (n.contains('télé') || n.contains('phone') || n.contains('mobile')) return AnnonceCategorie.telephones;
    if (n.contains('mode') || n.contains('vêt') || n.contains('habit'))    return AnnonceCategorie.mode;
    if (n.contains('maison') || n.contains('meuble'))                       return AnnonceCategorie.maison;
    if (n.contains('auto') || n.contains('moto') || n.contains('voiture'))  return AnnonceCategorie.auto;
    if (n.contains('beauté') || n.contains('cosm'))                         return AnnonceCategorie.beaute;
    if (n.contains('tech') || n.contains('info') || n.contains('high'))     return AnnonceCategorie.hightech;
    if (n.contains('sport') || n.contains('loisir'))                        return AnnonceCategorie.sport;
    if (n.contains('livre') || n.contains('book'))                          return AnnonceCategorie.livres;
    return AnnonceCategorie.telephones;
  }
}

// ─── Composants ───────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  final String label;
  final bool required;
  final Widget child;
  const _FormField({required this.label, required this.child, this.required = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
          if (required)
            const Text('*',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.primary)),
        ]),
        const SizedBox(height: 6),
        child,
        const SizedBox(height: 10),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: VAColors.greyBorder);
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? suffix;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  const _TextInput({
    required this.controller,
    required this.hint,
    this.suffix,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
        border: InputBorder.none,
        suffixText: suffix,
        suffixStyle: const TextStyle(
            color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 14),
        suffixIcon:
            suffixIcon != null ? Icon(suffixIcon, size: 18, color: VAColors.grey) : null,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: VAColors.black),
    );
  }
}

class _EtatChips extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;
  const _EtatChips({required this.items, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: List.generate(items.length, (i) {
        final isSel = i == selected;
        return GestureDetector(
          onTap: () => onSelect(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSel ? VAColors.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: isSel ? VAColors.primary : VAColors.greyBorder,
                  width: isSel ? 1.5 : 1),
            ),
            child: Text(items[i],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSel ? VAColors.primaryDark : VAColors.greyText)),
          ),
        );
      }),
    );
  }
}

// ─── Champ feature dynamique ──────────────────────────────────────────────────

class _FeatureField extends StatefulWidget {
  final CategoryFeature       feature;
  final dynamic               value;
  final ValueChanged<dynamic> onChanged;

  const _FeatureField({
    required this.feature,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_FeatureField> createState() => _FeatureFieldState();
}

class _FeatureFieldState extends State<_FeatureField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value?.toString() ?? '');
    _ctrl.addListener(() {
      final v = widget.feature.isNumeric
          ? (int.tryParse(_ctrl.text) ?? _ctrl.text)
          : _ctrl.text;
      widget.onChanged(v);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.feature.unit != null
        ? '${widget.feature.name} (${widget.feature.unit})'
        : widget.feature.name;

    return _FormField(
      label:    label,
      required: widget.feature.isRequired,
      child:    _buildInput(),
    );
  }

  Widget _buildInput() {
    final feature = widget.feature;

    // Select → chips
    if (feature.isSelect && feature.selectOptions.isNotEmpty) {
      return Wrap(
        spacing: 8, runSpacing: 4,
        children: feature.selectOptions.map((opt) {
          final isSel = widget.value == opt;
          return GestureDetector(
            onTap: () => widget.onChanged(opt),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSel ? VAColors.primaryLight : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSel ? VAColors.primary : VAColors.greyBorder,
                  width: isSel ? 1.5 : 1,
                ),
              ),
              child: Text(opt.toString(),
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: isSel ? VAColors.primaryDark : VAColors.greyText)),
            ),
          );
        }).toList(),
      );
    }

    // Numérique ou texte → TextField
    return TextField(
      controller:      _ctrl,
      keyboardType:    feature.isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: feature.isNumeric
          ? [FilteringTextInputFormatter.digitsOnly] : null,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText:    feature.name,
        hintStyle:   const TextStyle(color: VAColors.grey, fontSize: 14),
        border:      InputBorder.none,
        suffixText:  feature.unit,
        suffixStyle: const TextStyle(
            color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 14),
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: VAColors.black),
    );
  }
}
