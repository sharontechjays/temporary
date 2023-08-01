import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
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
