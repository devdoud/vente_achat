import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';

@RoutePage()
class FiltresScreen extends StatefulWidget {
  const FiltresScreen({super.key});

  @override
  State<FiltresScreen> createState() => _FiltresScreenState();
}

class _FiltresScreenState extends State<FiltresScreen> {
  int _catIndex  = 0;
  int _etatIndex = 0;
  int _locIndex  = 0;
  RangeValues _prix = const RangeValues(50000, 600000);
  bool _isPro      = false;
  bool _isVerifie  = false;

  static const _cats = [
    '📱 Téléphones', '📷 Photo', '🖥 Ordinateurs',
    '🎧 Audio', '👜 Mode', '🏠 Maison',
  ];
  static const _etats = ['Neuf', 'Comme neuf', 'Bon état', 'Correct'];
  static const _locs  = ['Près de moi', 'Cotonou', 'Porto-Novo', 'Parakou'];

  void _reset() => setState(() {
        _catIndex  = 0;
        _etatIndex = 0;
        _locIndex  = 0;
        _prix      = const RangeValues(50000, 600000);
        _isPro     = false;
        _isVerifie = false;
      });

  String _fmt(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000)    return '${(v / 1000).round()} 000 F';
    return '${v.round()} F';
  }

  @override
  Widget build(BuildContext context) {
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

            // ── Handle ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(
                width: 38, height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0DDD8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 22, 6),
              child: Row(
                children: [
                  const Text('Filtres',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: VAColors.black)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _reset,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: VAColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Réinitialiser',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: VAColors.primaryDark)),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF5F2EE)),

            // ── Contenu scrollable ───────────────────────────────────────
            Expanded(
              child: ListView(
                controller: ctrl,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
                children: [

                  // Catégorie
                  _SectionTitle('Catégorie'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: List.generate(_cats.length, (i) => _Chip(
                          label: _cats[i],
                          selected: _catIndex == i,
                          onTap: () => setState(() => _catIndex = i),
                        )),
                  ),

                  _Separator(),

                  // Prix
                  _SectionTitle('Prix (FCFA)'),
                  const SizedBox(height: 14),
                  _PriceRow(min: _fmt(_prix.start), max: _fmt(_prix.end)),
                  const SizedBox(height: 4),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: VAColors.primary,
                      inactiveTrackColor: const Color(0xFFEEEBE4),
                      thumbColor: Colors.white,
                      overlayColor:
                          VAColors.primary.withValues(alpha: 0.10),
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                          elevation: 3),
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

                  // État
                  _SectionTitle('État'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: List.generate(_etats.length, (i) => _Chip(
                          label: _etats[i],
                          selected: _etatIndex == i,
                          onTap: () => setState(() => _etatIndex = i),
                        )),
                  ),

                  _Separator(),

                  // Localisation
                  _SectionTitle('Localisation'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: List.generate(_locs.length, (i) => _Chip(
                          label: _locs[i],
                          selected: _locIndex == i,
                          onTap: () => setState(() => _locIndex = i),
                          prefixIcon: i == 0
                              ? Icons.location_on_rounded
                              : null,
                        )),
                  ),

                  _Separator(),

                  // Type vendeur
                  _SectionTitle('Vendeur'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: [
                      _Chip(
                        label: 'Professionnel',
                        selected: _isPro,
                        onTap: () => setState(() => _isPro = !_isPro),
                      ),
                      _Chip(
                        label: '✓ Vérifié',
                        selected: _isVerifie,
                        onTap: () =>
                            setState(() => _isVerifie = !_isVerifie),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // CTA
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: VAColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: VAColors.primary.withValues(alpha: 0.28),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Voir les résultats',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
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
}

// ═══════════════════════════════════════════════════════════════════════════
//  COMPOSANTS
// ═══════════════════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: VAColors.black),
      );
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Divider(height: 1, color: Color(0xFFF5F2EE)),
      );
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? prefixIcon;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: prefixIcon != null ? 10 : 14,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected ? VAColors.primaryLight : const Color(0xFFFAF8F5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? VAColors.primary : const Color(0xFFE8E4DE),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon,
                  size: 13,
                  color: selected ? VAColors.primary : VAColors.grey),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? VAColors.primaryDark : VAColors.greyText),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String min, max;
  const _PriceRow({required this.min, required this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PriceBox(label: 'Min', value: min),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: const Color(0xFFE8E4DE),
          ),
        ),
        _PriceBox(label: 'Max', value: max),
      ],
    );
  }
}

class _PriceBox extends StatelessWidget {
  final String label, value;
  const _PriceBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E4DE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    color: VAColors.grey,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: VAColors.black)),
          ],
        ),
      );
}
