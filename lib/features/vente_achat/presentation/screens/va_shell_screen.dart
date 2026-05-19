import 'package:flutter/material.dart';
import '../widgets/export.dart';
import 'catalogue/va_home_screen.dart';
import 'activite/activite_screen.dart';
import 'activite/favoris_screen.dart';
import 'vendeur/vendre_choix_screen.dart';

/// Shell persistant du module Vente & Achat.
///
/// Flux Vendre → VendreChoixScreen (choix particulier vs boutique)
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
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const VendreChoixScreen(),
      ),
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
