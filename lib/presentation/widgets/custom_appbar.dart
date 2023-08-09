import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/utils.dart';

import '../utils/styles/custom_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Function(BuildContext context) onAppbarRightButtonClicked;
  final String title;

  const CustomAppBar(
      {Key? key,
      this.title = "Sign up",
      this.backgroundColor = AppColors.scaffoldBackground,
      required this.onAppbarRightButtonClicked(BuildContext context)})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Utils().getPlatformName() == "Android"
              ? const SizedBox(
                  height: 20,
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              /*     const Center(child: Text(Strings.appNameBrackets)),*/
              const Expanded(
                flex: 2,
                child: Center(
                    child: Image(
                        image: AssetImage(
                            'assets/drawables/bracketology_banner.png'))),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: title,
                    onClickButton: onAppbarRightButtonClicked,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }
}
