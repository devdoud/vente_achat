import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';
import '../../models/export.dart';

@RoutePage()
class CarteProximiteScreen extends StatelessWidget {
  const CarteProximiteScreen({super.key});

  static final _pins = [
    _MapPin(top: 0.18, left: 0.15, prix: '320k', annonce: AnnoncesMock.iphone13),
    _MapPin(top: 0.28, left: 0.55, prix: '450k', annonce: AnnoncesMock.samsung),
    _MapPin(top: 0.48, left: 0.12, prix: '85k', annonce: AnnoncesMock.sneakers),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _FakeMap(),
          SafeArea(
            child: Column(
              children: [
                _TopBar(),
                Expanded(child: _MapPins(pins: _pins)),
              ],
            ),
          ),
          Positioned(right: 16, top: 180, child: _ZoomControls()),
          Positioned(bottom: 0, left: 0, right: 0, child: _BottomCard(annonce: AnnoncesMock.iphone13)),
        ],
      ),
    );
  }
}

class _FakeMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F0E9),
      child: CustomPaint(painter: _MapGridPainter()),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0DDD1)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final roadPaint = Paint()..color = Colors.white..strokeWidth = 12..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 200), Offset(size.width, 220), roadPaint);
    canvas.drawLine(const Offset(160, 0), Offset(180, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(VAPadding.base),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md),
            boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 8, offset: Offset(0, 2))]),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left_rounded, size: 24, color: VAColors.black),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.location_on_rounded, size: 16, color: VAColors.red),
            const SizedBox(width: 4),
            const Expanded(child: Text('Cadjehoun, Cotonou', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: VAColors.black))),
            const Text('Filtres', style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _MapPins extends StatelessWidget {
  final List<_MapPin> pins;
  const _MapPins({required this.pins});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Stack(
          children: [
            ...pins.map((pin) => Positioned(
              top: constraints.maxHeight * pin.top,
              left: constraints.maxWidth * pin.left,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Color(0x20000000), blurRadius: 6)]),
                    child: Text(pin.prix, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: VAColors.black)),
                  ),
                  _PinIcon(color: VAColors.primary),
                ],
              ),
            )),
            Positioned(
              top: constraints.maxHeight * 0.65,
              left: constraints.maxWidth * 0.45,
              child: Column(children: [
                _PinIcon(color: VAColors.black, size: 40),
              ]),
            ),
          ],
        );
      },
    );
  }
}

class _PinIcon extends StatelessWidget {
  final Color color;
  final double size;
  const _PinIcon({required this.color, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Center(
        child: Container(
          width: size * 0.4, height: size * 0.4,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _ZoomControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md),
          boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 8)]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.add, color: VAColors.black, size: 20), onPressed: () {}),
          Container(height: 1, color: VAColors.greyBorder),
          IconButton(icon: const Icon(Icons.remove, color: VAColors.black, size: 20), onPressed: () {}),
          Container(height: 1, color: VAColors.greyBorder),
          IconButton(icon: const Icon(Icons.my_location_rounded, color: VAColors.primary, size: 20), onPressed: () {}),
        ],
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  final Annonce annonce;
  const _BottomCard({required this.annonce});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl)),
        boxShadow: [BoxShadow(color: Color(0x20000000), blurRadius: 20, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.all(VAPadding.base),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 36, height: 4, decoration: BoxDecoration(color: VAColors.greyBorder, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(VARadius.md)),
                child: Center(child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 30))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(annonce.titre, style: VATextStyles.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(annonce.prixFormate, style: VATextStyles.price),
                    Text(annonce.localisation, style: VATextStyles.caption),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: VAColors.primary, foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VARadius.md)), elevation: 0),
                child: const Text('Voir', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SafeArea(top: false, child: const SizedBox(height: 8)),
          VABottomNavBar(currentIndex: 0, onTap: (_) {}),
        ],
      ),
    );
  }
}

class _MapPin {
  final double top, left;
  final String prix;
  final Annonce annonce;
  const _MapPin({required this.top, required this.left, required this.prix, required this.annonce});
}
