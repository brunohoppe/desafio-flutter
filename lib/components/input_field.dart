import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final TextEditingController controller;
  const InputField({
    Key key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
              suffixIcon: suffixIcon != null ? suffixIcon : null,
              prefixIcon: prefixIcon != null ? prefixIcon : null,
              hintText: hintText,
              border: OutlineInputBorder()),
        ));
  }
}
