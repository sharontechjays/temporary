import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';

class CustomOKActionButton extends StatelessWidget {
  final String title;
  final String message;
  final String positiveLabel;
  final String negativeLabel;
  final Function positiveFunction;
  final Function negativeFunction;

  const CustomOKActionButton({
    super.key,
    required this.title,
    required this.message,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.positiveFunction,
    required this.negativeFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Text(message),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: CustomOutlinedButton(
                    positiveLabel: positiveLabel,
                    positiveFunction: positiveFunction,
                    secondaryColor: Colors.deepPurple,
                  )),
              const SizedBox(
                width: 15,
              ),
              Visibility(
                visible: negativeLabel != "",
                child: CustomElevatedButton(
                    negativeLabel: negativeLabel,
                    negativeFunction: negativeFunction),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
