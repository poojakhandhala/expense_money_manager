import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/balance_page.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/ui/add_customer/customer_detail.dart';
import 'package:expense_money_manager/ui/borrow/borrow_addform.dart';
import 'package:expense_money_manager/ui/discount/discount_controller.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:expense_money_manager/utils/formated_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InterestDetailPage extends StatelessWidget {
  final DiscountController discountController = Get.put(DiscountController());
  final CustomerController customerController = Get.put(
    CustomerController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: 'given_interest'),
      body: Obx(
        () =>
            discountController.discount.isEmpty
                ? Center(
                  child: Text(
                    "no_given_data".tr(),
                    style: TextStyles().textStylePoppins(
                      size: 18,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: discountController.discount.length,
                  itemBuilder: (context, index) {
                    var transaction = discountController.discount[index];
                    return GestureDetector(
                      onTap: () {
                        discountController.selectDiscountCustomer(index);
                        var selectedCustomer =
                            discountController.discount[index];
                        Get.to(
                          () => CustomerDetailPage(
                            customer: selectedCustomer,
                            isDiscountPage: true,
                          ),
                        )?.then((_) {
                          customerController.selectedCustomerIndex.refresh();
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction["name"] ?? "Unknown",
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
                                        "Amount: ${transaction["balance"].abs()}",
                                        style: TextStyles().textStylePoppins(
                                          size: 14,
                                          fontWeight: FontWeight.w500,
                                          // color: balance < 0 ? Colors.red : Colors.green,
                                        ),
                                      ).tr(),
                                      Text(
                                        "Installment Amount: ${transaction["installmentAmount"] ?? 0}",
                                      ),
                                      Text(
                                        "Discount: ${transaction["discount"] ?? '0'}%",
                                      ),
                                      Text(
                                        "Interest Date: ${formatVyajDate(transaction["vyajDate"])}",
                                      ),
                                      // Text(
                                      //   "Interest Date: ${transaction["vyajDate"]}",
                                      // ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () => openWhatsApp(transaction),
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
                                  _buildTransactionButton(
                                    'Given',
                                    true,
                                    index,
                                    transaction,
                                  ),
                                  const SizedBox(width: 10),
                                  _buildTransactionButton(
                                    'Taken',
                                    false,
                                    index,
                                    transaction,
                                  ),
                                  SizedBox(width: 70),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onTap: () => showDeleteDialog(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => BorrowAddForm(isDiscount: true));
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTransactionButton(
    String label,
    bool isGiven,
    int index,
    Map<String, dynamic> transaction,
  ) {
    return SizedBox(
      height: 40,
      width: 100,
      child: CommonElevatedButton(
        onPressed: () async {
          Map<String, dynamic>? updatedTransaction = await Get.to(
            () => UpdateBalancePage(customer: transaction, isGiven: isGiven),
          );
          if (updatedTransaction != null) {
            discountController.updateDiscountBalance(
              transaction["name"],
              isGiven,
              updatedTransaction["amount"],
              transaction["description"],
              transaction["discount"],
            );
          }
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
              color: AppColors.white,
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
                    discountController.deleteDiscountCustomer(index);
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

// child: ListTile(
// title: Text(
// transaction["name"] ?? "Unknown",
// style: TextStyles().textStylePoppins(
// size: 16,
// fontWeight: FontWeight.bold,
// color: AppColors.black,
// ),
// ),
// subtitle: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Date: ${transaction["date"]}"),
// Text("Description: ${transaction["description"]}"),
// Text("Pending Balance:${transaction["balance"]}"),
// Text(
// "Discount: ${transaction["discount"] ?? '0'}%",
// ),
// Text("Interest Date: ${transaction["vyajDate"]}"),
// ],
// ),
// trailing: IconButton(
// icon: Icon(Icons.delete, color: Colors.red),
// onPressed: () {
// discountController.discount.removeAt(index);
// discountController.saveDiscountCustomers();
// },
// ),
// ),

// Obx(
// () => ListView.builder(
// itemCount: borrowController.borrowList.length,
// itemBuilder: (context, index) {
// final transaction = borrowController.borrowList[index];
// if (transaction["transactionType"] == "Given") {
// return TransactionCard(transaction: transaction);
// }
// return SizedBox.shrink();
// },
// ),
// ),
//
// Obx(
// () => ListView.builder(
// itemCount: borrowController.borrowList.length,
// itemBuilder: (context, index) {
// final transaction = borrowController.borrowList[index];
// if (transaction["transactionType"] == "Taken") {
// return TransactionCard(transaction: transaction);
// }
// return SizedBox.shrink();
// },
// ),
// ),

// Example: Given Button

// ElevatedButton(
// onPressed: () {
// int amount = int.tryParse(_amountController.text.trim()) ?? 0;
// if (amount > 0) {
// borrowController2.updateborrowBalance(_selectedCustomerName!, true, amount);
// discountController.updateDiscountBalance(_selectedCustomerName!, true, amount, 10);
// }
// },
// child: Text("Given"),
// ),
//
// // Example: Taken Button
// ElevatedButton(
// onPressed: () {
// int amount = int.tryParse(_amountController.text.trim()) ?? 0;
// if (amount > 0) {
// borrowController2.updateborrowBalance(_selectedCustomerName!, false, amount);
// discountController.updateDiscountBalance(_selectedCustomerName!, false, amount, 10);
// }
// },
// child: Text("Taken"),
// ),
