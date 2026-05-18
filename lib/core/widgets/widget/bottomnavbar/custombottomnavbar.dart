import 'package:achat_vente/export.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, this.onTap});

  void _onItemTapped(int index) {
    if (index == currentIndex) {
      return;
    }
    onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Assistant'),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_outline_rounded),
          label: 'Humeur',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.source_outlined),
          label: 'Ressource',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
