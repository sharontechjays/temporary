import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';

import '../constants/app_strings.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {super.key, required this.onResendClicked(BuildContext context)});

  final Function(BuildContext context) onResendClicked;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  int _seconds = 59;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: _seconds > 0,
          child: ScreenSubHeading(
            text: _seconds > 0
                ? Strings.verifyTimerText + formatTime(_seconds)
                : '00:00',
          ),
        ),
        if (_seconds == 0)
          RichText(
            text: TextSpan(
              style: subHeadingStyle,
              children: [
                const TextSpan(text: Strings.verifyTimerText2),
                TextSpan(
                  text: Strings.resendCode,
                  style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onResendClicked(context);
                    },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
