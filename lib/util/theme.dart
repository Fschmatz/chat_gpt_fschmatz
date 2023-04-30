import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFBFF),
    scaffoldBackgroundColor: const Color(0xFFFFFBFF),
    colorScheme: const ColorScheme.light(
        primary: Color(0xFF984066),
        onSecondary: Color(0xFF050505),
        secondary: Color(0xFF984066),
        primaryContainer: Color(0xFFF5A4BC),
        secondaryContainer: Color(0xFFFFE2E7)),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFFFFFBFF),
      color: Color(0xFFFFFBFF),
    ),
    listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: const Color(0xFF454546)),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFFFFBFF),
      color: Color(0xFFFFFBFF),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFFFFFBFE),
      backgroundColor: Color(0xFFFFFBFE),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFF6EDF4),
        filled: true,
        focusColor: const Color(0xFF984066),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF984066),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF6EDF4),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF6EDF4),
          ),
          borderRadius: BorderRadius.circular(16),
        )),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFFFFFBFF),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFF6F2F6),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFFFFBFF)),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFFFFFBFF),
      indicatorColor: Color(0xFF984066),
    ));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1F1A1D),
    scaffoldBackgroundColor: const Color(0xFF1F1A1D),
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFADE0),
        onPrimary: Color(0xFF600D41),
        onSecondary: Color(0xFFCACACA),
        secondary: Color(0xFFFFADE0),
        primaryContainer: Color(0xFF57404D),
        secondaryContainer: Color(0xFF31262D)),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF343038),
      color: Color(0xFF343038),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFF1F1A1D),
      color: Color(0xFF1F1A1D),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFF31262D),
      backgroundColor: Color(0xFF31262D),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFF31262D),
    ),
    listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: const Color(0xFFE2E2E9)),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF373034),
        filled: true,
        focusColor: const Color(0xFFFFADE0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFFADE0),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF373034),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF373034),
          ),
          borderRadius: BorderRadius.circular(12),
        )),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF363034),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1F1A1D)),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF1F1A1D),
      indicatorColor: Color(0xFF600D41),
    ));
