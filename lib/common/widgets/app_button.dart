import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.amber,
    this.textcolor = Colors.black,
    this.loading = false,
  });

  String label;
  VoidCallback onPressed;
  Color color;
  Color? textcolor;
  bool? loading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading!,
      child: InkWell(
        onTap: onPressed,
        child: AnimatedOpacity(
          opacity: loading! ? .4 : 1,
          duration: Duration(milliseconds: 300),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading!
                    ? const SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : Container(),
                loading! ? const SizedBox(width: 12) : Container(),
                Text(
                  label,
                  style: TextStyle(fontSize: 22.0, color: textcolor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
