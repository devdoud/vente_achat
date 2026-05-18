import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  int _catIndex = 0;
  static const _cats = ['Tous', 'Téléphones', 'Mode'];
  static const _counts = [23, 8, 7];

  final _favoris = [
    AnnoncesMock.iphone13,
    AnnoncesMock.samsung,
    _canonFav,
    AnnoncesMock.sacMain,
  ];

  static final _canonFav = Annonce(
    id: '3f',
    titre: 'Canon EOS R6 + objectif',
    prix: 1080000,
    ancienPrix: 1200000,
    localisation: 'Plateau',
    categorie: AnnonceCategorie.hightech,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.adjoa,
    description: '',
    photos: [],
    datePublication: DateTime.now().subtract(const Duration(days: 2)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VAColors.background,
      appBar: VAAppBar(
        title: 'Favoris',
        showBack: false,
        actions: [IconButton(icon: const Icon(Icons.tune_rounded), onPressed: () {})],
      ),
      body: Column(
        children: [
          _CatFilter(cats: _cats, counts: _counts, selected: _catIndex, onSelect: (i) => setState(() => _catIndex = i)),
          _PriceDropBanner(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(VAPadding.base),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.68,
              ),
              itemCount: _favoris.length,
              itemBuilder: (_, i) => VAProductCard(annonce: _favoris[i], isFavorite: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatFilter extends StatelessWidget {
  final List<String> cats;
  final List<int> counts;
  final int selected;
  final ValueChanged<int> onSelect;
  const _CatFilter({required this.cats, required this.counts, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 8),
        itemCount: cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => VAFilterChip(label: cats[i], isSelected: i == selected, count: counts[i], onTap: () => onSelect(i)),
      ),
    );
  }
}

class _PriceDropBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: VAPadding.xs),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 12),
      decoration: BoxDecoration(color: VAColors.primaryLight, borderRadius: BorderRadius.circular(VARadius.md)),
      child: const Row(
        children: [
          Icon(Icons.bolt_rounded, color: VAColors.primary, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2 produits ont baissé de prix !', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
                Text('Économisez jusqu\'à 25 000 F sur vos favoris', style: VATextStyles.caption),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: VAColors.primary),
        ],
      ),
    );
  }
}
