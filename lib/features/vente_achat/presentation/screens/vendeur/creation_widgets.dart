/// Widgets partagés entre les étapes du flow de création d'annonce.
library;

import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';

// ─── Bordure tiretée (remplace dotted_border) ────────────────────────────────

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color color;
  final double strokeWidth;
  final List<double> dash;
  const DashedBorder({
    super.key,
    required this.child,
    this.radius     = 14,
    this.color      = VAColors.greyBorder,
    this.strokeWidth = 1.5,
    this.dash       = const [8, 4],
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _DashPainter(
            radius: radius,
            color: color,
            strokeWidth: strokeWidth,
            dash: dash),
        child: child,
      );
}

class _DashPainter extends CustomPainter {
  final double radius, strokeWidth;
  final Color color;
  final List<double> dash;
  const _DashPainter(
      {required this.radius,
      required this.color,
      required this.strokeWidth,
      required this.dash});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth),
        Radius.circular(radius),
      ));

    final len = dash[0];
    final gap = dash.length > 1 ? dash[1] : dash[0];

    for (final m in path.computeMetrics()) {
      double d = 0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, d + len), paint);
        d += len + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.radius != radius;
}

// ─── AppBar ───────────────────────────────────────────────────────────────────

class CreationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  const CreationAppBar({super.key, required this.title, required this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: VAColors.black),
        onPressed: onBack,
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: VAColors.black)),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 14),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: VAColors.greyLight, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.help_outline_rounded, size: 16, color: VAColors.grey),
        ),
      ],
    );
  }
}

// ─── Barre de progression ─────────────────────────────────────────────────────

class CreationStepBar extends StatelessWidget {
  final int current, total;
  const CreationStepBar({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        total,
        (i) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3.5,
            margin: EdgeInsets.only(right: i < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: i < current ? VAColors.primary : VAColors.greyBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Bottom bar retour / continuer ───────────────────────────────────────────

class CreationBottomBar extends StatelessWidget {
  final VoidCallback onBack, onNext;
  final bool canContinue;
  final String nextLabel;

  const CreationBottomBar({
    super.key,
    required this.onBack,
    required this.onNext,
    this.canContinue = true,
    this.nextLabel = 'Continuer →',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      color: const Color(0xFFF5F3EF),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 48,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: VAColors.greyBorder, width: 1.5),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: VAColors.black),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: canContinue ? onNext : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  color: canContinue ? VAColors.primary : VAColors.greyBorder,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: canContinue
                      ? [
                          BoxShadow(
                            color: VAColors.primary.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    nextLabel,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: canContinue ? Colors.white : VAColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
