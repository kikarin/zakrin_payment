import 'package:flutter/material.dart';

class AppTheme {
  // Menetapkan warna yang diberikan
  static const Color colorPrimary = Color(0xFF1B4399);  // Biru Tua
  static const Color colorSecondary = Color(0xFF2F394E);  // Abu-abu Tua
  static const Color colorAccent = Color(0xFF3642DA);  // Biru Terang
  static const Color colorSuccess = Color(0xFF5ABF73);  // Hijau Terang
  static const Color colorError = Color(0xFFFF364A);  // Merah Terang
  static const Color colorWhite = Colors.white;
  static const Color colorLightGray = Color(0xFFF7F7F7);  // Abu-abu Muda
  static const Color colorDarkGray = Color(0xFF2F394E);  // Abu-abu Gelap
  static const Color colorGradientStart = Color(0xFF000000);  // Hitam
  static const Color colorGradientEnd = Color(0xFFFFFFFF);  // Putih

  // Gradient hitam-putih
  static const LinearGradient gradientBlackWhite = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colorGradientStart, // Hitam
      colorGradientEnd,   // Putih
    ],
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colorSecondary),
      bodyMedium: TextStyle(color: colorSecondary),
      titleLarge: TextStyle(color: colorSecondary),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colorAccent,  // Tombol menggunakan warna biru terang
    ),
    primaryColor: colorAccent,  // Warna utama aplikasi
    iconTheme: IconThemeData(color: colorWhite),  // Ikon putih
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorAccent, // Tombol dengan warna biru terang
        foregroundColor: colorWhite, // Teks tombol putih
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    // Menggunakan gradient hitam-putih pada beberapa elemen
    cardTheme: CardTheme(
      color: Colors.transparent,
      elevation: 5,
      shadowColor: colorDarkGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    // Replace backgroundColor with colorScheme
    colorScheme: ColorScheme.light(
      background: colorSecondary,
    ),
  );

  // Tema gelap
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: colorSecondary,
    appBarTheme: AppBarTheme(
      backgroundColor: colorPrimary,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colorWhite),
      bodyMedium: TextStyle(color: colorWhite),
      titleLarge: TextStyle(color: colorWhite),
    ),
    primaryColor: colorAccent,
    iconTheme: IconThemeData(color: colorWhite),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorAccent,
        foregroundColor: colorWhite,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
