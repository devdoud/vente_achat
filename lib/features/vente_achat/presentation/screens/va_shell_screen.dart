import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/export.dart';
import 'package:achat_vente/core/injection/injection.dart';
import 'package:achat_vente/features/vente_achat/logic/export.dart';
import 'catalogue/va_home_screen.dart';
import 'activite/activite_screen.dart';
import 'activite/favoris_screen.dart';
import 'vendeur/boutique_atelier_screen.dart';
import 'vendeur/boutique_setup_screen.dart';
import 'vendeur/vendre_onboarding_screen.dart';

/// Shell persistant du module Vente & Achat.
class VAShellScreen extends StatefulWidget {
  const VAShellScreen({super.key});

  @override
  State<VAShellScreen> createState() => _VAShellScreenState();
}

class _VAShellScreenState extends State<VAShellScreen> {
  // Initialisation directe — jamais en état non initialisé, même lors d'un hot reload
  final CartCubit _cartCubit = getIt<CartCubit>();

  int _shellIndex = 0;

  @override
  void initState() {
    super.initState();
    _cartCubit.load();
  }

  @override
  void dispose() {

    super.dispose();
  }

  int get _navIndex => const [0, 2, 3][_shellIndex];

  void _onNavTap(int navIndex) {
    if (navIndex == 1) {
      _openVendre();
      return;
    }
    final newShell = switch (navIndex) {
      0 => 0,
      2 => 1,
      _ => 2,
    };
    if (newShell != _shellIndex) setState(() => _shellIndex = newShell);
  }

  Future<void> _openVendre() async {
    if (!mounted) return;
    final prefs     = await SharedPreferences.getInstance();
    final setupDone = prefs.getBool('boutique_setup_done')    ?? false;
    final onbDone   = prefs.getBool('vendre_onboarding_done') ?? false;
    final nom       = prefs.getString('boutique_name')        ?? '';
    final ville     = prefs.getString('boutique_ville')       ?? '';
    final quartier  = prefs.getString('boutique_quartier')    ?? '';
    if (!mounted) return;

    final Widget screen = setupDone
        ? BoutiqueAtelierScreen(nom: nom, ville: ville, quartier: quartier)
        : !onbDone
            ? const VendreOnboardingScreen()
            : const BoutiqueSetupScreen();

    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cartCubit,
      child: Scaffold(
      body: IndexedStack(
        index: _shellIndex,
        children: const [
          VAHomeScreen(),
          ActiviteScreen(),
          FavorisScreen(),
        ],
      ),
      bottomNavigationBar: VABottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      ),  // Scaffold
    );    // BlocProvider
  }
}
