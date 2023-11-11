import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Color buttonBgColor;
  final Color buttonBorderColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.btnText,
    this.buttonBgColor = Colors.cyanAccent,
    this.buttonBorderColor = Colors.cyan,
    this.textColor = Colors.black54,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 2,
          backgroundColor: buttonBgColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: buttonBgColor),
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        ),
        child: Text(
          btnText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
