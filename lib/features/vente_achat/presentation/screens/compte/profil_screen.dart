import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../../../router/router.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../../../logic/export.dart';
import '../transaction/suivi_commande_screen.dart';

@RoutePage()
class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  static const _vendeur = VendeursMock.adjoa;
  late final OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = getIt<OrderCubit>()..loadOrders();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        appBar: VAAppBar(
          title: 'Mon profil',
          showBack: false,
          actions: [IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {})],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _ProfileHeader(vendeur: _vendeur),
              const SizedBox(height: 12),
              _WalletCard(),
              const SizedBox(height: 12),
              const _CommandesSection(),
              const SizedBox(height: 12),
              _MenuSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header profil ────────────────────────────────────────────────────────────

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
            child: const Text('VENDEUR PRO',
                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VAStatItem(value: '${vendeur.note}', label: 'NOTE'),
                Container(width: 1, height: 32, color: VAColors.greyBorder),
                VAStatItem(value: '${vendeur.ventes}', label: 'VENTES'),
                Container(width: 1, height: 32, color: VAColors.greyBorder),
                VAStatItem(value: vendeur.tempsReponse, label: 'RÉPONSE'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Wallet card ──────────────────────────────────────────────────────────────

class _WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const WalletRoute()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: VAPadding.base),
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(VARadius.md),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(VARadius.sm)),
              child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mon Wallet', style: TextStyle(color: Colors.white60, fontSize: 11)),
                  Text('Voir le solde', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

// ─── Section commandes ────────────────────────────────────────────────────────

class _CommandesSection extends StatelessWidget {
  const _CommandesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de section
          Row(
            children: [
              const Text('Mes commandes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: VAColors.black)),
              const Spacer(),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (_, state) {
                  if (state is! OrderLoaded) return const SizedBox.shrink();
                  return TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Voir tout',
                        style: TextStyle(color: VAColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Contenu
          BlocBuilder<OrderCubit, OrderState>(
            builder: (ctx, state) {
              if (state is OrderLoading || state is OrderInitial) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(VARadius.md),
                    border: Border.all(color: VAColors.greyBorder),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 22, height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2, color: VAColors.primary),
                    ),
                  ),
                );
              }

              if (state is OrderFailure) {
                return _OrdersError(
                  message: state.failure.toMsg,
                  onRetry: () => ctx.read<OrderCubit>().loadOrders(),
                );
              }

              if (state is OrderLoaded) {
                if (state.orders.isEmpty) {
                  return _OrdersEmpty();
                }
                // Affiche les 5 premières commandes
                final preview = state.orders.take(5).toList();
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(VARadius.md),
                    border: Border.all(color: VAColors.greyBorder),
                  ),
                  child: Column(
                    children: preview.asMap().entries.map((e) {
                      final isLast = e.key == preview.length - 1;
                      return Column(
                        children: [
                          _OrderRow(order: e.value),
                          if (!isLast)
                            const Divider(height: 1, color: VAColors.greyBorder, indent: 56),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final Order order;
  const _OrderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    final (chipColor, chipBg, chipLabel) = _statusChip(order.status);
    return InkWell(
      borderRadius: BorderRadius.circular(VARadius.md),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SuiviCommandeScreen(order: order)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.md, vertical: 12),
        child: Row(
          children: [
            // Icône
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                  color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(VARadius.sm)),
              child: const Icon(Icons.shopping_bag_outlined,
                  color: VAColors.primary, size: 18),
            ),
            const SizedBox(width: 12),

            // Infos commande
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('#${order.shortRef}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                            color: chipBg, borderRadius: BorderRadius.circular(20)),
                        child: Text(chipLabel,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w700, color: chipColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    order.merchantName != null
                        ? '${order.merchantName} • ${_fmtDate(order.createdAt)}'
                        : _fmtDate(order.createdAt),
                    style: VATextStyles.caption,
                  ),
                ],
              ),
            ),

            // Total + chevron
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(order.formattedTotal,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800, color: VAColors.black)),
                const Icon(Icons.chevron_right_rounded, size: 16, color: VAColors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  (Color, Color, String) _statusChip(String s) => switch (s) {
        'pending'   => (const Color(0xFFF57C00), const Color(0xFFFFF3E0), 'En attente'),
        'confirmed' => (VAColors.blue, VAColors.blueLight, 'Confirmée'),
        'shipping'  => (VAColors.primary, VAColors.primaryLight, 'En livraison'),
        'delivered' => (VAColors.green, VAColors.greenLight, 'Livrée'),
        'cancelled' => (VAColors.red, VAColors.redLight, 'Annulée'),
        _           => (VAColors.grey, VAColors.greyLight, s),
      };

  static String _fmtDate(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'il y a ${diff.inHours}h';
    if (diff.inDays == 1)    return 'hier';
    if (diff.inDays < 30)    return 'il y a ${diff.inDays}j';
    return '${d.day}/${d.month}/${d.year}';
  }
}

class _OrdersEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: const Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 36, color: VAColors.grey),
          SizedBox(height: 10),
          Text('Aucune commande',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: VAColors.black)),
          SizedBox(height: 4),
          Text('Vos achats apparaîtront ici',
              style: TextStyle(fontSize: 12, color: VAColors.greyText)),
        ],
      ),
    );
  }
}

class _OrdersError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _OrdersError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: VAColors.grey, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(message, style: VATextStyles.caption)),
          TextButton(
            onPressed: onRetry,
            child: const Text('Réessayer',
                style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// ─── Section menu ─────────────────────────────────────────────────────────────

class _MenuSection extends StatelessWidget {
  static const _items = [
    _MenuItem(icon: Icons.inventory_2_outlined, label: 'Mes annonces',   sub: '5 actives, 2 en modération', color: Color(0xFFFF9800), count: 5),
    _MenuItem(icon: Icons.location_on_outlined, label: 'Adresses',       sub: '2 adresses enregistrées',    color: Color(0xFF2196F3)),
    _MenuItem(icon: Icons.favorite_outline,     label: 'Favoris',        sub: '23 produits sauvegardés',    color: VAColors.red),
    _MenuItem(icon: Icons.security_outlined,    label: 'Sécurité',       sub: 'PIN, biométrie, confidentialité', color: Color(0xFF9C27B0)),
    _MenuItem(icon: Icons.help_outline_rounded, label: 'Aide & support', sub: 'FAQ, contact, signaler',     color: Color(0xFF607D8B)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VAPadding.base),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.md),
          border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        children: _items.asMap().entries.map((e) {
          final item = e.value;
          final isLast = e.key == _items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(VARadius.sm)),
                  child: Icon(item.icon, color: item.color, size: 18),
                ),
                title: Text(item.label,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: VAColors.black)),
                subtitle: Text(item.sub, style: VATextStyles.caption),
                trailing: item.count != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(10)),
                        child: Text('${item.count}',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
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
