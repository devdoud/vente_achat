import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../../../logic/export.dart';
import '../activite/confirmation_screen.dart';

@RoutePage()
class OffreSureScreen extends StatefulWidget {
  final Annonce annonce;
  final int quantity;
  const OffreSureScreen({super.key, required this.annonce, this.quantity = 1});

  @override
  State<OffreSureScreen> createState() => _OffreSureScreenState();
}

class _OffreSureScreenState extends State<OffreSureScreen> {
  late final OrderCubit _orderCubit;

  static const _steps = [
    _StepItem(num: '1', title: 'Vous payez l\'achat', sub: 'Votre argent est gardé en sécurité'),
    _StepItem(num: '2', title: 'Notre livreur récupère le colis', sub: 'Chez le vendeur en moins de 24h'),
    _StepItem(num: '3', title: 'Vous vérifiez à la livraison', sub: 'Donnez votre code unique au livreur'),
    _StepItem(num: '4', title: 'Le paiement est libéré', sub: 'Le vendeur reçoit son argent après confirmation'),
  ];

  @override
  void initState() {
    super.initState();
    _orderCubit = getIt<OrderCubit>();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  Annonce get a => widget.annonce;
  double get _totalAvecFrais => a.prix * widget.quantity + 2500;

  void _openAddressSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
      builder: (_) => _BuyNowAddressSheet(
        onConfirm: (address) {
          Navigator.of(context).pop();
          _orderCubit.buyNow(
            productUuid:     a.id,
            quantity:        widget.quantity,
            shippingAddress: address,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderCubit,
      child: BlocConsumer<OrderCubit, OrderState>(
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
        builder: (ctx, state) {
          final isLoading = state is OrderLoading;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: VAAppBar(title: 'Offre Sûre'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(VAPadding.base),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(VARadius.xl),
                    ),
                    child: const Icon(Icons.security_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 16),
                  const Text('Achat 100% sécurisé', style: VATextStyles.displayTitle),
                  const SizedBox(height: 8),
                  const Text(
                    'Votre argent reste bloqué\njusqu\'à la réception du produit',
                    textAlign: TextAlign.center,
                    style: VATextStyles.body,
                  ),
                  const SizedBox(height: 24),
                  _AnnonceCard(annonce: a, quantity: widget.quantity),
                  const SizedBox(height: 16),
                  _TotalCard(annonce: a, quantity: widget.quantity, total: _totalAvecFrais),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(VAPadding.base),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(VARadius.lg),
                      border: Border.all(color: VAColors.greyBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VASectionLabel(text: 'Comment ça marche ?'),
                        const SizedBox(height: 8),
                        ..._steps.map((s) => _StepRow(step: s)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
              child: VAPrimaryButton(
                label: isLoading ? 'Traitement en cours...' : 'Confirmer et payer ${_fmtPrix(_totalAvecFrais)}',
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () => _openAddressSheet(ctx),
              ),
            ),
          );
        },
      ),
    );
  }

  static String _fmtPrix(double v) {
    final i = v.toInt();
    if (i >= 1000000) return '${(i / 1000000).toStringAsFixed(1)}M F';
    if (i >= 1000) {
      final e = i ~/ 1000;
      final r = i % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$i F';
  }
}

// ─── Carte produit ────────────────────────────────────────────────────────────

Color _bgForCat(AnnonceCategorie c) => switch (c) {
      AnnonceCategorie.telephones => const Color(0xFFD6EBFF),
      AnnonceCategorie.mode       => const Color(0xFFFFDDE9),
      AnnonceCategorie.hightech   => const Color(0xFFD4F0FC),
      AnnonceCategorie.auto       => const Color(0xFFFFF0C2),
      AnnonceCategorie.maison     => const Color(0xFFD9F2DD),
      AnnonceCategorie.beaute     => const Color(0xFFF0DCF9),
      AnnonceCategorie.sport      => const Color(0xFFD6F5E3),
      AnnonceCategorie.livres     => const Color(0xFFFFEBCC),
    };

IconData _iconForCat(AnnonceCategorie c) => switch (c) {
      AnnonceCategorie.telephones => Icons.phone_android_outlined,
      AnnonceCategorie.mode       => Icons.checkroom_outlined,
      AnnonceCategorie.maison     => Icons.home_outlined,
      AnnonceCategorie.auto       => Icons.directions_car_outlined,
      AnnonceCategorie.beaute     => Icons.face_outlined,
      AnnonceCategorie.hightech   => Icons.computer_outlined,
      AnnonceCategorie.sport      => Icons.sports_soccer_outlined,
      AnnonceCategorie.livres     => Icons.menu_book_outlined,
    };

class _AnnonceCard extends StatelessWidget {
  final Annonce annonce;
  final int quantity;
  const _AnnonceCard({required this.annonce, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final bg = _bgForCat(annonce.categorie);
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(VARadius.sm)),
            child: Center(child: Icon(_iconForCat(annonce.categorie), size: 26,
                color: bg.withRed((bg.r * 0.5).toInt()).withGreen((bg.g * 0.5).toInt()).withBlue((bg.b * 0.5).toInt()))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(annonce.titre, style: VATextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Vendu par ${annonce.vendeur.nom}', style: VATextStyles.caption),
                Row(children: [
                  const Icon(Icons.star_rounded, color: VAColors.star, size: 12),
                  Text('${annonce.vendeur.note}', style: VATextStyles.caption),
                ]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(annonce.prixFormate, style: VATextStyles.price),
              if (quantity > 1)
                Text('× $quantity', style: VATextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Résumé total ─────────────────────────────────────────────────────────────

class _TotalCard extends StatelessWidget {
  final Annonce annonce;
  final int quantity;
  final double total;
  const _TotalCard({required this.annonce, required this.quantity, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.base),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Column(
        children: [
          _Row('Sous-total', _fmt(annonce.prix * quantity)),
          const SizedBox(height: 8),
          _Row('Frais de livraison', '2 500 F'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1, color: VAColors.greyBorder)),
          Row(
            children: [
              const Text('Total', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
              const Spacer(),
              Text(_fmt(total), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: VAColors.primary)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _Row(String label, String value) => Row(
        children: [
          Text(label, style: VATextStyles.caption),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.black)),
        ],
      );

  static String _fmt(double v) {
    final i = v.toInt();
    if (i >= 1000000) return '${(i / 1000000).toStringAsFixed(1)}M F';
    if (i >= 1000) {
      final e = i ~/ 1000;
      final r = i % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$i F';
  }
}

// ─── Steps ────────────────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final _StepItem step;
  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: VAColors.primaryLight, borderRadius: BorderRadius.circular(VARadius.xs)),
            child: Center(child: Text(step.num,
                style: const TextStyle(fontWeight: FontWeight.w800, color: VAColors.primary, fontSize: 13))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: VATextStyles.bodyMedium),
                Text(step.sub, style: VATextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepItem {
  final String num, title, sub;
  const _StepItem({required this.num, required this.title, required this.sub});
}

// ─── Bottom sheet adresse — Buy Now ──────────────────────────────────────────

class _BuyNowAddressSheet extends StatefulWidget {
  final void Function(Map<String, dynamic> address) onConfirm;
  const _BuyNowAddressSheet({required this.onConfirm});
  @override
  State<_BuyNowAddressSheet> createState() => _BuyNowAddressSheetState();
}

class _BuyNowAddressSheetState extends State<_BuyNowAddressSheet> {
  final _ctrl = TextEditingController();
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _submit() {
    final addr = _ctrl.text.trim();
    widget.onConfirm(addr.isNotEmpty ? {'address': addr} : {});
  }

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
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                  color: VAColors.black)),
          const SizedBox(height: 4),
          const Text('Où souhaitez-vous recevoir votre commande ?',
              style: TextStyle(fontSize: 13, color: VAColors.greyText)),
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
            style: const TextStyle(fontSize: 14, color: VAColors.black,
                fontWeight: FontWeight.w500),
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
              child: const Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flash_on_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('Confirmer et payer',
                      style: TextStyle(color: Colors.white, fontSize: 15,
                          fontWeight: FontWeight.w800)),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
