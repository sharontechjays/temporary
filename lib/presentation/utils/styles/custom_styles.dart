import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

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

class AnimatedToggle extends StatefulWidget {
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
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor,
      ),
      child: FlutterToggleTab(
        width: MediaQuery.of(context).size.width * 0.25-2,
        height: 50,
        borderRadius: 10.0,
        selectedIndex: selectedIndex,
        selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
        selectedTextStyle: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
        unSelectedTextStyle: const TextStyle(
            color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
        labels: widget.values,
        selectedLabelIndex: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onToggleCallback(index);
        },
        isScroll: true,
      ),
    );
  }
}
