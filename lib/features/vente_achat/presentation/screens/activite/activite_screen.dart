import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/models/order_model.dart';
import '../../../logic/export.dart';
import '../transaction/suivi_commande_screen.dart';

String _normalizeStatus(String s) {
  final l = s.toLowerCase();
  if (l == 'pending' || l.contains('await') || l.contains('paid') ||
      l.contains('new') || l.contains('created')) return 'pending';
  if (l == 'confirmed' || l.contains('confirm') || l.contains('accept') ||
      l.contains('process')) return 'confirmed';
  if (l == 'shipping' || l.contains('ship') || l.contains('transit') ||
      l.contains('dispatch') || l.contains('sent')) return 'shipping';
  if (l == 'delivered' || l.contains('deliver') || l.contains('complet') ||
      l.contains('done') || l.contains('received')) return 'delivered';
  if (l == 'cancelled' || l.contains('cancel') || l.contains('refund')) return 'cancelled';
  return 'pending';
}

@RoutePage()
class ActiviteScreen extends StatefulWidget {
  const ActiviteScreen({super.key});

  @override
  State<ActiviteScreen> createState() => _ActiviteScreenState();
}

class _ActiviteScreenState extends State<ActiviteScreen> {
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
          title: 'Mes commandes',
          showBack: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () => _orderCubit.loadOrders(),
            ),
          ],
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (ctx, state) {
            if (state is OrderLoading || state is OrderInitial) {
              return const Center(
                child: CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2),
              );
            }

            if (state is OrderFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off_rounded, size: 48, color: VAColors.grey),
                      const SizedBox(height: 16),
                      Text(state.failure.toMsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: VAColors.greyText)),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => ctx.read<OrderCubit>().loadOrders(),
                        child: const Text('Réessayer',
                            style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is OrderLoaded) {
              if (state.orders.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 52, color: VAColors.greyBorder),
                      SizedBox(height: 14),
                      Text('Aucune commande',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: VAColors.black)),
                      SizedBox(height: 4),
                      Text('Vos achats apparaîtront ici.',
                          style: TextStyle(fontSize: 12, color: VAColors.greyText)),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                color: VAColors.primary,
                onRefresh: () async => ctx.read<OrderCubit>().loadOrders(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(VAPadding.base),
                  itemCount: state.orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => _OrderCard(order: state.orders[i]),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ─── Carte commande ───────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final (chipColor, chipBg, chipLabel) = _statusChip(_normalizeStatus(order.status));

    return InkWell(
      borderRadius: BorderRadius.circular(VARadius.md),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SuiviCommandeScreen(order: order)),
      ),
      child: Container(
        padding: const EdgeInsets.all(VAPadding.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.md),
          border: Border.all(color: VAColors.greyBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête : statut + date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: chipBg, borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(width: 6, height: 6,
                        decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    Text(chipLabel,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: chipColor)),
                  ]),
                ),
                const Spacer(),
                Text(_fmtDate(order.createdAt), style: VATextStyles.caption),
              ],
            ),
            const SizedBox(height: 10),

            // Corps : icône + infos + total
            Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                      color: VAColors.primaryLight,
                      borderRadius: BorderRadius.circular(VARadius.sm)),
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: VAColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Commande #${order.shortRef}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
                      if (order.merchantName != null)
                        Row(children: [
                          const Icon(Icons.storefront_outlined, size: 12, color: VAColors.grey),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(order.merchantName!,
                                style: VATextStyles.caption,
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ])
                      else
                        Text('${order.itemUuids.length} article${order.itemUuids.length > 1 ? 's' : ''}',
                            style: VATextStyles.caption),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(order.formattedTotal,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.primary)),
                    const Icon(Icons.chevron_right_rounded, size: 16, color: VAColors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  (Color, Color, String) _statusChip(String s) => switch (s) {
        'pending'   => (const Color(0xFFF57C00), const Color(0xFFFFF3E0), 'En attente'),
        'confirmed' => (VAColors.blue,    VAColors.blueLight,    'Confirmée'),
        'shipping'  => (VAColors.primary, VAColors.primaryLight, 'En livraison'),
        'delivered' => (VAColors.green,   VAColors.greenLight,   'Livrée'),
        'cancelled' => (VAColors.red,     VAColors.redLight,     'Annulée'),
        _           => (VAColors.grey,    VAColors.greyLight,    'En attente'),
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
