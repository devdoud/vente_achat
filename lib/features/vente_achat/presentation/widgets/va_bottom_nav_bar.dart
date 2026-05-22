import 'package:flutter/material.dart';
import '../theme/va_theme.dart';

//  Données statiques des onglets 
class _Tab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _Tab(this.icon, this.activeIcon, this.label);
}

const _tabs = [
  _Tab(Icons.shopping_bag_outlined,      Icons.shopping_bag_rounded,    'Acheter'),
  _Tab(Icons.add_circle_outline_rounded, Icons.add_circle_rounded,      'Vendre'),
  _Tab(Icons.timeline_outlined,           Icons.timeline_rounded,        'Activité'),
  _Tab(Icons.favorite_border_rounded,    Icons.favorite_rounded,        'Favoris'),
];

//  Widget principal 
class VABottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int activiteBadge;

  const VABottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.activiteBadge = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x16000000), blurRadius: 24, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (i) {
              final tab = _tabs[i];
              final isSelected = i == currentIndex;
              final badge = 0;

              if (isSelected) {
                return _PillItem(tab: tab, index: i, onTap: onTap);
              }
              return _IconItem(tab: tab, index: i, onTap: onTap, badgeCount: badge);
            }),
          ),
        ),
      ),
    );
  }
}

//  Onglet actif : pill orange 
class _PillItem extends StatelessWidget {
  final _Tab tab;
  final int index;
  final ValueChanged<int> onTap;
  const _PillItem({required this.tab, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: VAColors.primary,
          borderRadius: BorderRadius.circular(VARadius.xxl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tab.activeIcon, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Text(
              tab.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  Onglet inactif : icône grise 
class _IconItem extends StatelessWidget {
  final _Tab tab;
  final int index;
  final ValueChanged<int> onTap;
  final int badgeCount;
  const _IconItem({
    required this.tab,
    required this.index,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 48,
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(tab.icon, size: 26, color: VAColors.grey),
            if (badgeCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: const BoxDecoration(
                    color: VAColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$badgeCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
