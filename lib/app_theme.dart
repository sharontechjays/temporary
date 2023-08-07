import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/utils.dart';

class AppTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.secondaryColor,
      splashColor: const Color(0xFF302b63),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
            fontFamily: 'Nunito',
          ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Utils().createMaterialColor(AppColors.primaryColor)),
    );
  }
}
