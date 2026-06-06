import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/models/order_model.dart';
import '../../../logic/export.dart';
import '../activite/evaluation_screen.dart';
import '../../../domain/annonce.dart';

// ─── Normalisation des statuts API ───────────────────────────────────────────
// L'API peut renvoyer des variantes : 'paid', 'accepted', 'shipped', etc.

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
  if (l == 'cancelled' || l.contains('cancel') || l.contains('refund') ||
      l.contains('rejected')) return 'cancelled';
  return 'pending';
}

@RoutePage()
class SuiviCommandeScreen extends StatefulWidget {
  final Order order;
  const SuiviCommandeScreen({super.key, required this.order});

  @override
  State<SuiviCommandeScreen> createState() => _SuiviCommandeScreenState();
}

class _SuiviCommandeScreenState extends State<SuiviCommandeScreen> {
  late final OrderCubit _orderCubit;
  late Order _order;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _orderCubit = getIt<OrderCubit>();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  List<_Etape> _buildTimeline(Order order) {
    final status     = _normalizeStatus(order.status);
    final stages     = ['pending', 'confirmed', 'shipping', 'delivered'];
    final currentIdx = stages.indexOf(status).clamp(0, 3);
    final created    = _fmt(order.createdAt);
    final updated    = order.updatedAt != null ? _fmt(order.updatedAt!) : null;

    return [
      _Etape(label: 'Commande payée',     time: created,                                       done: true,           isCurrent: currentIdx == 0),
      _Etape(label: 'Vendeur a confirmé', time: currentIdx >= 1 ? (updated ?? created) : 'En attente', done: currentIdx >= 1, isCurrent: currentIdx == 1),
      _Etape(label: 'En route vers vous', time: currentIdx >= 2 ? (updated ?? 'En cours') : 'En attente', done: currentIdx >= 2, isCurrent: currentIdx == 2),
      _Etape(label: 'Livré et confirmé',  time: currentIdx >= 3 ? (updated ?? 'Confirmé') : 'En attente', done: currentIdx >= 3, isCurrent: currentIdx == 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderCubit,
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (ctx, state) {
          if (state is OrderDeliverSuccess) {
            setState(() => _order = state.order);
            Navigator.of(ctx).push(MaterialPageRoute(
              builder: (_) => EvaluationScreen(annonce: AnnoncesMock.iphone13),
            ));
          } else if (state is OrderFailure) {
            ScaffoldMessenger.of(ctx)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(state.failure.toMsg,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                backgroundColor: VAColors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              ));
          }
        },
        builder: (ctx, state) {
          final isLoading  = state is OrderLoading;
          final normalized = _normalizeStatus(_order.status);
          final canConfirm = normalized == 'shipping';

          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F7),
            appBar: VAAppBar(
              title: 'Commande #${_order.shortRef}',
              actions: [IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(VAPadding.base),
              child: Column(
                children: [
                  // ── Carte statut compact ──────────────────────────────
                  _StatusCard(status: normalized),
                  const SizedBox(height: 12),

                  // ── Vendeur ───────────────────────────────────────────
                  if (_order.merchantName != null) ...[
                    _MerchantCard(merchantName: _order.merchantName!),
                    const SizedBox(height: 12),
                  ],

                  // ── Timeline ─────────────────────────────────────────
                  _Timeline(etapes: _buildTimeline(_order)),
                  const SizedBox(height: 12),

                  // ── Récap ─────────────────────────────────────────────
                  _CommandeRecap(order: _order),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            bottomNavigationBar: canConfirm
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(
                        VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
                    child: VAPrimaryButton(
                      label: isLoading ? 'Confirmation...' : 'Confirmer la réception',
                      isLoading: isLoading,
                      onPressed: isLoading ? null : () => _orderCubit.deliverOrder(orderUuid: _order.uuid),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  static String _fmt(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'il y a ${diff.inHours}h';
    if (diff.inDays == 1)    return 'hier';
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${d.day}/${d.month} à $h:$m';
  }
}

// ─── Carte statut compact ────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final String status;
  const _StatusCard({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, bg, icon, label, subtitle) = _info(status);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(VARadius.sm),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800, color: color)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: VAColors.greyText)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                const SizedBox(width: 5),
                Text(label.toLowerCase(),
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color, IconData, String, String) _info(String s) => switch (s) {
        'pending'   => (const Color(0xFFF57C00), const Color(0xFFFFF3E0),
                        Icons.schedule_rounded,
                        'En attente', 'En attente de confirmation du vendeur'),
        'confirmed' => (VAColors.blue, VAColors.blueLight,
                        Icons.check_circle_outline_rounded,
                        'Confirmée', 'Le vendeur a confirmé votre commande'),
        'shipping'  => (VAColors.primary, VAColors.primaryLight,
                        Icons.delivery_dining_rounded,
                        'En livraison', 'Le livreur est en route vers vous'),
        'delivered' => (VAColors.green, VAColors.greenLight,
                        Icons.check_circle_rounded,
                        'Livrée', 'Votre commande a été livrée avec succès'),
        'cancelled' => (VAColors.red, VAColors.redLight,
                        Icons.cancel_outlined,
                        'Annulée', 'Cette commande a été annulée'),
        _           => (VAColors.grey, VAColors.greyLight,
                        Icons.schedule_rounded,
                        'En attente', 'Statut en cours de mise à jour'),
      };
}

// ─── Carte vendeur ───────────────────────────────────────────────────────────

class _MerchantCard extends StatelessWidget {
  final String merchantName;
  const _MerchantCard({required this.merchantName});

  @override
  Widget build(BuildContext context) {
    final initials = merchantName.trim().split(' ')
        .where((w) => w.isNotEmpty).take(2)
        .map((w) => w[0].toUpperCase()).join();

    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.md),
          border: Border.all(color: VAColors.greyBorder)),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
                color: VAColors.primaryLight,
                borderRadius: BorderRadius.circular(VARadius.sm)),
            child: Center(
              child: Text(initials,
                  style: const TextStyle(
                      color: VAColors.primary, fontWeight: FontWeight.w800, fontSize: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(merchantName, style: VATextStyles.bodyMedium),
                const Text('Vendeur', style: VATextStyles.caption),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: VAColors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ─── Timeline ────────────────────────────────────────────────────────────────

class _Timeline extends StatelessWidget {
  final List<_Etape> etapes;
  const _Timeline({required this.etapes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.md),
          border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VASectionLabel(text: 'Suivi de la commande'),
          const SizedBox(height: 8),
          ...etapes.asMap().entries.map(
              (e) => _EtapeRow(etape: e.value, isLast: e.key == etapes.length - 1)),
        ],
      ),
    );
  }
}

class _EtapeRow extends StatelessWidget {
  final _Etape etape;
  final bool isLast;
  const _EtapeRow({required this.etape, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: etape.done
                    ? VAColors.primary
                    : etape.isCurrent ? Colors.white : VAColors.greyLight,
                shape: BoxShape.circle,
                border: etape.isCurrent
                    ? Border.all(color: VAColors.primary, width: 2) : null,
              ),
              child: Center(
                child: etape.done
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : etape.isCurrent
                        ? Container(width: 8, height: 8,
                            decoration: const BoxDecoration(
                                color: VAColors.primary, shape: BoxShape.circle))
                        : Container(width: 8, height: 8,
                            decoration: BoxDecoration(
                                color: VAColors.greyBorder, shape: BoxShape.circle)),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 32,
                  color: etape.done ? VAColors.primary : VAColors.greyBorder),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(etape.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: etape.isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: etape.isCurrent ? VAColors.primary
                           : etape.done ? VAColors.black : VAColors.grey,
                    )),
                Text(etape.time, style: VATextStyles.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Récap commande ──────────────────────────────────────────────────────────

class _CommandeRecap extends StatelessWidget {
  final Order order;
  const _CommandeRecap({required this.order});

  @override
  Widget build(BuildContext context) {
    final itemCount = order.itemUuids.length;
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(VARadius.md),
          border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                    color: VAColors.primaryLight,
                    borderRadius: BorderRadius.circular(VARadius.sm)),
                child: const Center(
                  child: Icon(Icons.shopping_bag_outlined,
                      size: 22, color: VAColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.merchantName != null
                          ? 'Boutique ${order.merchantName}'
                          : 'Commande #${order.shortRef}',
                      style: VATextStyles.bodyMedium,
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    Text('$itemCount article${itemCount > 1 ? 's' : ''}',
                        style: VATextStyles.caption),
                  ],
                ),
              ),
              Text(order.formattedTotal, style: VATextStyles.price),
            ],
          ),
          const Divider(height: 24, color: VAColors.greyBorder),
          _Row(label: 'Total payé', value: order.formattedTotal, bold: true),
          if (order.note != null && order.note!.isNotEmpty) ...[
            const SizedBox(height: 4),
            _Row(label: 'Note', value: order.note!),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _Row({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold
              ? const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)
              : VATextStyles.body),
          Text(value, style: bold
              ? const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.primary)
              : VATextStyles.price),
        ],
      );
}

// ─── Model interne ───────────────────────────────────────────────────────────

class _Etape {
  final String label, time;
  final bool done, isCurrent;
  const _Etape({required this.label, required this.time, required this.done, this.isCurrent = false});
}
