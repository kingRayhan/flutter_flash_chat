import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.amber,
    this.textcolor = Colors.black,
  });

  String label;
  VoidCallback onPressed;
  Color color;
  Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          label,
          style: TextStyle(fontSize: 22.0, color: textcolor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
