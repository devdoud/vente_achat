import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../va_shell_screen.dart';

@RoutePage()
class SuperAppHomeScreen extends StatelessWidget {
  const SuperAppHomeScreen({super.key});

  static const _services = [
    _Service('🍽️', 'Restaurants',      false, false),
    _Service('🛍️', 'Boutiques',        false, false),
    _Service('🛒', 'Supermarchés',     false, false),
    _Service('🍹', 'Boissons &\nDesserts', false, false),
    _Service('🛍',  'Vente &\nAchat',  true,  true),
    _Service('💰', 'Promotions',       false, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            const SizedBox(height: 4),
            _LocationBanner(),
            const SizedBox(height: 8),
            _SearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.88,
                ),
                itemCount: _services.length,
                itemBuilder: (_, i) => _ServiceCard(
                  service: _services[i],
                  onTap: _services[i].isHighlight
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const VAShellScreen()),
                          )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _SuperAppBottomNav(),
    );
  }
}

// ─── Top bar ──────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.menu_rounded, size: 24, color: VAColors.black),
          const SizedBox(width: 10),
          // Logo coloré
          _AppLogo(),
          const SizedBox(width: 8),
          const Text(
            'BéninRestooShop',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: VAColors.black,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.search_rounded, size: 24, color: VAColors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.person_outline_rounded, size: 24, color: VAColors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// Logo fait de 4 petits carrés colorés
class _AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const size = 14.0;
    const gap = 2.0;
    return SizedBox(
      width: size * 2 + gap + 4,
      height: size * 2 + gap + 4,
      child: Column(
        children: [
          Row(
            children: [
              Container(width: size, height: size, decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: gap),
              Container(width: size, height: size, decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(3))),
            ],
          ),
          const SizedBox(height: gap),
          Row(
            children: [
              Container(width: size, height: size, decoration: BoxDecoration(color: const Color(0xFF2196F3), borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: gap),
              Container(width: size, height: size, decoration: BoxDecoration(color: const Color(0xFFFF3B30), borderRadius: BorderRadius.circular(3))),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Bannière localisation ────────────────────────────────────────────────────
class _LocationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: VAColors.primary, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Livraison à :', style: TextStyle(fontSize: 10, color: VAColors.grey, fontWeight: FontWeight.w500)),
              Text('Ouetto Abomey-Calavi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: VAColors.black, size: 20),
        ],
      ),
    );
  }
}

// ─── Barre de recherche ───────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: const [
          BoxShadow(color: Color(0x06000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.search_rounded, color: Color(0xFFBBBBBB), size: 20),
          SizedBox(width: 10),
          Text(
            "Qu'est-ce qu'on vous apporte ?",
            style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ─── Carte de service ─────────────────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final _Service service;
  final VoidCallback? onTap;
  const _ServiceCard({required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: service.isHighlight ? VAColors.primary : const Color(0xFFEEEEEE),
            width: service.isHighlight ? 2 : 1,
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            // Flèche top-right
            Positioned(
              top: 6,
              right: 6,
              child: Icon(
                Icons.open_in_new_rounded,
                size: 10,
                color: service.isHighlight ? VAColors.primary : const Color(0xFFCCCCCC),
              ),
            ),
            // Badge NEW
            if (service.isNew)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: VAColors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900, letterSpacing: 0.3),
                  ),
                ),
              ),
            // Contenu centré
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  Text(service.emoji, style: const TextStyle(fontSize: 34)),
                  const SizedBox(height: 6),
                  Text(
                    service.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: service.isHighlight ? VAColors.primary : VAColors.black,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
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

// ─── Bottom nav SuperApp (inchangé — différent du VA module) ─────────────────
class _SuperAppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.grid_view_rounded, size: 26, color: VAColors.grey),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VAShellScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delivery_dining_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Livraison', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.favorite_border_rounded, size: 26, color: VAColors.grey),
              const Icon(Icons.person_outline_rounded, size: 26, color: VAColors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Modèle de données ────────────────────────────────────────────────────────
class _Service {
  final String emoji;
  final String label;
  final bool isNew;
  final bool isHighlight;
  const _Service(this.emoji, this.label, this.isNew, this.isHighlight);
}
