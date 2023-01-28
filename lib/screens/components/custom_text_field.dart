import 'package:flutter/material.dart';
import 'package:simple_validation_form/constants/colors.dart';

import '../../constants/styles.dart';

class CustomFormFields extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomFormFields({
    super.key,
    this.hintText,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      style: kTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kHintTextStyle,
        filled: true,
        fillColor: kFilledColor,
        errorStyle: const TextStyle(color: kErrorColor),
        enabledBorder: kTextOutlineBorder,
        focusedBorder: kTextOutlineBorder,
        errorBorder: kTextOutlineErrorBorder,
        focusedErrorBorder: kTextOutlineErrorBorder,
      ),
    );
  }
}
