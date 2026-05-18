import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';
import '../../models/export.dart';

@RoutePage()
class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  static const _vendeur = VendeursMock.adjoa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VAColors.background,
      appBar: VAAppBar(
        title: 'Mon profil',
        showBack: false,
        actions: [IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileHeader(vendeur: _vendeur),
            _WalletCard(),
            const SizedBox(height: 8),
            _MenuSection(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final Vendeur vendeur;
  const _ProfileHeader({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VAPadding.xl),
      color: VAColors.primary,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 72, height: 72,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                  child: Text(vendeur.initiales,
                      style: const TextStyle(color: VAColors.primary, fontSize: 28, fontWeight: FontWeight.w800)),
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 22, height: 22,
                  decoration: const BoxDecoration(color: VAColors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(vendeur.nom, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(VARadius.xs)),
            child: const Text('VENDEUR PRO', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VAStatItem(value: '${vendeur.note}', label: 'NOTE'),
                _Divider(),
                VAStatItem(value: '${vendeur.ventes}', label: 'VENTES'),
                _Divider(),
                VAStatItem(value: vendeur.tempsReponse, label: 'RÉPONSE'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: VAColors.greyBorder);
  }
}

class _WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(VAPadding.base),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 16),
      decoration: BoxDecoration(color: VAColors.cardBlack, borderRadius: BorderRadius.circular(VARadius.md)),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(VARadius.sm)),
            child: const Icon(Icons.account_balance_wallet_outlined, color: VAColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Solde disponible', style: TextStyle(color: Colors.white60, fontSize: 11)),
                Text('1 285 000 FCFA', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  static const _items = [
    _MenuItem(icon: Icons.inventory_2_outlined, label: 'Mes annonces', sub: '5 actives, 2 en modération', color: Color(0xFFFF9800), count: 5),
    _MenuItem(icon: Icons.location_on_outlined, label: 'Adresses', sub: '2 adresses enregistrées', color: Color(0xFF2196F3)),
    _MenuItem(icon: Icons.favorite_outline, label: 'Favoris', sub: '23 produits sauvegardés', color: VAColors.red),
    _MenuItem(icon: Icons.security_outlined, label: 'Sécurité', sub: 'PIN, biométrie, confidentialité', color: Color(0xFF9C27B0)),
    _MenuItem(icon: Icons.help_outline_rounded, label: 'Aide & support', sub: 'FAQ, contact, signaler', color: Color(0xFF607D8B)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VAPadding.base),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md), border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        children: _items.asMap().entries.map((e) {
          final item = e.value;
          final isLast = e.key == _items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: item.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(VARadius.sm)),
                  child: Icon(item.icon, color: item.color, size: 18),
                ),
                title: Text(item.label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: VAColors.black)),
                subtitle: Text(item.sub, style: VATextStyles.caption),
                trailing: item.count != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(10)),
                        child: Text('${item.count}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      )
                    : const Icon(Icons.chevron_right_rounded, color: VAColors.grey),
                onTap: () {},
              ),
              if (!isLast) const Divider(height: 1, color: VAColors.greyBorder, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label, sub;
  final Color color;
  final int? count;
  const _MenuItem({required this.icon, required this.label, required this.sub, required this.color, this.count});
}
