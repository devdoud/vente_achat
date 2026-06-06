import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/page/webview_page.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../logic/export.dart';
import '../../../data/dto/wallet_dto.dart';

@RoutePage()
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late final WalletCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<WalletCubit>()..load();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<WalletCubit, WalletState>(
        listener: (ctx, state) {
          if (state is WalletTopUpReady) {
            Navigator.of(ctx).push(MaterialPageRoute(
              builder: (_) => WebViewPage(
                url:   state.paymentUrl,
                title: 'Recharger le wallet',
              ),
            )).then((_) => _cubit.load());
          } else if (state is WalletFailure) {
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
          appBar: VAAppBar(title: 'Mon Wallet'),
          body: BlocBuilder<WalletCubit, WalletState>(
            builder: (ctx, state) {
              if (state is WalletLoading || state is WalletInitial) {
                return const Center(
                    child: CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2));
              }
              if (state is WalletLoaded) {
                return _WalletContent(
                  balance:      state.balance,
                  transactions: state.transactions,
                  holds:        state.holds,
                  onTopUp:      (amount) => ctx.read<WalletCubit>().topUp(amount: amount),
                  onRefresh:    () => ctx.read<WalletCubit>().load(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

// ─── Contenu wallet ───────────────────────────────────────────────────────────

class _WalletContent extends StatelessWidget {
  final WalletBalanceDto          balance;
  final List<WalletTransactionDto> transactions;
  final List<WalletHoldDto>        holds;
  final void Function(double)      onTopUp;
  final VoidCallback               onRefresh;

  const _WalletContent({
    required this.balance,
    required this.transactions,
    required this.holds,
    required this.onTopUp,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: VAColors.primary,
      child: ListView(
        padding: const EdgeInsets.all(VAPadding.base),
        children: [
          // Carte solde
          _BalanceCard(balance: balance, onTopUp: onTopUp),
          const SizedBox(height: 20),

          // Holds en cours
          if (holds.isNotEmpty) ...[
            _SectionTitle(title: 'Blocages en cours', count: holds.length),
            const SizedBox(height: 8),
            ...holds.map((h) => _HoldTile(hold: h)),
            const SizedBox(height: 16),
          ],

          // Transactions
          _SectionTitle(title: 'Transactions', count: transactions.length),
          const SizedBox(height: 8),
          if (transactions.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text('Aucune transaction',
                  style: TextStyle(fontSize: 14, color: VAColors.grey)),
            ))
          else
            ...transactions.map((t) => _TransactionTile(transaction: t)),
        ],
      ),
    );
  }
}

// ─── Carte solde ──────────────────────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  final WalletBalanceDto     balance;
  final void Function(double) onTopUp;
  const _BalanceCard({required this.balance, required this.onTopUp});

  String get _formatted {
    final v = balance.balance;
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) {
      final e = v ~/ 1000;
      final r = (v % 1000).round();
      return r == 0 ? '$e 000' : '$e ${r.toString().padLeft(3, '0')}';
    }
    return '${v.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(VAPadding.xl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(VARadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.account_balance_wallet_outlined, color: Colors.white54, size: 16),
            SizedBox(width: 6),
            Text('Solde disponible',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ]),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_formatted,
                  style: const TextStyle(color: Colors.white, fontSize: 32,
                      fontWeight: FontWeight.w900, letterSpacing: -1)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(balance.currency ?? 'F',
                    style: const TextStyle(color: Colors.white60, fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showTopUpSheet(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: VAColors.primary,
                borderRadius: BorderRadius.circular(VARadius.xxl),
                boxShadow: [BoxShadow(
                  color: VAColors.primary.withValues(alpha: 0.4),
                  blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('Recharger', style: TextStyle(
                      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTopUpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
      builder: (_) => _TopUpSheet(onConfirm: onTopUp),
    );
  }
}

// ─── Sheet recharge ───────────────────────────────────────────────────────────

class _TopUpSheet extends StatefulWidget {
  final void Function(double) onConfirm;
  const _TopUpSheet({required this.onConfirm});
  @override
  State<_TopUpSheet> createState() => _TopUpSheetState();
}

class _TopUpSheetState extends State<_TopUpSheet> {
  final _ctrl = TextEditingController();
  static const _presets = [1000.0, 2000.0, 5000.0, 10000.0, 25000.0, 50000.0];
  double? _selected;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _submit() {
    final amount = _selected ?? double.tryParse(_ctrl.text.replaceAll(RegExp(r'\D'), ''));
    if (amount == null || amount <= 0) return;
    Navigator.of(context).pop();
    widget.onConfirm(amount);
  }

  String _fmt(double v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(v % 1000 == 0 ? 0 : 1)}k F';
    return '${v.toInt()} F';
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
          const Text('Recharger le wallet',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: VAColors.black)),
          const SizedBox(height: 4),
          const Text('Choisissez un montant ou saisissez le vôtre',
              style: TextStyle(fontSize: 13, color: VAColors.greyText)),
          const SizedBox(height: 16),

          // Montants rapides
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _presets.map((v) {
              final isSel = _selected == v;
              return GestureDetector(
                onTap: () => setState(() {
                  _selected = v;
                  _ctrl.clear();
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSel ? VAColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(VARadius.xxl),
                    border: Border.all(
                        color: isSel ? VAColors.primary : VAColors.greyBorder,
                        width: isSel ? 1.5 : 1),
                  ),
                  child: Text(_fmt(v), style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700,
                      color: isSel ? Colors.white : VAColors.black)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // Montant personnalisé
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() => _selected = null),
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'Autre montant (F)',
              hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
              suffixText: 'F',
              filled: true, fillColor: VAColors.greyLight,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(VARadius.md),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(VARadius.md),
                  borderSide: const BorderSide(color: VAColors.primary, width: 1.5)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            style: const TextStyle(fontSize: 14, color: VAColors.black, fontWeight: FontWeight.w600),
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
                  Icon(Icons.add_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 6),
                  Text('Recharger', style: TextStyle(
                      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tiles ────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final int count;
  const _SectionTitle({required this.title, required this.count});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800,
              color: VAColors.black)),
          const SizedBox(width: 8),
          if (count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('$count', style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800, color: VAColors.primaryDark)),
            ),
        ],
      );
}

class _TransactionTile extends StatelessWidget {
  final WalletTransactionDto transaction;
  const _TransactionTile({required this.transaction});

  bool get _isCredit => transaction.type.toLowerCase().contains('credit')
      || transaction.type.toLowerCase().contains('top');
  String get _amtFmt {
    final v = transaction.amount;
    final prefix = _isCredit ? '+' : '-';
    if (v >= 1000000) return '$prefix${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000) { final e = v ~/ 1000; return '$prefix${e.toInt()} ${((v % 1000).round()).toString().padLeft(3, '0')} F'; }
    return '$prefix${v.toInt()} F';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.md, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: _isCredit ? VAColors.greenLight : VAColors.redLight,
            shape: BoxShape.circle,
          ),
          child: Icon(_isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              size: 18, color: _isCredit ? VAColors.green : VAColors.red),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
          children: [
            Text(transaction.description ?? transaction.type,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.black),
                maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(_fmtDate(transaction.createdAt), style: VATextStyles.caption),
          ],
        )),
        Text(_amtFmt, style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w900,
            color: _isCredit ? VAColors.green : VAColors.red)),
      ]),
    );
  }

  static String _fmtDate(String s) {
    final dt = DateTime.tryParse(s);
    if (dt == null) return s;
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _HoldTile extends StatelessWidget {
  final WalletHoldDto hold;
  const _HoldTile({required this.hold});

  @override
  Widget build(BuildContext context) {
    final v = hold.amount;
    final amt = v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}k F' : '${v.toInt()} F';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: VAPadding.md, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(children: [
        const Icon(Icons.lock_clock_outlined, color: Color(0xFFF57C00), size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(hold.reason ?? 'Montant bloqué',
            style: const TextStyle(fontSize: 13, color: VAColors.black))),
        Text(amt, style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFF57C00))),
      ]),
    );
  }
}
