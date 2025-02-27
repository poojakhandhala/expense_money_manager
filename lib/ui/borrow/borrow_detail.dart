import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/transction_card.dart';
import 'package:expense_money_manager/ui/borrow/borrow_addform.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BorrowDetailPage extends StatefulWidget {
  @override
  State<BorrowDetailPage> createState() => _BorrowDetailPageState();
}

class _BorrowDetailPageState extends State<BorrowDetailPage> {
  final BorrowController borrowController = Get.put(BorrowController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppBar(
          title: "borrow_lent",
          bottom: TabBar(
            labelColor: AppColors.black,
            indicatorColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyles().textStylePoppins(
              size: 14,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'given'.tr()), // First tab
              Tab(text: 'taken'.tr()), // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(
              () => ListView.builder(
                itemCount: borrowController.borrowList.length,
                itemBuilder: (context, index) {
                  final transaction = borrowController.borrowList[index];
                  if (transaction["transactionType"] == "Given") {
                    return TransactionCard(transaction: transaction);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),

            Obx(
              () => ListView.builder(
                itemCount: borrowController.borrowList.length,
                itemBuilder: (context, index) {
                  final transaction = borrowController.borrowList[index];
                  if (transaction["transactionType"] == "Taken") {
                    return TransactionCard(transaction: transaction);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => BorrowAddForm());
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
