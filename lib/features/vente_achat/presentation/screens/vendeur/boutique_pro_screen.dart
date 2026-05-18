import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class BoutiqueProScreen extends StatefulWidget {
  final Vendeur vendeur;
  const BoutiqueProScreen({super.key, required this.vendeur});

  @override
  State<BoutiqueProScreen> createState() => _BoutiqueProScreenState();
}

class _BoutiqueProScreenState extends State<BoutiqueProScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendeur = widget.vendeur;
    return Scaffold(
      backgroundColor: VAColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          _CoverAppBar(vendeur: vendeur, isFollowing: _isFollowing, onFollowToggle: () => setState(() => _isFollowing = !_isFollowing)),
          _ProfileInfo(vendeur: vendeur),
          _StatsCard(vendeur: vendeur),
          _TabBarSliver(controller: _tabController),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _ProduitsTab(vendeur: vendeur),
            _AvisTab(vendeur: vendeur),
            _AProposTab(vendeur: vendeur),
          ],
        ),
      ),
    );
  }
}

class _CoverAppBar extends StatelessWidget {
  final Vendeur vendeur;
  final bool isFollowing;
  final VoidCallback onFollowToggle;
  const _CoverAppBar({required this.vendeur, required this.isFollowing, required this.onFollowToggle});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: VAColors.primary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white24,
          child: IconButton(
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      actions: [
        CircleAvatar(backgroundColor: Colors.white24, child: IconButton(icon: const Icon(Icons.share_outlined, color: Colors.white, size: 18), onPressed: () {})),
        const SizedBox(width: 8),
        CircleAvatar(backgroundColor: Colors.white24, child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white, size: 18), onPressed: () {})),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [VAColors.primary, VAColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: CustomPaint(painter: _CheckerboardPainter()),
        ),
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.08);
    const tileSize = 30.0;
    for (int row = 0; row < (size.height / tileSize).ceil(); row++) {
      for (int col = 0; col < (size.width / tileSize).ceil(); col++) {
        if ((row + col) % 2 == 0) {
          canvas.drawRect(Rect.fromLTWH(col * tileSize, row * tileSize, tileSize, tileSize), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ProfileInfo extends StatelessWidget {
  final Vendeur vendeur;
  const _ProfileInfo({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Transform.translate(
        offset: const Offset(0, -24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VAPadding.base),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(children: [
                Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(color: VAColors.primary, shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)),
                  child: Center(child: Text(vendeur.initiales,
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800))),
                ),
                Positioned(bottom: 2, right: 2,
                  child: Container(
                    width: 20, height: 20,
                    decoration: const BoxDecoration(color: VAColors.blue, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Colors.white, size: 12),
                  ),
                ),
              ]),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(color: VAColors.black, borderRadius: BorderRadius.circular(VARadius.xxl)),
                          child: const Row(children: [
                            Icon(Icons.add, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('Suivre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(border: Border.all(color: VAColors.greyBorder), borderRadius: BorderRadius.circular(VARadius.xxl)),
                        child: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: VAColors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final Vendeur vendeur;
  const _StatsCard({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Transform.translate(
        offset: const Offset(0, -16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VAPadding.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(vendeur.nom, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: VAColors.black)),
                const SizedBox(width: 8),
                const VAProBadge(),
              ]),
              if (vendeur.username != null) ...[
                const SizedBox(height: 2),
                Text('${vendeur.username} · ${vendeur.localisation ?? ''}', style: VATextStyles.caption),
              ],
              if (vendeur.description != null) ...[
                const SizedBox(height: 8),
                Text(vendeur.description!, style: VATextStyles.body),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md), border: Border.all(color: VAColors.greyBorder)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatCol(value: '${vendeur.note}', label: 'NOTE', icon: Icons.star_rounded),
                    _Separator(),
                    _StatCol(value: '${vendeur.ventes}', label: 'VENTES'),
                    _Separator(),
                    _StatCol(value: '${vendeur.produits}', label: 'PRODUITS'),
                    _Separator(),
                    _StatCol(value: '${vendeur.abonnes != null ? (vendeur.abonnes! >= 1000 ? '${(vendeur.abonnes! / 1000).toStringAsFixed(1)}k' : '${vendeur.abonnes}') : '0'}', label: 'ABONNÉS'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  final String value, label;
  final IconData? icon;
  const _StatCol({required this.value, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) Icon(icon, color: VAColors.star, size: 16),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: VAColors.black)),
        ]),
        const SizedBox(height: 2),
        Text(label, style: VATextStyles.label),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 32, color: VAColors.greyBorder);
}

class _TabBarSliver extends StatelessWidget {
  final TabController controller;
  const _TabBarSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TabHeaderDelegate(controller: controller),
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  const _TabHeaderDelegate({required this.controller});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller,
        tabs: [
          Tab(child: Row(mainAxisSize: MainAxisSize.min, children: [const Text('Produits'), const SizedBox(width: 6),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(8)),
                child: const Text('42', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)))])),
          const Tab(text: 'Avis'),
          const Tab(text: 'À propos'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(_) => false;
}

class _ProduitsTab extends StatelessWidget {
  final Vendeur vendeur;
  const _ProduitsTab({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(VAPadding.base),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75),
      itemCount: AnnoncesMock.all.length,
      itemBuilder: (_, i) => VAProductCard(annonce: AnnoncesMock.all[i]),
    );
  }
}

class _AvisTab extends StatelessWidget {
  final Vendeur vendeur;
  const _AvisTab({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Avis à venir', style: VATextStyles.caption));
  }
}

class _AProposTab extends StatelessWidget {
  final Vendeur vendeur;
  const _AProposTab({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(VAPadding.base),
      child: Text(vendeur.description ?? '', style: VATextStyles.body),
    );
  }
}
