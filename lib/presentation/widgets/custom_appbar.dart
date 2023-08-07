import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    this.backgroundColor = AppColors.scaffoldBackground,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(Strings.appNameBrackets),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }
}
