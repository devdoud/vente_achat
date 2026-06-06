import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../../../logic/export.dart';
import '../activite/confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartCubit  _cartCubit;
  late final OrderCubit _orderCubit;


  @override
  void initState() {
    super.initState();
    _cartCubit  = getIt<CartCubit>()..load();
    _orderCubit = getIt<OrderCubit>();
  }

  @override
  void dispose() {

    _orderCubit.close();
    super.dispose();
  }

  void _openCheckout(BuildContext ctx) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
      builder: (_) => BlocProvider.value(
        value: _orderCubit,
        child: _AddressSheet(onConfirm: (address) {
          Navigator.of(context).pop();
          ctx.read<OrderCubit>().checkout(shippingAddress: address);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cartCubit),
        BlocProvider.value(value: _orderCubit),
      ],
      child: BlocListener<OrderCubit, OrderState>(
        listener: (ctx, state) {
          if (state is OrderCheckoutSuccess && state.orders.isNotEmpty) {
            final order = state.orders.first;
            Navigator.of(ctx).pushReplacement(MaterialPageRoute(
              builder: (_) => ConfirmationScreen(order: order),
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
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: VAAppBar(title: 'Mon panier'),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (ctx, cartState) {
              if (cartState is CartLoading || cartState is CartInitial) {
                return const Center(
                    child: CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2));
              }

              if (cartState is CartFailure) {
                return Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 48, color: VAColors.grey),
                    const SizedBox(height: 12),
                    Text(cartState.failure.toMsg, style: VATextStyles.caption),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => ctx.read<CartCubit>().load(),
                      child: const Text('Réessayer',
                          style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ));
              }

              final cart    = cartState is CartLoaded ? cartState.cart : null;
              final isEmpty = cart == null || cart.isEmpty;

              if (isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: const BoxDecoration(
                            color: VAColors.greyLight, shape: BoxShape.circle),
                        child: const Icon(Icons.shopping_cart_outlined,
                            size: 38, color: VAColors.grey),
                      ),
                      const SizedBox(height: 20),
                      const Text('Votre panier est vide',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,
                              color: VAColors.black)),
                      const SizedBox(height: 8),
                      const Text('Ajoutez des produits depuis\nle catalogue.',
                          textAlign: TextAlign.center, style: VATextStyles.caption),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(VAPadding.base),
                      children: [
                        // Liste des articles
                        ...cart.items.map((item) => _CartItemTile(item: item)),

                        const SizedBox(height: 12),

                        const SizedBox(height: 4),

                        // Offre Sûre uniquement
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: VAPadding.md, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F4FD),
                            borderRadius: BorderRadius.circular(VARadius.md),
                            border: Border.all(color: const Color(0xFFB3D9F5)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.verified_user_rounded,
                                  color: Color(0xFF1565C0), size: 18),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Paiement protégé — argent bloqué jusqu\'à la réception',
                                  style: TextStyle(fontSize: 12,
                                      color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Vider le panier
                        GestureDetector(
                          onTap: () => ctx.read<CartCubit>().clear(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline_rounded,
                                  size: 15, color: VAColors.grey),
                              SizedBox(width: 5),
                              Text('Vider le panier',
                                  style: TextStyle(fontSize: 13, color: VAColors.grey,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pied de page
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        VAPadding.base, VAPadding.sm,
                        VAPadding.base,
                        MediaQuery.of(context).padding.bottom + VAPadding.sm),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Color(0x10000000), blurRadius: 16, offset: Offset(0, -4))],
                    ),
                    child: BlocBuilder<OrderCubit, OrderState>(
                      builder: (ctx, orderState) {
                        final isLoading = orderState is OrderLoading;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${cart.itemCount} article${cart.itemCount > 1 ? 's' : ''}',
                                  style: const TextStyle(fontSize: 13, color: VAColors.greyText),
                                ),
                                Text(cart.formattedTotal,
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w900,
                                        color: VAColors.primary)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            VAPrimaryButton(
                              label: isLoading ? 'Traitement...' : 'Commander maintenant',
                              isLoading: isLoading,
                              icon: isLoading ? null : Icons.flash_on_rounded,
                              onPressed: isLoading
                                  ? null
                                  : () => _openCheckout(ctx),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Tile article panier ──────────────────────────────────────────────────────

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(
        children: [
          // Icône produit
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: VAColors.greyLight,
              borderRadius: BorderRadius.circular(VARadius.sm),
            ),
            child: const Icon(Icons.inventory_2_outlined,
                size: 22, color: VAColors.grey),
          ),
          const SizedBox(width: 12),

          // Info produit
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.productName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                        color: VAColors.black),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                if (item.merchantName != null) ...[
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.storefront_outlined, size: 11, color: VAColors.grey),
                    const SizedBox(width: 3),
                    Text(item.merchantName!,
                        style: const TextStyle(fontSize: 11, color: VAColors.grey)),
                  ]),
                ],
                const SizedBox(height: 4),
                // Prix × quantité
                Row(children: [
                  Text(item.formattedUnitPrice,
                      style: const TextStyle(fontSize: 12, color: VAColors.greyText)),
                  const Text(' × ',
                      style: TextStyle(fontSize: 12, color: VAColors.grey)),
                  Text('${item.quantity}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                          color: VAColors.black)),
                  const Spacer(),
                  Text(item.formattedSubtotal,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900,
                          color: VAColors.primary)),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Actions : +/- et supprimer
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Supprimer
              GestureDetector(
                onTap: () => context.read<CartCubit>().removeItem(item.uuid),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: VAColors.redLight,
                    borderRadius: BorderRadius.circular(VARadius.xs),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: VAColors.red, size: 16),
                ),
              ),
              const SizedBox(height: 6),
              // Modifier quantité
              Container(
                decoration: BoxDecoration(
                  color: VAColors.greyLight,
                  borderRadius: BorderRadius.circular(VARadius.xs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: item.quantity > 1
                          ? () => context.read<CartCubit>()
                              .updateItem(itemUuid: item.uuid, quantity: item.quantity - 1)
                          : null,
                      child: SizedBox(width: 28, height: 28,
                          child: Icon(Icons.remove_rounded, size: 14,
                              color: item.quantity > 1 ? VAColors.black : VAColors.greyBorder)),
                    ),
                    Text('${item.quantity}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800,
                            color: VAColors.black)),
                    GestureDetector(
                      onTap: () => context.read<CartCubit>()
                          .updateItem(itemUuid: item.uuid, quantity: item.quantity + 1),
                      child: const SizedBox(width: 28, height: 28,
                          child: Icon(Icons.add_rounded, size: 14, color: VAColors.black)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Bottom sheet adresse de livraison ────────────────────────────────────────

class _AddressSheet extends StatefulWidget {
  final void Function(Map<String, dynamic> address) onConfirm;
  const _AddressSheet({required this.onConfirm});
  @override
  State<_AddressSheet> createState() => _AddressSheetState();
}

class _AddressSheetState extends State<_AddressSheet> {
  final _ctrl = TextEditingController();

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        VAPadding.base, VAPadding.lg,
        VAPadding.base,
        MediaQuery.of(context).viewInsets.bottom + VAPadding.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Container(width: 36, height: 4,
              decoration: BoxDecoration(color: VAColors.greyBorder,
                  borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          const Text('Adresse de livraison',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: VAColors.black)),
          const SizedBox(height: 4),
          const Text('Où souhaitez-vous recevoir votre commande ?',
              style: VATextStyles.caption),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'Quartier, rue, repère...',
              hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
              prefixIcon: const Icon(Icons.location_on_outlined,
                  size: 20, color: VAColors.primary),
              filled: true,
              fillColor: VAColors.greyLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(VARadius.md),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(VARadius.md),
                borderSide: const BorderSide(color: VAColors.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(fontSize: 14, color: VAColors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _submit,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: VAColors.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(
                  color: VAColors.primary.withValues(alpha: 0.35),
                  blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: const Center(child: Text('Confirmer la commande',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final addr = _ctrl.text.trim();
    widget.onConfirm(addr.isNotEmpty ? {'address': addr} : {});
  }
}


