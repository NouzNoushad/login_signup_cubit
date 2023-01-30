import 'package:flutter/material.dart';

import 'colors.dart';

InputBorder kTextOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(color: kBorderColor, width: 3),
);

InputBorder kTextOutlineErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: kErrorColor, width: 3),
);

TextStyle kHintTextStyle = const TextStyle(
  color: kPrimaryColor,
);

TextStyle kTextStyle = TextStyle(
  color: kBorderColor,
);

SizedBox kSizedBoxHeight10 = const SizedBox(
  height: 10,
);

SizedBox kSizedBoxHeight25 = const SizedBox(
  height: 25,
);

SizedBox kSizedBoxWidth15 = const SizedBox(
  width: 15,
);

EdgeInsets kPaddingAll10 = const EdgeInsets.all(10);

EdgeInsets kPaddingHorizontal10 = const EdgeInsets.symmetric(horizontal: 10);

EdgeInsets kPaddingVertical10 = const EdgeInsets.symmetric(vertical: 10);
