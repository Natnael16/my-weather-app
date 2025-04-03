import 'package:flutter/material.dart';

const primaryColor = Color(0xFFFF5700);

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
  ),
  fontFamily: 'CircularStd',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'FuturaCondensedExtraBoldOblique',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'CircularStd',
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: 'CircularStd',
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      fontFamily: 'CircularStd',
      color: Colors.black,
    ),
  ),
  useMaterial3: true,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white, // Set the background color to white
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        // For both selected and unselected states, return white.
        return Colors.white;
      },
    ),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        return Colors.transparent;
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        return states.contains(WidgetState.selected)
            ? primaryColor
            : const Color(0xFFE2E2E2);
      },
    ),
    thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.circle,
            size: 32,
            color: Colors.white,
          );
        }
        return const Icon(
          Icons.circle,
          size: 32,
          color: Colors.white,
        );
      },
    ),
  ),
);
