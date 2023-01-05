import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.textEditingController,
    Key? key,
    this.labelText,
    this.onFieldSubmitted,
    this.cursorColor,
    this.autoValidateMode,
    this.keyBoardType,
    this.validate,
  }) : super(key: key);
  final TextInputType? keyBoardType;
  final String? Function(String? value)? validate;
  final void Function(String? value)? onFieldSubmitted;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController textEditingController;
  final Color? cursorColor;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      validator: validate,
      autovalidateMode: autoValidateMode,
      controller: textEditingController,
      cursorColor: cursorColor,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
