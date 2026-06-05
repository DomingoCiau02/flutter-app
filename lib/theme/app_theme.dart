import 'package:flutter/material.dart';

import 'theme_color.dart';

class AppTheme {
  static const Color primary = AppColorsLightTheme.primary;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: AppColorsLightTheme.primary,
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColorsLightTheme.darkBlue, size: 30),
      titleTextStyle: TextStyle(color: AppColorsLightTheme.darkBlue, fontSize: 28),
    ),
    scaffoldBackgroundColor: AppColorsLightTheme.background,
    listTileTheme: ListTileThemeData(
      tileColor: AppColorsLightTheme.white, // Color de fondo del ListTile
      contentPadding: const EdgeInsets.all(2), // Relleno del contenido del ListTile
      dense: true, // Establece el ListTile como denso
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Borde redondeado del ListTile
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColorsLightTheme.white),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColorsLightTheme.darkGrey,
      suffixIconColor: AppColorsLightTheme.primary,
      fillColor: AppColorsLightTheme.white,
      filled: true,
      iconColor: AppColorsLightTheme.primary,
      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      floatingLabelStyle: const TextStyle(color: AppColorsLightTheme.primary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent, width: 2)),
      // prefixIcon: Icon( Icons.verified_user_outlined ),
    ),
    snackBarTheme: const SnackBarThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 80, 80, 80),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shadowColor: AppColorsLightTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2.5,
      color: AppColorsLightTheme.white,
      textStyle: const TextStyle(color: AppColorsLightTheme.darkBlue, fontSize: 18),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: AppColorsLightTheme.primary, fontSize: 18),
      menuStyle: MenuStyle(
        maximumSize: MaterialStateProperty.all(Size.infinite),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColorsLightTheme.white,
        filled: true,
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        floatingLabelStyle: TextStyle(color: AppColorsLightTheme.primary),
        outlineBorder: BorderSide(color: Colors.transparent, width: 2),
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 2, color: AppColorsLightTheme.grey, indent: 15, endIndent: 15),
    navigationBarTheme: const NavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.blueGrey,
      surfaceTintColor: Colors.amber,
      indicatorColor: Colors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Color.fromARGB(151, 255, 255, 255),
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: Colors.blueGrey,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Color primario
    primaryColor: AppColorsDarkTheme.primary,

    // AppBar Theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
    scaffoldBackgroundColor: Colors.black,
  );
}
