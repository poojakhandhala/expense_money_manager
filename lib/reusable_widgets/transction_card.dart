import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/balance_page.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller2.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionCard extends StatefulWidget {
  final Map<String, dynamic> transaction;

  final int index;
  const TransactionCard({required this.transaction, required this.index});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final CustomerController customerController = Get.find<CustomerController>();
  // final BorrowController borrowController = Get.find<BorrowController>();
  final BorrowController2 borrowController2 = Get.find<BorrowController2>();

  @override
  Widget build(BuildContext context) {
    int givenAmount = widget.transaction["givenAmount"] ?? 0;
    int takenAmount = widget.transaction["takenAmount"] ?? 0;
    int balance = givenAmount - takenAmount;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      shape: RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Date: ${transaction["date"]}",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // customerName,
                      // widget.transaction["customer"],
                      widget.transaction["name"] ?? "Unknown",
                      // widget.transaction["customer"]?.toString() ??
                      //     "Unknown Customer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyles().textStylePoppins(
                        size: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Pending Balance: ₹$balance",
                      style: TextStyles().textStylePoppins(
                        size: 14,
                        fontWeight: FontWeight.w500,
                        // color: balance < 0 ? Colors.red : Colors.green,
                      ),
                    ).tr(),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => openWhatsApp(widget.transaction),
                  child: Image.asset(
                    AssetsPath.whatsapp,
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTransactionButton('Given', true, widget.index),
                const SizedBox(width: 10),
                _buildTransactionButton('Taken', false, widget.index),
                SizedBox(width: 70),
                GestureDetector(
                  child: Icon(Icons.delete, color: AppColors.primaryColor),
                  onTap: () => showDeleteDialog(widget.index),
                ),
              ],
            ),
            // Text(
            //   "Amount: ₹${transaction["amount"]}",
            //   style: TextStyle(
            //     color:
            //         transaction["transactionType"] == "Given"
            //             ? Colors.green
            //             : Colors.red,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionButton(String label, bool isGiven, int index) {
    return SizedBox(
      height: 40,
      width: 100,
      child: CommonElevatedButton(
        onPressed: () async {
          Map<String, dynamic> updatedTransaction = await Get.to(
            () => UpdateBalancePage(
              customer: widget.transaction,
              isGiven: isGiven,
            ),
          );
        },
        text: label.tr(),
        backgroundColor: AppColors.primaryColor,
        progressColor: AppColors.white,
        disabledBackgroundColor: AppColors.grey,
      ),
    );
  }

  void showDeleteDialog(int index) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: AppColors.transparent,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsPath.delete, height: 40, width: 40),
                SizedBox(height: 20),
                Text(
                  "delete_subtitle",
                  textAlign: TextAlign.center,
                  style: TextStyles().textStylePoppins(
                    size: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                SizedBox(height: 10),
                CommonElevatedButton(
                  text: "yes_delete".tr(),
                  onPressed: () {
                    borrowController2.deleteborrowCustomer(index);
                    Get.back();
                  },
                  progressColor: AppColors.grey,
                  backgroundColor: AppColors.primaryColor,
                  disabledBackgroundColor: AppColors.grey,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "No_delete".tr(),
                    style: TextStyles().textStylePoppins(
                      size: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openWhatsApp(
    Map<String, dynamic> customer, {
    String countryCode = '+91',
  }) async {
    String phoneNumber = customer['phone']?.trim() ?? '';
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        "Error",
        "Phone number is missing",
        backgroundColor: Colors.red,
      );
      return;
    }
    if (!phoneNumber.startsWith('+')) {
      phoneNumber = '$countryCode$phoneNumber';
    }
    final String message = 'Hello ${customer['name']}, how can I assist you?';
    final String encodedMessage = Uri.encodeComponent(message);
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );

    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not open WhatsApp",
        backgroundColor: Colors.red,
      );
    }
  }
}
