import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../../../data/mappers/product_mapper.dart';
import '../../../logic/export.dart';

@RoutePage()
class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  AnnonceCategorie? _activeCat;
  _SortMode _sortMode = _SortMode.recent;
  late final FavoriteCubit _favCubit;
  late final CategoryCubit _catCubit;

  @override
  void initState() {
    super.initState();
    _favCubit = getIt<FavoriteCubit>()..load();
    _catCubit = getIt<CategoryCubit>()..load();
  }

  @override
  void dispose() {
    _favCubit.close();
    _catCubit.close();
    super.dispose();
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl)),
      ),
      builder: (_) => _SortSheet(
        current: _sortMode,
        onSelect: (mode) {
          setState(() => _sortMode = mode);
          Navigator.pop(context);
        },
      ),
    );
  }

  List<Annonce> _sorted(List<Annonce> items) {
    final copy = List<Annonce>.from(items);
    switch (_sortMode) {
      case _SortMode.recent:
        copy.sort((a, b) => b.datePublication.compareTo(a.datePublication));
      case _SortMode.prixAsc:
        copy.sort((a, b) => a.prix.compareTo(b.prix));
      case _SortMode.prixDesc:
        copy.sort((a, b) => b.prix.compareTo(a.prix));
    }
    return copy;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _favCubit),
        BlocProvider.value(value: _catCubit),
      ],
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (ctx, catState) {
          final catMap = catState is CategoryLoaded
              ? buildCategoryMap(catState.categories)
              : <String, AnnonceCategorie>{};

          return BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (ctx, favState) {
              final List<Annonce> allFavs;

              if (favState is FavoriteLoaded) {
                allFavs = favState.products
                    .map((p) => productToAnnonce(p, catMap: catMap))
                    .toList();
              } else {
                allFavs = [];
              }

              final availableCats = _buildAvailableCats(allFavs);
              final filtered = _sorted(_filter(allFavs));
              final priceDropCount = allFavs.where((a) => a.ancienPrix != null).length;

              return Scaffold(
                backgroundColor: Colors.white,
                appBar: VAAppBar(title: 'Favoris', showBack: false),
                body: favState is FavoriteLoading
                    ? const Center(child: CircularProgressIndicator(color: VAColors.primary))
                    : CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: _TopBar(
                              total: _countFor(allFavs),
                              sortMode: _sortMode,
                              onSortTap: _showSortSheet,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _CatFilter(
                              cats: availableCats,
                              selected: _activeCat,
                              countFor: (cat) => _countFor(allFavs, cat: cat),
                              onSelect: (cat) => setState(() => _activeCat = cat),
                            ),
                          ),
                          if (_activeCat == null && priceDropCount > 0)
                            SliverToBoxAdapter(
                              child: _PriceDropBanner(count: priceDropCount),
                            ),
                          if (filtered.isEmpty)
                            SliverFillRemaining(
                              child: allFavs.isEmpty ? const _EmptyState() : const _EmptyFilter(),
                            )
                          else
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(
                                  VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
                              sliver: SliverToBoxAdapter(child: _MasonryGrid(items: filtered)),
                            ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }

  List<AnnonceCategorie?> _buildAvailableCats(List<Annonce> items) {
    final seen = <AnnonceCategorie>{};
    for (final a in items) seen.add(a.categorie);
    return [null, ...seen.toList()];
  }

  int _countFor(List<Annonce> all, {AnnonceCategorie? cat}) =>
      cat == null ? all.length : all.where((a) => a.categorie == cat).length;

  List<Annonce> _filter(List<Annonce> all) =>
      _activeCat == null ? all : all.where((a) => a.categorie == _activeCat).toList();
}

// ─── Sort ─────────────────────────────────────────────────────────────────────

enum _SortMode { recent, prixAsc, prixDesc }

extension _SortModeExt on _SortMode {
  String get label => switch (this) {
        _SortMode.recent   => 'Récent',
        _SortMode.prixAsc  => 'Prix croissant',
        _SortMode.prixDesc => 'Prix décroissant',
      };
  IconData get icon => switch (this) {
        _SortMode.recent   => Icons.access_time_rounded,
        _SortMode.prixAsc  => Icons.arrow_upward_rounded,
        _SortMode.prixDesc => Icons.arrow_downward_rounded,
      };
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final int total;
  final _SortMode sortMode;
  final VoidCallback onSortTap;
  const _TopBar({required this.total, required this.sortMode, required this.onSortTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(VAPadding.base, 12, VAPadding.base, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$total article${total > 1 ? 's' : ''} sauvegardé${total > 1 ? 's' : ''}',
              style: VATextStyles.caption,
            ),
          ),
          GestureDetector(
            onTap: onSortTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: VAColors.greyBorder),
                borderRadius: BorderRadius.circular(VARadius.xxl),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(sortMode.icon, size: 13, color: VAColors.black),
                  const SizedBox(width: 5),
                  Text(sortMode.label,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black)),
                  const SizedBox(width: 3),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: VAColors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortSheet extends StatelessWidget {
  final _SortMode current;
  final ValueChanged<_SortMode> onSelect;
  const _SortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(VAPadding.base, VAPadding.lg, VAPadding.base, VAPadding.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trier par',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: VAColors.black)),
          const SizedBox(height: 16),
          for (final mode in _SortMode.values) ...[
            _SortOption(mode: mode, isSelected: mode == current, onTap: () => onSelect(mode)),
            if (mode != _SortMode.values.last) const Divider(height: 1, color: VAColors.greyBorder),
          ],
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final _SortMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  const _SortOption({required this.mode, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(VARadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(mode.icon, size: 18, color: isSelected ? VAColors.primary : VAColors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(mode.label,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected ? VAColors.black : VAColors.greyText)),
            ),
            if (isSelected) const Icon(Icons.check_rounded, size: 18, color: VAColors.primary),
          ],
        ),
      ),
    );
  }
}

class _CatFilter extends StatelessWidget {
  final List<AnnonceCategorie?> cats;
  final AnnonceCategorie? selected;
  final int Function(AnnonceCategorie?) countFor;
  final ValueChanged<AnnonceCategorie?> onSelect;
  const _CatFilter({required this.cats, required this.selected, required this.countFor, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 8),
        itemCount: cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = cats[i];
          return VAFilterChip(
            label: cat == null ? 'Tous' : cat.label,
            isSelected: selected == cat,
            count: cat != null ? countFor(cat) : null,
            onTap: () => onSelect(cat),
          );
        },
      ),
    );
  }
}

class _PriceDropBanner extends StatelessWidget {
  final int count;
  const _PriceDropBanner({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(VAPadding.base, 4, VAPadding.base, 8),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 12),
      decoration: BoxDecoration(
        color: VAColors.primaryLight,
        borderRadius: BorderRadius.circular(VARadius.md),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded, color: VAColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$count produit${count > 1 ? 's ont' : ' a'} baissé de prix !',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
                const SizedBox(height: 1),
                const Text("Vérifiez vos favoris avant qu'il soit trop tard",
                    style: VATextStyles.caption),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: VAColors.primary),
        ],
      ),
    );
  }
}

class _MasonryGrid extends StatelessWidget {
  final List<Annonce> items;
  const _MasonryGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final left = <Annonce>[];
    final right = <Annonce>[];
    for (int i = 0; i < items.length; i++) {
      if (i.isEven) left.add(items[i]);
      else right.add(items[i]);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _CardColumn(items: left)),
        const SizedBox(width: 12),
        Expanded(child: _CardColumn(items: right)),
      ],
    );
  }
}

class _CardColumn extends StatelessWidget {
  final List<Annonce> items;
  const _CardColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final a in items) ...[
          VAProductCard(annonce: a, isFavorite: true),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72, height: 72,
            decoration: const BoxDecoration(color: VAColors.greyLight, shape: BoxShape.circle),
            child: const Icon(Icons.favorite_border_rounded, size: 32, color: VAColors.grey),
          ),
          const SizedBox(height: 16),
          const Text('Aucun favori',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: VAColors.black)),
          const SizedBox(height: 6),
          const Text('Ajoutez des produits à vos favoris\npour les retrouver ici',
              textAlign: TextAlign.center, style: VATextStyles.caption),
        ],
      ),
    );
  }
}

class _EmptyFilter extends StatelessWidget {
  const _EmptyFilter();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Aucun favori dans cette catégorie', style: VATextStyles.caption),
    );
  }
}
