import 'package:achat_vente/core/export.dart';
import 'package:achat_vente/export.dart';

abstract class ITheme {
  ThemeData get theme;
  Color get primaryColor;
  Color get secondaryColor;
  Color get tertiaryColor;
  Color get errorColor;
  Color get blackColor;
  double get defaultRadius => 12;
  double get defaultHorizontalPadding => 24;
}

class DefaultTheme implements ITheme {
  @override
  ThemeData get theme => ThemeData(
    useMaterial3: true,
    cardTheme: CardThemeData(
      shadowColor: Colors.black38,
      elevation: 2,
      margin: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        side: BorderSide(color: HexColor("#f4f4f4")),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFBF6),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      elevation: .5,
      backgroundColor: Colors.white,
      toolbarTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      shadowColor: Colors.black26,
      titleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: blackColor,
      ),
    ),
    primaryColor: primaryColor,
    tabBarTheme: TabBarThemeData(
      tabAlignment: TabAlignment.start,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ), // Pas de trait sous les titres
      labelColor: primaryColor,
      unselectedLabelColor: const Color(0xFF888888),
      dividerColor: Colors.transparent,
      dividerHeight: .25,
    ),
    dialogTheme: DialogThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: tertiaryColor,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      error: errorColor,
      onSurface: HexColor("#5F6368"),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          side: BorderSide(color: blackColor),
        ),
        overlayColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      color: HexColor("#E0E0E0"),
      thickness: 1,
      space: 0,
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
      displayMedium: const TextStyle(fontSize: 51, fontWeight: FontWeight.w700),
      displaySmall: const TextStyle(fontSize: 41, fontWeight: FontWeight.w600),
      headlineMedium: const TextStyle(
        fontSize: 29,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: blackColor,
        fontFamily: "Arsenal",
      ),
      titleMedium: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: "Arsenal",
      ),
      titleSmall: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: "Arsenal",
      ),
      bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelSmall: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      labelMedium: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        borderSide: BorderSide(color: HexColor("#DCE1E5")),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        borderSide: BorderSide(color: HexColor("#DCE1E5")),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        borderSide: BorderSide(color: errorColor),
      ),
      errorStyle: TextStyle(
        color: errorColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        color: HexColor("#5F6368"),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  @override
  Color get primaryColor => HexColor("#FF6D00"); // vert santé

  @override
  Color get secondaryColor => HexColor("#3A3A3A"); // bleu air

  @override
  Color get tertiaryColor => HexColor("#0054A3");

  @override
  Color get errorColor => HexColor("#FF6B6B"); // rouge doux pour les erreurs

  @override
  Color get blackColor => HexColor("#212121"); // gris foncé pour texte

  @override
  double get defaultRadius => 24;

  @override
  double get defaultHorizontalPadding => 22;
}
