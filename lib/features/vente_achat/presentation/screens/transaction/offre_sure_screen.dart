import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../activite/confirmation_screen.dart';

@RoutePage()
class OffreSureScreen extends StatelessWidget {
  final Annonce annonce;
  const OffreSureScreen({super.key, required this.annonce});

  static const _steps = [
    _StepItem(num: '1', title: 'Vous payez l\'achat', sub: 'Votre argent est gardé en sécurité'),
    _StepItem(num: '2', title: 'Notre livreur récupère le colis', sub: 'Chez le vendeur en moins de 24h'),
    _StepItem(num: '3', title: 'Vous vérifiez à la livraison', sub: 'Donnez votre code unique au livreur'),
    _StepItem(num: '4', title: 'Le paiement est libéré', sub: 'Le vendeur reçoit son argent après confirmation'),
  ];

  @override
  Widget build(BuildContext context) {
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
                gradient: const LinearGradient(colors: [Color(0xFF43A047), Color(0xFF66BB6A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
            _AnnonceCard(annonce: annonce),
            const SizedBox(height: 24),
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
        child: Builder(builder: (context) => VAPrimaryButton(
          label: 'Confirmer et payer ${annonce.prixFormate}',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ConfirmationScreen(
              commandeId: '2849',
              totalPaye: annonce.prix + 2500,
            ),
          )),
        )),
      ),
    );
  }
}

class _AnnonceCard extends StatelessWidget {
  final Annonce annonce;
  const _AnnonceCard({required this.annonce});

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(VARadius.sm)),
            child: Center(child: Text(annonce.categorie.emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(annonce.titre, style: VATextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Vendu par ${annonce.vendeur.nom}', style: VATextStyles.caption),
                Row(children: [const Icon(Icons.star_rounded, color: VAColors.star, size: 12), Text('${annonce.vendeur.note}', style: VATextStyles.caption)]),
              ],
            ),
          ),
          Text(annonce.prixFormate, style: VATextStyles.price),
        ],
      ),
    );
  }
}

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
            child: Center(child: Text(step.num, style: const TextStyle(fontWeight: FontWeight.w800, color: VAColors.primary, fontSize: 13))),
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
