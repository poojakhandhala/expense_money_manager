import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class InterestDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: 'given_interest'),
      body: Center(
        child:
            Text(
              "no_given_data",
              style: TextStyles().textStylePoppins(
                size: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
      ),
    );
  }
}
