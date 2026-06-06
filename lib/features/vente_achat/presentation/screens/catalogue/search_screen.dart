import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../utils/cat_helpers.dart';
import '../../../domain/export.dart';
import '../../../data/mappers/product_mapper.dart';
import '../../../logic/export.dart';
import '../compte/filtres_screen.dart';
import 'annonce_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl  = TextEditingController();
  final _focus = FocusNode();
  Timer?         _debounce;
  String         _query   = '';
  SearchFilters? _filters;

  late final ProductCubit  _productCubit;
  late final CategoryCubit _categoryCubit;

  final List<String> _recent = [
    'iPhone 13', 'Robe wax', 'Table basse', 'Vélo', 'Ordinateur portable',
  ];

  @override
  void initState() {
    super.initState();
    _productCubit  = getIt<ProductCubit>();
    _categoryCubit = getIt<CategoryCubit>()..load();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _ctrl.dispose();
    _focus.dispose();
    _productCubit.close();
    _categoryCubit.close();
    super.dispose();
  }

  // ─── Déclenchement de recherche ──────────────────────────────────────────

  void _triggerSearch([String? override]) {
    final q = (override ?? _query).trim();
    _productCubit.loadProducts(
      query:        q.isEmpty ? null : q,
      categoryUuid: _filters?.categoryUuid,
      minPrice:     _filters?.minPrice,
      maxPrice:     _filters?.maxPrice,
    );
  }

  bool get _hasContent => _query.isNotEmpty || (_filters?.isActive == true);

  void _onSearch(String q) {
    setState(() => _query = q);
    _debounce?.cancel();
    if (q.trim().isEmpty && _filters?.isActive != true) return;
    _debounce = Timer(const Duration(milliseconds: 380), () => _triggerSearch(q));
  }

  void _selectRecent(String term) {
    _ctrl.text = term;
    _ctrl.selection = TextSelection.fromPosition(TextPosition(offset: term.length));
    setState(() => _query = term);
    _triggerSearch(term);
  }

  void _addAndSearch(String term) {
    if (term.trim().isEmpty) return;
    if (!_recent.contains(term)) {
      setState(() {
        _recent.insert(0, term);
        if (_recent.length > 8) _recent.removeLast();
      });
    }
    _focus.unfocus();
    _triggerSearch(term);
  }

  void _removeRecent(String term) => setState(() => _recent.remove(term));
  void _clearAll() => setState(() => _recent.clear());

  // ─── Filtres ──────────────────────────────────────────────────────────────

  Future<void> _openFilters() async {
    final cats = _categoryCubit.state is CategoryLoaded
        ? (_categoryCubit.state as CategoryLoaded).categories
        : <Category>[];

    final result = await showModalBottomSheet<SearchFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FiltresScreen(
        initialFilters: _filters,
        categories: cats,
      ),
    );

    if (result != null && mounted) {
      setState(() => _filters = result);
      _triggerSearch();
    }
  }

  void _clearFilters() {
    setState(() => _filters = null);
    if (_query.trim().isNotEmpty) _triggerSearch();
  }

  void _removeCatFilter() {
    setState(() => _filters = _filters?.copyWith(categoryUuid: null, categoryName: null));
    _triggerSearch();
  }

  void _removePriceFilter() {
    setState(() => _filters = _filters?.copyWith(minPrice: null, maxPrice: null));
    _triggerSearch();
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final statusH    = MediaQuery.of(context).padding.top;
    final hasFilters = _filters?.isActive == true;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productCubit),
        BlocProvider.value(value: _categoryCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [

            // ── Barre de recherche ──────────────────────────────────────────
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(12, statusH + 8, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 38, height: 38,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 15, color: VAColors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(23)),
                          child: TextField(
                            controller: _ctrl,
                            focusNode:  _focus,
                            textInputAction: TextInputAction.search,
                            onChanged:   _onSearch,
                            onSubmitted: _addAndSearch,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: VAColors.black),
                            decoration: InputDecoration(
                              hintText: 'Que cherchez-vous ?',
                              hintStyle: const TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
                              prefixIcon: const Icon(Icons.search_rounded, color: VAColors.primary, size: 20),
                              suffixIcon: _query.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _ctrl.clear();
                                        setState(() => _query = '');
                                        _focus.requestFocus();
                                      },
                                      child: const Icon(Icons.close_rounded, color: VAColors.grey, size: 18),
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Bouton filtre avec badge
                      GestureDetector(
                        onTap: _openFilters,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(
                                color: hasFilters ? VAColors.primaryDark : VAColors.primary,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [BoxShadow(
                                    color: VAColors.primary.withValues(alpha: 0.30),
                                    blurRadius: 8, offset: const Offset(0, 3))],
                              ),
                              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
                            ),
                            if (hasFilters)
                              Positioned(
                                top: -3, right: -3,
                                child: Container(
                                  width: 14, height: 14,
                                  decoration: const BoxDecoration(
                                      color: VAColors.red, shape: BoxShape.circle),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Chips filtres actifs
                  if (hasFilters) ...[
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (_filters!.categoryName != null)
                            _FilterChip(
                              label: _filters!.categoryName!,
                              onRemove: _removeCatFilter,
                            ),
                          if (_filters!.minPrice != null || _filters!.maxPrice != null)
                            _FilterChip(
                              label: _buildPriceLabel(),
                              onRemove: _removePriceFilter,
                            ),
                          if (_filters!.isActive)
                            GestureDetector(
                              onTap: _clearFilters,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text('Tout effacer',
                                    style: TextStyle(
                                        fontSize: 12, color: VAColors.red,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Contenu ────────────────────────────────────────────────────
            Expanded(
              child: !_hasContent
                  ? _EmptyState(
                      recent:     _recent,
                      onSelect:   _selectRecent,
                      onRemove:   _removeRecent,
                      onClearAll: _clearAll,
                    )
                  : BlocBuilder<ProductCubit, ProductState>(
                      builder: (ctx, state) {
                        if (state is ProductLoading || state is ProductInitial) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: VAColors.primary, strokeWidth: 2),
                          );
                        }
                        if (state is ProductFailure) {
                          return _ErrorView(
                            message: state.failure.toMsg,
                            onRetry: _triggerSearch,
                          );
                        }
                        if (state is ProductLoaded) {
                          final catMap = _categoryCubit.state is CategoryLoaded
                              ? buildCategoryMap(
                                  (_categoryCubit.state as CategoryLoaded).categories)
                              : <String, AnnonceCategorie>{};
                          final annonces = state.products
                              .map((p) => productToAnnonce(p, catMap: catMap))
                              .toList();
                          return _ResultsView(query: _query, results: annonces);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildPriceLabel() {
    final min = _filters?.minPrice;
    final max = _filters?.maxPrice;
    if (min != null && max != null) return '${_fmtK(min)} – ${_fmtK(max)} F';
    if (min != null) return '> ${_fmtK(min)} F';
    if (max != null) return '< ${_fmtK(max)} F';
    return 'Prix';
  }

  static String _fmtK(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000)    return '${v ~/ 1000} 000';
    return '$v';
  }
}

// ─── Chip filtre actif ────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _FilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.fromLTRB(10, 4, 6, 4),
        decoration: BoxDecoration(
          color: VAColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: VAColors.primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.primaryDark)),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.close_rounded, size: 13, color: VAColors.primary),
            ),
          ],
        ),
      );
}

// ─── État vide — recherches récentes + catégories ─────────────────────────────

class _EmptyState extends StatelessWidget {
  final List<String> recent;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final VoidCallback onClearAll;

  const _EmptyState({
    required this.recent,
    required this.onSelect,
    required this.onRemove,
    required this.onClearAll,
  });

  static const _popularCats = [
    'Téléphones', 'Mode', 'Maison', 'Auto', 'Beauté', 'High-tech', 'Sport', 'Livres',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recent.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recherches récentes',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
                GestureDetector(
                  onTap: onClearAll,
                  child: const Text('Tout effacer',
                      style: TextStyle(fontSize: 12, color: VAColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: recent
                  .map((t) => _RecentChip(
                        term:     t,
                        onSelect: () => onSelect(t),
                        onRemove: () => onRemove(t),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 28),
          ],

          const Text('Catégories populaires',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
          const SizedBox(height: 10),
          // Utilise CategoryCubit si disponible, sinon liste statique
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (ctx, state) {
              final names = state is CategoryLoaded
                  ? state.categories.map((c) => c.name).toList()
                  : _popularCats;
              return SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  itemCount: names.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () => onSelect(names[i]),
                    child: Container(
                      width: 76,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEBE5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(names[i],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600, color: VAColors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RecentChip extends StatelessWidget {
  final String term;
  final VoidCallback onSelect, onRemove;
  const _RecentChip({required this.term, required this.onSelect, required this.onRemove});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.history_rounded, size: 13, color: VAColors.grey),
              const SizedBox(width: 6),
              Text(term, style: const TextStyle(fontSize: 12, color: VAColors.black, fontWeight: FontWeight.w500)),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close_rounded, size: 13, color: VAColors.grey),
              ),
            ],
          ),
        ),
      );
}

// ─── Résultats ────────────────────────────────────────────────────────────────

class _ResultsView extends StatelessWidget {
  final String query;
  final List<Annonce> results;
  const _ResultsView({required this.query, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, size: 52, color: VAColors.greyBorder),
            const SizedBox(height: 16),
            Text(
              query.isNotEmpty ? 'Aucun résultat pour\n"$query"' : 'Aucun produit trouvé',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: VAColors.black, height: 1.4),
            ),
            const SizedBox(height: 8),
            const Text('Essayez un autre mot-clé\nou modifiez les filtres.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: VAColors.greyText, height: 1.5)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: VAColors.greyText),
              children: [
                TextSpan(
                    text: '${results.length} résultat${results.length > 1 ? 's' : ''} ',
                    style: const TextStyle(fontWeight: FontWeight.w700, color: VAColors.black)),
                if (query.isNotEmpty) TextSpan(text: 'pour "$query"'),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _ResultTile(annonce: results[i]),
          ),
        ),
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  final Annonce annonce;
  const _ResultTile({required this.annonce});

  static const _catColors = {
    AnnonceCategorie.telephones: Color(0xFFD6EBFF),
    AnnonceCategorie.mode:       Color(0xFFFFDDE9),
    AnnonceCategorie.maison:     Color(0xFFD9F2DD),
    AnnonceCategorie.auto:       Color(0xFFFFF0C2),
    AnnonceCategorie.beaute:     Color(0xFFF0DCF9),
    AnnonceCategorie.hightech:   Color(0xFFD4F0FC),
    AnnonceCategorie.sport:      Color(0xFFD6F5E3),
    AnnonceCategorie.livres:     Color(0xFFFFEBCC),
  };

  Color _catBg(AnnonceCategorie c) => _catColors[c] ?? VAColors.primaryLight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: annonce)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x07000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Image produit
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 72, height: 72,
                child: annonce.photos.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: annonce.photos.first,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration.zero,
                        placeholder: (_, __) => Container(color: _catBg(annonce.categorie)),
                        errorWidget: (_, __, ___) => _catPlaceholder(annonce),
                      )
                    : _catPlaceholder(annonce),
              ),
            ),
            const SizedBox(width: 12),

            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(annonce.titre,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF0EDE8),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          annonce.vendeur.nom,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: VAColors.greyText),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.location_on_outlined, size: 11, color: VAColors.grey),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(annonce.localisation,
                            style: const TextStyle(fontSize: 11, color: VAColors.grey),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(annonce.prixFormate,
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 15,
                              fontWeight: FontWeight.w800, color: VAColors.primary)),
                      if (annonce.ancienPrixFormate != null) ...[
                        const SizedBox(width: 6),
                        Text(annonce.ancienPrixFormate!,
                            style: const TextStyle(
                                fontSize: 11, color: VAColors.grey,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: VAColors.greyBorder, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _catPlaceholder(Annonce a) => Container(
        color: _catBg(a.categorie),
        child: Center(child: Icon(catIcon(a.categorie), size: 28, color: catIconColor(a.categorie))),
      );
}

// ─── Vue erreur ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 48, color: VAColors.grey),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: VAColors.greyText)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onRetry,
                child: const Text('Réessayer',
                    style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      );
}
