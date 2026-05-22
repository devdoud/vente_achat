import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/va_theme.dart';
import '../transaction/suivi_commande_screen.dart';

@RoutePage()
class ConfirmationScreen extends StatefulWidget {
  final String commandeId;
  final double totalPaye;
  const ConfirmationScreen({
    super.key,
    required this.commandeId,
    required this.totalPaye,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with TickerProviderStateMixin {
  static const _code = ['7', '2', '4', '9'];

  late final AnimationController _checkCtrl;
  late final AnimationController _cardCtrl;
  late final Animation<double> _checkScale;
  late final Animation<double> _cardFade;
  late final Animation<Offset>  _cardSlide;

  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _checkCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 550));
    _cardCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    _checkScale = CurvedAnimation(
        parent: _checkCtrl, curve: Curves.elasticOut);
    _cardFade   = CurvedAnimation(
        parent: _cardCtrl, curve: Curves.easeOut);
    _cardSlide  = Tween<Offset>(
            begin: const Offset(0, 0.10), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _cardCtrl, curve: Curves.easeOutCubic));

    _checkCtrl.forward().then((_) => _cardCtrl.forward());
  }

  @override
  void dispose() {
    _checkCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _code.join()));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            //  Header 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  const Expanded(
                    child: Text(
                      'Confirmation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: VAColors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        size: 20, color: VAColors.greyText),
                    onPressed: () =>
                        Navigator.of(context).popUntil((r) => r.isFirst),
                  ),
                ],
              ),
            ),

            //  Icône succès 
            Expanded(
              flex: 3,
              child: Center(
                child: ScaleTransition(
                  scale: _checkScale,
                  child: const _SuccessIcon(),
                ),
              ),
            ),

            //  Titre + sous-titre 
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Achat confirmé !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: VAColors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Paiement sécurisé. Donnez ce code\nau livreur à la réception.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        color: VAColors.greyText,
                        height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  Carte code 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SlideTransition(
                position: _cardSlide,
                child: FadeTransition(
                  opacity: _cardFade,
                  child: _CodeCard(
                    code: _code,
                    copied: _copied,
                    onCopy: _copyCode,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            //  Récap 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FadeTransition(
                opacity: _cardFade,
                child: _RecapCard(
                  commandeId: widget.commandeId,
                  totalPaye: widget.totalPaye,
                ),
              ),
            ),

            const Spacer(flex: 2),

            //  CTA 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SuiviCommandeScreen(
                        commandeId: widget.commandeId),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: VAColors.primary.withValues(alpha: 0.26),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_shipping_outlined,
                          color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('Suivre ma commande',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            //  Retour accueil 
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "Retour à l'accueil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: VAColors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 
//  ICÔNE SUCCÈS
// 

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110, height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110, height: 110,
            decoration: BoxDecoration(
              color: VAColors.green.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 78, height: 78,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3343A047),
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.check_rounded,
                color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}

// 
//  CARTE CODE — dark premium, sans overflow
// 

class _CodeCard extends StatelessWidget {
  final List<String> code;
  final bool copied;
  final VoidCallback onCopy;
  const _CodeCard(
      {required this.code, required this.copied, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C1E), Color(0xFF2A2A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield_outlined, size: 12,
                  color: Colors.white.withValues(alpha: 0.45)),
              const SizedBox(width: 6),
              Text('CODE DE LIVRAISON',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: Colors.white.withValues(alpha: 0.45))),
            ],
          ),

          const SizedBox(height: 16),

          // Chiffres — utilise LayoutBuilder pour éviter l'overflow
          LayoutBuilder(builder: (_, constraints) {
            // Taille adaptée à la largeur disponible
            final tileW = ((constraints.maxWidth - 24) / 4 - 8)
                .clamp(44.0, 64.0);
            final tileH = tileW * 1.18;
            final fontSize = tileW * 0.58;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < code.length; i++) ...[
                  _DigitTile(
                      digit: code[i],
                      width: tileW,
                      height: tileH,
                      fontSize: fontSize),
                  if (i == 1) ...[
                    const SizedBox(width: 4),
                    Container(
                        width: 8, height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(1),
                        )),
                    const SizedBox(width: 4),
                  ] else if (i < code.length - 1)
                    const SizedBox(width: 8),
                ],
              ],
            );
          }),

          const SizedBox(height: 16),

          // Validité + copier
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 6, height: 6,
                      decoration: const BoxDecoration(
                          color: VAColors.green, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Valable 24h',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.60),
                          fontWeight: FontWeight.w500)),
                ],
              ),
              GestureDetector(
                onTap: onCopy,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: copied
                        ? VAColors.green.withValues(alpha: 0.18)
                        : Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: copied
                          ? VAColors.green.withValues(alpha: 0.35)
                          : Colors.white.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        copied ? Icons.check_rounded : Icons.copy_rounded,
                        size: 12,
                        color: copied
                            ? VAColors.green
                            : Colors.white.withValues(alpha: 0.75),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        copied ? 'Copié !': 'Copier',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: copied
                                ? VAColors.green
                                : Colors.white.withValues(alpha: 0.75)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DigitTile extends StatelessWidget {
  final String digit;
  final double width, height, fontSize;
  const _DigitTile({
    required this.digit,
    required this.width,
    required this.height,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.11), width: 1),
        ),
        child: Center(
          child: Text(
            digit,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1),
          ),
        ),
      );
}

// 
//  RÉCAP COMMANDE
// 

class _RecapCard extends StatelessWidget {
  final String commandeId;
  final double totalPaye;
  const _RecapCard(
      {required this.commandeId, required this.totalPaye});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: VAColors.primaryLight,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.receipt_outlined,
                size: 18, color: VAColors.primaryDark),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Commande',
                    style: TextStyle(
                        fontSize: 11,
                        color: VAColors.grey,
                        fontWeight: FontWeight.w500)),
                Text('#$commandeId',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: VAColors.black)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total payé',
                  style: TextStyle(
                      fontSize: 11,
                      color: VAColors.grey,
                      fontWeight: FontWeight.w500)),
              Text('${totalPaye.toInt()} F',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: VAColors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
