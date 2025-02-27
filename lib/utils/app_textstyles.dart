import 'package:expense_money_manager/utils/app_color.dart';
import 'package:flutter/material.dart';

class TextStyles {
  TextStyle textStylePoppins({
    double size = 14,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: size,
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }
}
