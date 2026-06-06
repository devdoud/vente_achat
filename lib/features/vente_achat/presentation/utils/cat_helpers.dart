import 'package:flutter/material.dart';
import '../../domain/annonce.dart';

IconData catIcon(AnnonceCategorie cat) => switch (cat) {
      AnnonceCategorie.telephones => Icons.phone_android_outlined,
      AnnonceCategorie.mode       => Icons.checkroom_outlined,
      AnnonceCategorie.maison     => Icons.home_outlined,
      AnnonceCategorie.auto       => Icons.directions_car_outlined,
      AnnonceCategorie.beaute     => Icons.face_outlined,
      AnnonceCategorie.hightech   => Icons.computer_outlined,
      AnnonceCategorie.sport      => Icons.sports_soccer_outlined,
      AnnonceCategorie.livres     => Icons.menu_book_outlined,
    };

Color catBg(AnnonceCategorie cat) => switch (cat) {
      AnnonceCategorie.telephones => const Color(0xFFD6EBFF),
      AnnonceCategorie.mode       => const Color(0xFFFFDDE9),
      AnnonceCategorie.maison     => const Color(0xFFD9F2DD),
      AnnonceCategorie.auto       => const Color(0xFFFFF0C2),
      AnnonceCategorie.beaute     => const Color(0xFFF0DCF9),
      AnnonceCategorie.hightech   => const Color(0xFFD4F0FC),
      AnnonceCategorie.sport      => const Color(0xFFD6F5E3),
      AnnonceCategorie.livres     => const Color(0xFFFFEBCC),
    };

Color catIconColor(AnnonceCategorie cat) => switch (cat) {
      AnnonceCategorie.telephones => const Color(0xFF1565C0),
      AnnonceCategorie.mode       => const Color(0xFFAD1457),
      AnnonceCategorie.maison     => const Color(0xFF2E7D32),
      AnnonceCategorie.auto       => const Color(0xFFE65100),
      AnnonceCategorie.beaute     => const Color(0xFF6A1B9A),
      AnnonceCategorie.hightech   => const Color(0xFF1B5E20),
      AnnonceCategorie.sport      => const Color(0xFF1A237E),
      AnnonceCategorie.livres     => const Color(0xFF4E342E),
    };
