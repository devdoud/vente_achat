import 'package:flutter/material.dart';

abstract final class VAColors {
  static const Color primary = Color(0xFFFFC146);
  static const Color primaryLight = Color(0xFFFFF8E1);
  static const Color primaryDark = Color(0xFFE6A800);
  static const Color background = Color(0xFFFAF8F5);
  static const Color surface = Colors.white;
  static const Color black = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF888888);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyBorder = Color(0xFFE8E8E8);
  static const Color greyText = Color(0xFF666666);
  static const Color green = Color(0xFF4CAF50);
  static const Color greenLight = Color(0xFFE8F5E9);
  static const Color blue = Color(0xFF2196F3);
  static const Color blueLight = Color(0xFFE3F2FD);
  static const Color red = Color(0xFFFF3B30);
  static const Color redLight = Color(0xFFFFEBEE);
  static const Color purple = Color(0xFF9C27B0);
  static const Color purpleLight = Color(0xFFF3E5F5);
  static const Color star = Color(0xFFFFC107);
  static const Color cardBlack = Color(0xFF1C1C1E);
}

abstract final class VARadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class VAPadding {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class VATextStyles {
  static const TextStyle displayTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: VAColors.black,
    fontFamily: 'Arsenal',
    height: 1.2,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: VAColors.black,
    fontFamily: 'Arsenal',
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: VAColors.black,
  );

  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: VAColors.primary,
  );

  static const TextStyle priceStrike = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: VAColors.grey,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: VAColors.grey,
  );

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: VAColors.grey,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: VAColors.greyText,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: VAColors.black,
  );

  static const TextStyle stepLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: VAColors.primary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.3,
  );
}
