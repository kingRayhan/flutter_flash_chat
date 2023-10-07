import 'package:flash_chat/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  AppTextfield(
      {Key? key,
      this.controller,
      this.onChanged,
      this.hintText = "Hint Text",
      this.obscureText = false,
      this.keyboardType,
      this.validator})
      : super(key: key);

  Function(String?)? onChanged;
  String? hintText;
  bool? obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        constraints: const BoxConstraints(minHeight: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    );
  }
}
