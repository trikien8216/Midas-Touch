import 'package:flutter/material.dart';

class AppColors {
  static const Color gold = Color(0xFFD5AA49);
  static const Color goldLight = Color(0xFFDEE49F);
  static const Color goldDark = Color(0xFFC86714);

  static const Color bg = Color(0xFFF9F9F5);
  static const Color textDark = Color(0xFF130A04);
  static const Color textMedium = Color(0xFF64300E);
  static const Color textLight = Color(0xFF79734D);

  static const Color card = Colors.white;
}

class BrandTheme extends ThemeExtension<BrandTheme> {
  final Color gold;
  final Color goldLight;
  final Color goldDark;

  const BrandTheme({
    required this.gold,
    required this.goldLight,
    required this.goldDark,
  });

  @override
  BrandTheme copyWith({
    Color? gold,
    Color? goldLight,
    Color? goldDark,
  }) {
    return BrandTheme(
      gold: gold ?? this.gold,
      goldLight: goldLight ?? this.goldLight,
      goldDark: goldDark ?? this.goldDark,
    );
  }

  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) return this;
    return BrandTheme(
      gold: Color.lerp(gold, other.gold, t)!,
      goldLight: Color.lerp(goldLight, other.goldLight, t)!,
      goldDark: Color.lerp(goldDark, other.goldDark, t)!,
    );
  }

}

TextTheme buildTextTheme(Color color) {
  return TextTheme(
    displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: color),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    bodyMedium: TextStyle(fontSize: 14, color: color),
    bodySmall: TextStyle(fontSize: 12, color: color.withOpacity(0.7)),
  );
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.bg,

  colorScheme: ColorScheme.light(
    primary: AppColors.gold,
    secondary: AppColors.goldDark,
    surface: Colors.white,
    onSurface: AppColors.textDark,
  ),

  extensions: [
    BrandTheme(
      gold: AppColors.gold,
      goldLight: AppColors.goldLight,
      goldDark: AppColors.goldDark,
    ),
  ],

  textTheme: buildTextTheme(AppColors.textDark),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.textDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.textLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gold, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.gold,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 4,
    shadowColor: Colors.black12,
    margin: EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF1A1A1A),

  colorScheme: ColorScheme.dark(
    primary: AppColors.gold,
    secondary: AppColors.goldDark,
    surface: Color(0xFF232323),
    onSurface: Colors.white,
  ),

  extensions: [
    BrandTheme(
      gold: AppColors.gold,
      goldLight: AppColors.goldLight,
      goldDark: AppColors.goldDark,
    ),
  ],

  textTheme: buildTextTheme(Colors.white),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF232323),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  cardTheme: CardThemeData(
    color: Color(0xFF2C2C2C),
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
