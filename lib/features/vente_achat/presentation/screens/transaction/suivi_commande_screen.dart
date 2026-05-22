import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../activite/evaluation_screen.dart';
@RoutePage()
class SuiviCommandeScreen extends StatelessWidget {
  final String commandeId;
  const SuiviCommandeScreen({super.key, required this.commandeId});

  static const _etapes = [
    _Etape(label: 'Commande payée', time: 'Aujourd\'hui, 14:15', done: true),
    _Etape(label: 'Vendeur a confirmé', time: 'Aujourd\'hui, 14:22', done: true),
    _Etape(label: 'En route vers vous', time: 'Estimé à 14:55', done: false, isCurrent: true),
    _Etape(label: 'Livré et confirmé', time: 'En attente', done: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VAAppBar(
        title: 'Commande #$commandeId',
        actions: [IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ETABanner(),
            Padding(
              padding: const EdgeInsets.all(VAPadding.base),
              child: Column(
                children: [
                  _DriverCard(),
                  const SizedBox(height: 16),
                  _Timeline(etapes: _etapes),
                  const SizedBox(height: 16),
                  _CommandeRecap(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
        child: VAPrimaryButton(
          label: 'Confirmer la réception',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => EvaluationScreen(annonce: AnnoncesMock.iphone13),
          )),
        ),
      ),
    );
  }
}

class _ETABanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VAPadding.lg),
      color: VAColors.primary,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delivery_dining_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('EN COURS DE LIVRAISON', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Arrivée dans 15 min', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text('Le livreur est en route vers vous', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ETAChip(label: 'Distance', value: '2.3 km'),
              const SizedBox(width: 12),
              _ETAChip(label: "Heure d'arrivée", value: '14:55'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ETAChip extends StatelessWidget {
  final String label, value;
  const _ETAChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(VARadius.md)),
      child: Column(children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
      ]),
    );
  }
}

class _DriverCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md), border: Border.all(color: VAColors.greyBorder)),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: VAColors.primaryLight, borderRadius: BorderRadius.circular(VARadius.sm)),
            child: const Center(child: Text('YK', style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w800, fontSize: 16))),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Yao Kouamé', style: VATextStyles.bodyMedium),
                Row(children: [
                  Icon(Icons.star_rounded, color: VAColors.star, size: 14),
                  Text('4.8', style: VATextStyles.caption),
                  SizedBox(width: 8),
                  Icon(Icons.directions_car_rounded, size: 14, color: VAColors.grey),
                  Text('AB-23S', style: VATextStyles.caption),
                ]),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.chat_bubble_outline_rounded, color: VAColors.grey), onPressed: () {}),
          IconButton(icon: const Icon(Icons.phone_outlined, color: VAColors.primary), onPressed: () {}),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<_Etape> etapes;
  const _Timeline({required this.etapes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md), border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VASectionLabel(text: 'Suivi de la commande'),
          const SizedBox(height: 8),
          ...etapes.asMap().entries.map((e) => _EtapeRow(etape: e.value, isLast: e.key == etapes.length - 1)),
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
                color: etape.done ? VAColors.primary : etape.isCurrent ? Colors.white : VAColors.greyLight,
                shape: BoxShape.circle,
                border: etape.isCurrent ? Border.all(color: VAColors.primary, width: 2) : null,
              ),
              child: Center(
                child: etape.done
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : etape.isCurrent
                        ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: VAColors.primary, shape: BoxShape.circle))
                        : Container(width: 8, height: 8, decoration: BoxDecoration(color: VAColors.greyBorder, shape: BoxShape.circle)),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 32, color: etape.done ? VAColors.primary : VAColors.greyBorder),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etape.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: etape.isCurrent ? FontWeight.w700 : FontWeight.w500,
                    color: etape.isCurrent ? VAColors.primary : etape.done ? VAColors.black : VAColors.grey,
                  ),
                ),
                Text(etape.time, style: VATextStyles.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CommandeRecap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(VARadius.md), border: Border.all(color: VAColors.greyBorder)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(VARadius.sm)),
                child: const Center(child: Icon(Icons.local_shipping_outlined, size: 22, color: Color(0xFF1976D2))),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('iPhone 13 Pro 128Go', style: VATextStyles.bodyMedium),
                    Row(children: [
                      Text('Adjoa K.', style: VATextStyles.caption),
                      SizedBox(width: 4),
                      Icon(Icons.star_rounded, color: VAColors.star, size: 12),
                      Text('4.9', style: VATextStyles.caption),
                    ]),
                  ],
                ),
              ),
              const Text('450k F', style: VATextStyles.price),
            ],
          ),
          const Divider(height: 24, color: VAColors.greyBorder),
          _RecapRow(label: 'Frais de livraison', value: '2 500 F'),
          const SizedBox(height: 4),
          _RecapRow(label: 'Total payé', value: '452 500 F', isBold: true),
        ],
      ),
    );
  }
}

class _RecapRow extends StatelessWidget {
  final String label, value;
  final bool isBold;
  const _RecapRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)
        : VATextStyles.body;
    final valueStyle = isBold
        ? const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.primary)
        : VATextStyles.price;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: valueStyle)],
    );
  }
}

class _Etape {
  final String label, time;
  final bool done, isCurrent;
  const _Etape({required this.label, required this.time, required this.done, this.isCurrent = false});
}
