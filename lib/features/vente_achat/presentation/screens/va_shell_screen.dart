import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/export.dart';
import 'catalogue/va_home_screen.dart';
import 'activite/activite_screen.dart';
import 'activite/favoris_screen.dart';
import 'vendeur/boutique_atelier_screen.dart';
import 'vendeur/boutique_setup_screen.dart';
import 'vendeur/vendre_onboarding_screen.dart';

const _kOnboardingDone    = 'vendre_onboarding_done';
const _kBoutiqueSetupDone = 'boutique_setup_done';
const _kBoutiqueName      = 'boutique_name';
const _kBoutiqueEmoji     = 'boutique_emoji';
const _kBoutiqueVille     = 'boutique_ville';
const _kBoutiqueQuartier  = 'boutique_quartier';

/// Shell persistant du module Vente & Achat.
///
/// Flux Vendre :
///   1ère fois          → VendreOnboardingScreen → BoutiqueSetupScreen
///   Onboarding fait,
///   Setup non fait     → BoutiqueSetupScreen
///   Tout fait          → BoutiqueAtelierScreen (hub vendeur)
class VAShellScreen extends StatefulWidget {
  const VAShellScreen({super.key});

  @override
  State<VAShellScreen> createState() => _VAShellScreenState();
}

class _VAShellScreenState extends State<VAShellScreen> {
  int _shellIndex = 0;

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
    final prefs        = await SharedPreferences.getInstance();
    final onbDone      = prefs.getBool(_kOnboardingDone)    ?? false;
    final setupDone    = prefs.getBool(_kBoutiqueSetupDone) ?? false;
    final nom      = prefs.getString(_kBoutiqueName)     ?? '';
    final emoji    = prefs.getString(_kBoutiqueEmoji)    ?? '🛍';
    final ville    = prefs.getString(_kBoutiqueVille)    ?? '';
    final quartier = prefs.getString(_kBoutiqueQuartier) ?? '';
    if (!mounted) return;

    Widget screen;
    if (!onbDone) {
      screen = const VendreOnboardingScreen();
    } else if (!setupDone) {
      screen = const BoutiqueSetupScreen();
    } else {
      screen = BoutiqueAtelierScreen(
        nom: nom, emoji: emoji,
        ville: ville, quartier: quartier,
      );
    }

    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
