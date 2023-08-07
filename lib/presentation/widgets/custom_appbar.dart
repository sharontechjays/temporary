import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/utils.dart';

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
      title:  Column(
        children: [
          Utils().getPlatformName()=="Android"?const SizedBox(height: 20,):const SizedBox(),
          const Center(child: Text(Strings.appNameBrackets)),
        ],
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }
}
