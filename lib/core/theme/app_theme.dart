// ignore_for_file: avoid_positional_boolean_parameters

import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// ---------------------------------------------------------- `COLORS`

  static Color normalColor(bool isDark) =>
      isDark ? AppColors.white : AppColors.black;

  static Color primaryColor(bool isDark) =>
      isDark ? AppColors.purple : AppColors.pink;

  static Color midPrimary(bool isDark) =>
      isDark ? AppColors.midPurple : AppColors.midPink;

  static Color scaffoldBGColor(bool isDark) =>
      isDark ? AppColors.dScaffoldBG : AppColors.lScaffoldBG;

  static Color listTileColor(bool isDark) =>
      isDark ? AppColors.dListTile : AppColors.lListTile;

  static Color borderColor(bool isDark) =>
      isDark ? AppColors.dBorder : AppColors.lBorder;

  static Color iconColor(bool isDark) =>
      isDark ? AppColors.dIcon : AppColors.lIcon;

  /// ---------------------------------------------------------- `CORE WIDGETS`

  static AppBarTheme appBarTheme(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).appBarTheme.copyWith(
          iconTheme: IconThemeData(color: primaryColor(isDark), size: 24),
          titleTextStyle: TextStyle(
            color: primaryColor(isDark),
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
  }

  static DrawerThemeData drawer(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).drawerTheme.copyWith(
          backgroundColor: scaffoldBGColor(isDark),
        );
  }

  static FloatingActionButtonThemeData floatingActionButton(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).floatingActionButtonTheme.copyWith(
          backgroundColor: isDark ? AppColors.purple : AppColors.pink,
          iconSize: 30,
        );
  }

  /// ---------------------------------------------------------- `BUTTONS`

  static ElevatedButtonThemeData elevatedButton([bool isDark = false]) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
        foregroundColor: scaffoldBGColor(isDark),
        disabledForegroundColor: primaryColor(isDark),
        backgroundColor: primaryColor(isDark),
        disabledBackgroundColor: primaryColor(isDark).withAlpha(100),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButton([bool isDark = false]) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
        foregroundColor: primaryColor(isDark),
        disabledForegroundColor: primaryColor(isDark).withAlpha(150),
        backgroundColor: primaryColor(isDark).withAlpha(50),
        disabledBackgroundColor: primaryColor(isDark).withAlpha(25),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: primaryColor(isDark), width: 1.5),
      ),
    );
  }

  static TextButtonThemeData textButton([bool isDark = false]) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        foregroundColor: primaryColor(isDark),
        disabledForegroundColor: primaryColor(isDark).withAlpha(150),
        textStyle: AppTStyles.caption,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ToggleButtonsThemeData toggleButton(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).toggleButtonsTheme.copyWith(
          selectedColor: primaryColor(isDark),
          color: normalColor(isDark),
          borderColor: primaryColor(isDark).withAlpha(100),
          selectedBorderColor: primaryColor(isDark),
          borderRadius: BorderRadius.circular(16),
          textStyle: AppTStyles.primary,
        );
  }

  /// ---------------------------------------------------------- `LIST TILES`

  static ListTileThemeData listTile(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).listTileTheme.copyWith(
          tileColor: listTileColor(isDark),
          contentPadding: const EdgeInsets.fromLTRB(17, 1, 5, 1),
          titleTextStyle: AppTStyles.body,
          iconColor: primaryColor(isDark),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        );
  }

  /// ---------------------------------------------------------- `TEXTFIELD`
  ///

  static InputDecorationTheme inputDecorationTheme(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).inputDecorationTheme.copyWith(
          labelStyle: TextStyle(color: primaryColor(isDark), fontSize: 15),
          counterStyle: TextStyle(color: midPrimary(isDark)),
          suffixIconColor: primaryColor(isDark),
          prefixIconColor: primaryColor(isDark),
          filled: true,
          fillColor: listTileColor(isDark),
          contentPadding: const EdgeInsets.all(18),
          alignLabelWithHint: true,
          //
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.transparent, width: 0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor(isDark), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        );
  }

  /// ---------------------------------------------------------- `OTHERS`

  static IconThemeData iconTheme([bool isDark = false]) {
    return const IconThemeData().copyWith(
      color: primaryColor(isDark),
      size: 28,
    );
  }

  static DividerThemeData dividerTheme([bool isDark = false]) {
    return const DividerThemeData().copyWith(
      color: primaryColor(isDark).withAlpha(50),
      space: dividerHt,
      indent: 10,
      endIndent: 10,
    );
  }

  static ProgressIndicatorThemeData progressIndicator([bool isDark = false]) {
    return ProgressIndicatorThemeData(
      color: primaryColor(isDark),
      circularTrackColor: scaffoldBGColor(isDark),
    );
  }

  // ============================== LIGHT ==============================
  // ============================== LIGHT ==============================

  static ThemeData light(BuildContext c) {
    return ThemeData.light().copyWith(
      /// -------------------------------------- `CORE`
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
      splashColor: AppColors.lSplash,
      scaffoldBackgroundColor: AppColors.lScaffoldBG,
      textTheme: Theme.of(c).textTheme.apply(bodyColor: AppColors.black),

      /// -------------------------------------- `CORE WIDGETS`
      appBarTheme: appBarTheme(c),
      floatingActionButtonTheme: floatingActionButton(c),
      drawerTheme: drawer(c),

      /// -------------------------------------- `BUTTONS`
      elevatedButtonTheme: elevatedButton(),
      outlinedButtonTheme: outlinedButton(),
      textButtonTheme: textButton(),
      toggleButtonsTheme: toggleButton(c),

      /// -------------------------------------- `LISTTILES`
      listTileTheme: listTile(c),

      /// -------------------------------------- `TEXTFIELD`
      inputDecorationTheme: inputDecorationTheme(c),

      /// -------------------------------------- `OTHERS`
      iconTheme: iconTheme(),
      dividerTheme: dividerTheme(),
      progressIndicatorTheme: progressIndicator(),
    );
  }

  // ============================== DARK ==============================
  // ============================== DARK ==============================

  static ThemeData dark(BuildContext c) {
    return ThemeData.dark().copyWith(
      /// -------------------------------------- `CORE`
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
      splashColor: AppColors.dSplash,
      scaffoldBackgroundColor: AppColors.dScaffoldBG,
      textTheme: Theme.of(c).textTheme.apply(bodyColor: AppColors.white),

      /// -------------------------------------- `CORE WIDGETS`
      appBarTheme: appBarTheme(c, true),
      floatingActionButtonTheme: floatingActionButton(c, true),
      drawerTheme: drawer(c, true),

      /// -------------------------------------- `BUTTONS`
      elevatedButtonTheme: elevatedButton(true),
      outlinedButtonTheme: outlinedButton(true),
      textButtonTheme: textButton(true),
      toggleButtonsTheme: toggleButton(c, true),

      /// -------------------------------------- `LISTTILES`
      listTileTheme: listTile(c, true),

      /// -------------------------------------- `TEXTFIELD`
      inputDecorationTheme: inputDecorationTheme(c, true),

      /// -------------------------------------- `OTHERS`
      iconTheme: iconTheme(true),
      dividerTheme: dividerTheme(true),
      progressIndicatorTheme: progressIndicator(true),
    );
  }
}
