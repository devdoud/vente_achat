import 'package:flutter/material.dart';
import '../theme/va_theme.dart';
import '../../domain/vendeur.dart';

//  AppBar 

class VAAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showBack;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const VAAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.showBack = true,
    this.backgroundColor = Colors.white,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor ?? VAColors.black,
      leading: showBack
          ? IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: backgroundColor == Colors.white ? VAColors.greyLight : Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_left_rounded, color: foregroundColor ?? VAColors.black, size: 22),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      automaticallyImplyLeading: false,
      title: titleWidget ?? (title != null ? Text(title!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: foregroundColor ?? VAColors.black)) : null),
      actions: actions,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: VAColors.greyBorder),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

//  Avatar vendeur 

class VAAvatarVendeur extends StatelessWidget {
  final Vendeur vendeur;
  final double size;
  final Color? bgColor;

  const VAAvatarVendeur({super.key, required this.vendeur, this.size = 44, this.bgColor});

  static const List<Color> _colors = [
    Color(0xFFFF6B6B), Color(0xFFFFE66D), Color(0xFF4ECDC4),
    Color(0xFF45B7D1), Color(0xFF96E6A1), Color(0xFFDDA0DD),
  ];

  @override
  Widget build(BuildContext context) {
    final color = bgColor ?? _colors[vendeur.id.hashCode % _colors.length];
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              vendeur.initiales,
              style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        if (vendeur.isVerifie)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size * 0.32,
              height: size * 0.32,
              decoration: const BoxDecoration(color: VAColors.blue, shape: BoxShape.circle),
              child: Icon(Icons.check, color: Colors.white, size: size * 0.18),
            ),
          ),
      ],
    );
  }
}

//  Badge PRO 

class VAProBadge extends StatelessWidget {
  const VAProBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: VAColors.primary,
        borderRadius: BorderRadius.circular(VARadius.xs),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.white, size: 10),
          SizedBox(width: 3),
          Text('PRO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

//  Bouton primaire plein 

class VAPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;

  const VAPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? VAColors.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VARadius.xl)),
        ),
        child: isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
                  Text(label, style: VATextStyles.buttonText),
                ],
              ),
      ),
    );
  }
}

//  Bouton secondaire 

class VAOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const VAOutlineButton({super.key, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: VAColors.black,
          side: const BorderSide(color: VAColors.black, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VARadius.xl)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: VAColors.black)),
          ],
        ),
      ),
    );
  }
}

//  Chip filtre 

class VAFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? count;

  const VAFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? VAColors.black : Colors.white,
          borderRadius: BorderRadius.circular(VARadius.xxl),
          border: Border.all(color: isSelected ? VAColors.black : VAColors.greyBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : VAColors.greyText,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white24 : VAColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(color: isSelected ? Colors.white : VAColors.primary, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

//  Stats row 

class VAStatItem extends StatelessWidget {
  final String value;
  final String label;

  const VAStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: VAColors.black)),
        const SizedBox(height: 2),
        Text(label, style: VATextStyles.label),
      ],
    );
  }
}

//  Étoiles 

class VAStars extends StatelessWidget {
  final double note;
  final double size;
  final bool interactive;
  final ValueChanged<int>? onChanged;

  const VAStars({super.key, required this.note, this.size = 20, this.interactive = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < note.floor();
        return GestureDetector(
          onTap: interactive ? () => onChanged?.call(i + 1) : null,
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: VAColors.star,
            size: size,
          ),
        );
      }),
    );
  }
}

//  Section header 

class VASectionLabel extends StatelessWidget {
  final String text;
  const VASectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: VAPadding.sm),
      child: Text(text.toUpperCase(), style: VATextStyles.label),
    );
  }
}
