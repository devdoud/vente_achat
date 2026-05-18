import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';

@RoutePage()
class FiltresScreen extends StatefulWidget {
  const FiltresScreen({super.key});

  @override
  State<FiltresScreen> createState() => _FiltresScreenState();
}

class _FiltresScreenState extends State<FiltresScreen> {
  int _catIndex = 0;
  int _etatIndex = 0;
  int _locIndex = 0;
  RangeValues _prix = const RangeValues(50000, 600000);
  bool _isPro = false;
  bool _isVerifie = false;

  static const _cats = ['Téléphones', 'Photo', 'Ordinateurs', 'Audio'];
  static const _etats = ['Neuf', 'Comme neuf', 'Bon état', 'Correct'];
  static const _locs = ['Près de moi', 'Cotonou', 'Porto-Novo', 'Parakou'];

  String _formatPrix(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000) return '${(v / 1000).round()} 000 F';
    return '${v.round()} F';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl)),
        ),
        child: Column(
          children: [
            _SheetHandle(),
            _SheetHeader(onReset: () => setState(() {
              _catIndex = 0; _etatIndex = 0; _locIndex = 0;
              _prix = const RangeValues(50000, 600000);
              _isPro = false; _isVerifie = false;
            })),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(VAPadding.base),
                children: [
                  _FilterSection(title: 'CATÉGORIE', child: _ChipRow(items: _cats, selected: _catIndex, onSelect: (i) => setState(() => _catIndex = i))),
                  const SizedBox(height: 20),
                  _FilterSection(
                    title: 'PRIX (FCFA)',
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _PrixBox(label: 'Min', value: _formatPrix(_prix.start)),
                            _PrixBox(label: 'Max', value: _formatPrix(_prix.end)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: VAColors.primary,
                            inactiveTrackColor: VAColors.greyBorder,
                            thumbColor: VAColors.primary,
                            overlayColor: VAColors.primaryLight,
                            trackHeight: 3,
                          ),
                          child: RangeSlider(
                            values: _prix,
                            min: 0, max: 2000000,
                            onChanged: (v) => setState(() => _prix = v),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FilterSection(title: 'ÉTAT', child: _ChipRow(items: _etats, selected: _etatIndex, onSelect: (i) => setState(() => _etatIndex = i))),
                  const SizedBox(height: 20),
                  _FilterSection(title: 'LOCALISATION', child: _ChipRow(items: _locs, selected: _locIndex, onSelect: (i) => setState(() => _locIndex = i), hasIcon: true)),
                  const SizedBox(height: 20),
                  _FilterSection(
                    title: 'TYPE DE VENDEUR',
                    child: Row(
                      children: [
                        _ToggleChip(label: 'Vendeur Pro', selected: _isPro, onTap: () => setState(() => _isPro = !_isPro)),
                        const SizedBox(width: 8),
                        _ToggleChip(label: 'Vérifié', selected: _isVerifie, onTap: () => setState(() => _isVerifie = !_isVerifie)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  VAPrimaryButton(
                    label: 'Voir les résultats (42)',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(width: 36, height: 4, decoration: BoxDecoration(color: VAColors.greyBorder, borderRadius: BorderRadius.circular(2))),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final VoidCallback onReset;
  const _SheetHeader({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: VAPadding.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Filtres', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: VAColors.black)),
          GestureDetector(
            onTap: onReset,
            child: const Text('Réinitialiser', style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _FilterSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VASectionLabel(text: title),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;
  final bool hasIcon;
  const _ChipRow({required this.items, required this.selected, required this.onSelect, this.hasIcon = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.asMap().entries.map((e) {
        final isSelected = e.key == selected;
        return GestureDetector(
          onTap: () => onSelect(e.key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? VAColors.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(VARadius.xxl),
              border: Border.all(color: isSelected ? VAColors.primary : VAColors.greyBorder, width: isSelected ? 1.5 : 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasIcon && e.key == 0) ...[const Icon(Icons.location_on_rounded, size: 14, color: VAColors.primary), const SizedBox(width: 4)],
                Text(e.value, style: TextStyle(fontSize: 13, color: isSelected ? VAColors.primary : VAColors.greyText, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ToggleChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? VAColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(VARadius.xxl),
          border: Border.all(color: selected ? VAColors.primary : VAColors.greyBorder, width: selected ? 1.5 : 1),
        ),
        child: Text(label, style: TextStyle(fontSize: 13, color: selected ? VAColors.primary : VAColors.greyText, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
      ),
    );
  }
}

class _PrixBox extends StatelessWidget {
  final String label, value;
  const _PrixBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: VAColors.greyLight, borderRadius: BorderRadius.circular(VARadius.md)),
      child: Column(
        children: [
          Text(label, style: VATextStyles.label),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: VAColors.black)),
        ],
      ),
    );
  }
}
