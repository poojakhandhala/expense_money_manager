import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.hasBackButton = true,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      title:
          Text(
            title,
            style: TextStyles().textStylePoppins(
              size: 18,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
      leading:
          hasBackButton
              ? IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  Get.back();
                },
              )
              : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null
        ? kToolbarHeight
        : kToolbarHeight + bottom!.preferredSize.height,
  );
}
