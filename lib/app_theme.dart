import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';

class AppTheme {
  static ThemeData themeData() {
    const MaterialColor mamaPink = MaterialColor(
      0xFFFE9BC0,
      <int, Color>{
        50: Color(0xFF23395d),
        100: Color(0xFF23395d),
        200: Color(0xFF23395d),
        300: Color(0xFF23395d),
        400: Color(0xFF23395d),
        500: Color(0xFF23395d),
        600: Color(0xFF23395d),
        700: Color(0xFF23395d),
        800: Color(0xFF23395d),
        900: Color(0xFF23395d),
      },
    );

    return ThemeData(
      // ignore: unrelated_type_equality_checks
      primaryColor: AppColors.Primary_purple,
      // Colors.pinkAccent,
      // ignore: unrelated_type_equality_checks
      primaryColorLight: AppColors.Secondary_purple,
      backgroundColor: Colors.black,
      splashColor: const Color(0xFF302b63),
      primarySwatch: mamaPink,
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.splash_blue,
      ),
    );
  }

  static ThemeData calendarThemeData() => themeData().copyWith(
        hintColor: themeData().primaryColor,
      );

  static ThemeData antenatalThemeData() => themeData().copyWith(
        tabBarTheme: TabBarTheme(
            labelColor: themeData().primaryColor,
            labelStyle: TextStyle(
              fontSize: 18,
              color: themeData().primaryColor,
            ),
            indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 2, color: themeData().primaryColor),
                insets: const EdgeInsets.symmetric(horizontal: 10)),
            unselectedLabelColor: const Color(0x4d000000),
            labelPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
            unselectedLabelStyle: const TextStyle(
              fontSize: 18,
            )),
      );
}
