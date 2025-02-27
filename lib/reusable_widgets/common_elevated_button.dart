import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class CommonElevatedButton extends StatefulWidget {
  CommonElevatedButton({
    required this.text,
    // required this.textStyle,
    this.width = double.infinity,
    this.height = 50,
    required this.onPressed,
    required this.progressColor,
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    this.isLoading = false,
    this.icon,
    this.shape,
    super.key,
  });

  double height;
  double width;
  String text;
  // TextStyle textStyle;
  void Function() onPressed;
  bool isLoading;
  Color progressColor;
  Color backgroundColor;
  Color disabledBackgroundColor;
  IconData? icon;
  dynamic shape;

  @override
  State<CommonElevatedButton> createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: widget.backgroundColor,
          disabledBackgroundColor: widget.disabledBackgroundColor,
          elevation: 3,
          shape:
              widget.shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: widget.isLoading ? _buildProgressIndicator() : _buildRow(),
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [if (widget.icon != null) _buildIcon(), _buildText()],
    );
  }

  Widget _buildText() {
    return Text(
      widget.text,
      style: TextStyles().textStylePoppins(
        fontWeight: FontWeight.bold,
        size: 16,
        color: AppColors.white,
      ),
      // style: widget.textStyle
    );
  }

  Widget _buildIcon() {
    return Row(
      children: [
        Icon(widget.icon, size: 24, color: AppColors.white),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        color: widget.progressColor,
        strokeWidth: 2,
      ),
    );
  }
}
