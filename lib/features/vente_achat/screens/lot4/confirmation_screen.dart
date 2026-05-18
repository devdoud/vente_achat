import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';
import '../lot2/suivi_commande_screen.dart';

@RoutePage()
class ConfirmationScreen extends StatelessWidget {
  final String commandeId;
  final double totalPaye;
  const ConfirmationScreen({super.key, required this.commandeId, required this.totalPaye});

  static const _code = ['7', '2', '4', '9'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VAColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: const Icon(Icons.close, color: VAColors.black), onPressed: () => Navigator.of(context).pop())],
        backgroundColor: VAColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VAPadding.xl),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _SuccessIcon(),
            const SizedBox(height: 24),
            const Text('Achat confirmé !', style: VATextStyles.displayTitle),
            const SizedBox(height: 8),
            const Text(
              'Votre paiement est en sécurité.\nDonnez ce code au livreur à la réception.',
              textAlign: TextAlign.center,
              style: VATextStyles.body,
            ),
            const SizedBox(height: 32),
            _CodeCard(code: _code),
            const SizedBox(height: 24),
            _RecapCard(commandeId: commandeId, totalPaye: totalPaye),
            const SizedBox(height: 32),
            VAPrimaryButton(
              label: 'Suivre ma commande →',
              backgroundColor: VAColors.cardBlack,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SuiviCommandeScreen(commandeId: commandeId),
              )),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Text("Retour à l'accueil", style: TextStyle(color: VAColors.grey, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            color: VAColors.green.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF43A047), Color(0xFF66BB6A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(VARadius.xl),
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
        ),
        Positioned(top: 4, left: 12, child: Text('🎉', style: const TextStyle(fontSize: 22))),
        Positioned(top: 4, right: 12, child: Text('⭐', style: const TextStyle(fontSize: 18))),
        Positioned(bottom: 4, left: 8, child: Text('🎊', style: const TextStyle(fontSize: 20))),
      ],
    );
  }
}

class _CodeCard extends StatelessWidget {
  final List<String> code;
  const _CodeCard({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VAPadding.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.lg),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Column(
        children: [
          const Text('CODE DE LIVRAISON', style: VATextStyles.stepLabel),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: code.map((digit) => _DigitBox(digit: digit)).toList(),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: VAColors.grey),
              SizedBox(width: 6),
              Text('Valable pendant 24h', style: VATextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _DigitBox extends StatelessWidget {
  final String digit;
  const _DigitBox({required this.digit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62, height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: VAColors.greyLight,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Center(
        child: Text(digit, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: VAColors.black)),
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  final String commandeId;
  final double totalPaye;
  const _RecapCard({required this.commandeId, required this.totalPaye});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.base),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('COMMANDE', style: VATextStyles.label),
            Text('#$commandeId', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: VAColors.black)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text('TOTAL PAYÉ', style: VATextStyles.label),
            Text('${totalPaye.toInt()} F', style: VATextStyles.price),
          ]),
        ],
      ),
    );
  }
}
