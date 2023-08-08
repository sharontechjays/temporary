import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';

import 'custom_dimens.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key,
    required this.positiveLabel,
    required this.positiveFunction,
    required this.secondaryColor});

  final String positiveLabel;
  final Color secondaryColor;
  final Function positiveFunction;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(width: 1, color: secondaryColor),
      ),
      child: Text(positiveLabel),
      onPressed: () {
        positiveFunction();
        Navigator.of(context).pop();
      },
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.negativeLabel,
    required this.negativeFunction,
  });

  final String negativeLabel;
  final Function negativeFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)))),
        child: Text(negativeLabel),
        onPressed: () {
          negativeFunction();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class MyMaterialButton extends StatelessWidget {
  const MyMaterialButton({
    super.key,
    required this.onClickButton(BuildContext context),
  });

  final void Function(BuildContext context) onClickButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClickButton(context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: const Center(
            child: Text(
              'Get Started',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}

class AnimatedToggle extends StatelessWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const AnimatedToggle({
    Key? key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: values.length,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: TabBar(
          tabs: List.generate(
            values.length,
                (index) =>
                Tab(
                  child: Text(
                    values[index],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
          ),
          onTap: (index) => onToggleCallback(index),
          indicatorColor: AppColors.secondaryColor,
          labelColor: AppColors.secondaryColor,
          unselectedLabelColor: Colors.black87,
          labelStyle:
          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key,
    required TextEditingController myController,
    required this.title,
    required this.hintText})
      : _myController = myController;

  final TextEditingController _myController;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dimenHeight32,
        Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ),
        TextFormField(
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              ),
              hintText: hintText,
              hintStyle: hintStyle,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              )),
          keyboardType: TextInputType.text,
          controller: _myController,
        ),
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,
    required this.text,
    required this.onClickButton(BuildContext context)});

  final String text;
  final void Function(BuildContext context) onClickButton;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onClickButton(context);
        },
        style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.secondaryColor,
          ),
        ));
  }
}

class ScreenHeading extends StatelessWidget {
  final String title;

  const ScreenHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: screenTitle,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPrimaryButtonClicked(BuildContext context)
  });

  final String title;
  final Function(BuildContext context) onPrimaryButtonClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPrimaryButtonClicked(context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child:  Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: screenTitle,
    );
  }
}

var screenTitle = const TextStyle(fontSize: 33.0, fontWeight: FontWeight.w700);
var hintStyle = const TextStyle(color: AppColors.hintColor);
