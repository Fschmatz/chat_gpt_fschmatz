import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFBFE),
    scaffoldBackgroundColor: const Color(0xFFFFFBFE),
    colorScheme: ColorScheme.light(
      primary: Colors.purple.shade400,
      onSecondary: const Color(0xFF050505),
      secondary: Colors.purple.shade400,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFFFFFBFE),
      color: Color(0xFFFFFBFE),
    ),
    listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: const Color(0xFF454546)),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFF0EAF4),
      color: Color(0xFFF0EAF4),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFFFFFBFE),
      backgroundColor: Color(0xFFFFFBFE),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFF3EDF7),
        filled: true,
        focusColor: Colors.purple.shade300,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.purple.shade300,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE2E2E9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE2E2E9),
          ),
          borderRadius: BorderRadius.circular(16),
        )),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFFE9E5E9),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF4F0F4)),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFFFFFBFE),
      indicatorColor: Colors.purple.shade300,
    ));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1C1B1F),
    scaffoldBackgroundColor: const Color(0xFF1C1B1F),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFEFADFC),
      onPrimary: Color(0xFF4D155F),
      onSecondary: Color(0xFFCACACA),
      secondary: Color(0xFFEFADFC),
    ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF343038),
      color: Color(0xFF343038),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFF1C1B1F),
      color: Color(0xFF1C1B1F),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFF29282A),
      backgroundColor: Color(0xFF29282A),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFF29282A),
    ),
    listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: const Color(0xFFE2E2E9)),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF343038),
        filled: true,
        focusColor: const Color(0xFFEFADFC),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFEFADFC),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF454349),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF454349),
          ),
          borderRadius: BorderRadius.circular(50),
        )),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1C1B1F)),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF1C1B1F),
      indicatorColor: Color(0xFF672f77),
    ));
