import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';

// ─── Modèle de filtres partagé avec SearchScreen ──────────────────────────────

class SearchFilters {
  final String? categoryUuid;
  final String? categoryName;
  final int?    minPrice;
  final int?    maxPrice;

  const SearchFilters({
    this.categoryUuid,
    this.categoryName,
    this.minPrice,
    this.maxPrice,
  });

  bool get isActive =>
      categoryUuid != null || minPrice != null || maxPrice != null;

  SearchFilters copyWith({
    Object? categoryUuid = _sentinel,
    Object? categoryName = _sentinel,
    Object? minPrice     = _sentinel,
    Object? maxPrice     = _sentinel,
  }) =>
      SearchFilters(
        categoryUuid: categoryUuid == _sentinel ? this.categoryUuid : categoryUuid as String?,
        categoryName: categoryName == _sentinel ? this.categoryName : categoryName as String?,
        minPrice:     minPrice     == _sentinel ? this.minPrice     : minPrice     as int?,
        maxPrice:     maxPrice     == _sentinel ? this.maxPrice     : maxPrice     as int?,
      );
}

const _sentinel = Object();

// ─── Écran filtres ────────────────────────────────────────────────────────────

@RoutePage()
class FiltresScreen extends StatefulWidget {
  final SearchFilters?  initialFilters;
  final List<Category>  categories;

  const FiltresScreen({
    super.key,
    this.initialFilters,
    this.categories = const [],
  });

  @override
  State<FiltresScreen> createState() => _FiltresScreenState();
}

class _FiltresScreenState extends State<FiltresScreen> {
  String? _catUuid;
  String? _catName;
  RangeValues _prix = const RangeValues(0, 2000000);

  @override
  void initState() {
    super.initState();
    final f = widget.initialFilters;
    if (f != null) {
      _catUuid = f.categoryUuid;
      _catName = f.categoryName;
      _prix = RangeValues(
        (f.minPrice ?? 0).toDouble(),
        (f.maxPrice ?? 2000000).toDouble(),
      );
    }
  }

  void _reset() => setState(() {
        _catUuid = null;
        _catName = null;
        _prix    = const RangeValues(0, 2000000);
      });

  void _confirm() {
    Navigator.of(context).pop(SearchFilters(
      categoryUuid: _catUuid,
      categoryName: _catName,
      minPrice: _prix.start > 0 ? _prix.start.round() : null,
      maxPrice: _prix.end < 2000000 ? _prix.end.round() : null,
    ));
  }

  static String _fmt(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000)    return '${(v / 1000).round()} 000 F';
    return '${v.round()} F';
  }

  @override
  Widget build(BuildContext context) {
    // Catégories à afficher : API ou fallback statiques
    final cats = widget.categories.isNotEmpty
        ? widget.categories
        : _staticCats.asMap().entries
            .map((e) => Category(uuid: e.value, name: e.value, position: e.key, children: []))
            .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.86,
      maxChildSize: 0.95,
      minChildSize: 0.45,
      expand: false,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(
                width: 38, height: 4,
                decoration: BoxDecoration(
                    color: const Color(0xFFE0DDD8),
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 22, 6),
              child: Row(
                children: [
                  const Text('Filtres',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontSize: 20,
                          fontWeight: FontWeight.w800, color: VAColors.black)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _reset,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: VAColors.primaryLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Réinitialiser',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: VAColors.primaryDark)),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF5F2EE)),

            // Contenu scrollable
            Expanded(
              child: ListView(
                controller: ctrl,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
                children: [

                  // ── Catégorie ──────────────────────────────────────────────
                  _SectionTitle('Catégorie'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: cats.map((c) => _Chip(
                          label: c.name,
                          selected: _catUuid == c.uuid,
                          onTap: () => setState(() {
                            if (_catUuid == c.uuid) {
                              _catUuid = null;
                              _catName = null;
                            } else {
                              _catUuid = c.uuid;
                              _catName = c.name;
                            }
                          }),
                        )).toList(),
                  ),

                  _Separator(),

                  // ── Prix ───────────────────────────────────────────────────
                  _SectionTitle('Prix (FCFA)'),
                  const SizedBox(height: 14),
                  _PriceRow(min: _fmt(_prix.start), max: _fmt(_prix.end)),
                  const SizedBox(height: 4),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor:   VAColors.primary,
                      inactiveTrackColor: const Color(0xFFEEEBE4),
                      thumbColor:         Colors.white,
                      overlayColor:       VAColors.primary.withValues(alpha: 0.10),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 3),
                      trackHeight: 3.5,
                    ),
                    child: RangeSlider(
                      values: _prix,
                      min: 0,
                      max: 2000000,
                      onChanged: (v) => setState(() => _prix = v),
                    ),
                  ),

                  _Separator(),
                  const SizedBox(height: 28),

                  // ── CTA ────────────────────────────────────────────────────
                  GestureDetector(
                    onTap: _confirm,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: VAColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(
                          color: VAColors.primary.withValues(alpha: 0.28),
                          blurRadius: 14, offset: const Offset(0, 5),
                        )],
                      ),
                      child: const Text('Voir les résultats',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _staticCats = [
    'Téléphones', 'Mode', 'Maison', 'Auto', 'Beauté', 'High-tech', 'Sport', 'Livres',
  ];
}

// ─── Composants internes ──────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black));
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Divider(height: 1, color: Color(0xFFF5F2EE)),
      );
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? VAColors.primaryLight : const Color(0xFFFAF8F5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: selected ? VAColors.primary : const Color(0xFFE8E4DE),
              width: selected ? 1.5 : 1),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? VAColors.primaryDark : VAColors.greyText)),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String min, max;
  const _PriceRow({required this.min, required this.max});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          _PriceBox(label: 'Min', value: min),
          Expanded(child: Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: 10), color: const Color(0xFFE8E4DE))),
          _PriceBox(label: 'Max', value: max),
        ],
      );
}

class _PriceBox extends StatelessWidget {
  final String label, value;
  const _PriceBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: const Color(0xFFFAF8F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E4DE))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: VAColors.grey, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
          ],
        ),
      );
}
