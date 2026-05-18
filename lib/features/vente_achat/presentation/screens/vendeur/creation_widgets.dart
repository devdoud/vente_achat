/// Widgets partagés entre les étapes du flow de création d'annonce.
library;

import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';

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
