import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/transction_card.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/ui/add_customer/customer_detail.dart';
import 'package:expense_money_manager/ui/borrow/borrow_addform.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller2.dart';
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
  final CustomerController customerController = Get.put(
    CustomerController(),
    permanent: true,
  );
  // final BorrowController borrowController = Get.put(BorrowController());

  final BorrowController2 borrowController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: "borrow_lent_detail"),

      // bottom: TabBar(
      //   labelColor: AppColors.black,
      //   indicatorColor: AppColors.primaryColor,
      //   indicatorSize: TabBarIndicatorSize.label,
      //   labelStyle: TextStyles().textStylePoppins(
      //     size: 14,
      //     color: AppColors.black,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   tabs: [
      //     Tab(text: 'given'.tr()), // First tab
      //     Tab(text: 'taken'.tr()), // Second tab
      //   ],
      // ),
      body: Obx(
        () =>
            borrowController.borrow.isEmpty
                ? Center(
                  child:
                      Text(
                        "no_customer",
                        style: TextStyles().textStylePoppins(
                          size: 14,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr(),
                )
                : ListView.builder(
                  itemCount: borrowController.borrow.length,
                  itemBuilder: (context, index) {
                    final transaction = borrowController.borrow[index];
                    return GestureDetector(
                      onTap: () {
                        borrowController.selectborrowCustomer(index);
                        var selectedCustomer = borrowController.borrow[index];
                        Get.to(
                          () => CustomerDetailPage(
                            customer: selectedCustomer,
                            isDiscountPage: false,
                          ),
                        )?.then((_) {
                          customerController.selectedCustomerIndex.refresh();
                        });
                      },
                      child: TransactionCard(
                        transaction: transaction,
                        index: index,
                      ),
                    );
                  },
                ),
      ),
      // body: Obx(
      //   () =>
      //       customerController.customers.isEmpty
      //           ? Center(
      //             child:
      //                 Text(
      //                   "no_customer",
      //                   style: TextStyles().textStylePoppins(
      //                     size: 14,
      //                     color: AppColors.black,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ).tr(),
      //           )
      //           : ListView.builder(
      //             itemCount: customerController.customers.length,
      //             itemBuilder: (context, index) {
      //               var customer = customerController.customers[index];
      //               String name = customer["name"] ?? "";
      //               String phone = customer["phone"] ?? "";
      //               int givenAmount = customer["givenAmount"] ?? 0;
      //               int takenAmount = customer["takenAmount"] ?? 0;
      //               int balance = givenAmount - takenAmount;
      //               // String initials =name.isNotEmpty? name.trim().split(' ').map((word) => word[0]).take(2).join().toUpperCase(): "";
      //
      //               return GestureDetector(
      //                 onTap: () {
      //                   customerController.selectCustomer(index);
      //                   Get.to(
      //                     () => CustomerDetailPage(customer: customer),
      //                   )?.then((_) {
      //                     customerController.selectedCustomerIndex.refresh();
      //                   });
      //                 },
      //                 child: Card(
      //                   margin: EdgeInsets.symmetric(
      //                     horizontal: 15,
      //                     vertical: 5,
      //                   ),
      //                   shape: RoundedRectangleBorder(),
      //                   // decoration: BoxDecoration(
      //                   //   color: AppColors.white,
      //                   //   borderRadius: BorderRadius.circular(15),
      //                   //   border: Border.all(
      //                   //     color:
      //                   //         customerController
      //                   //                     .selectedCustomerIndex
      //                   //                     .value ==
      //                   //                 index
      //                   //             ? AppColors.primaryColor
      //                   //             : AppColors.lightGrey1,
      //                   //   ),
      //                   // ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.symmetric(
      //                       horizontal: 12,
      //                       vertical: 10,
      //                     ),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             // CircleAvatar(
      //                             //   backgroundColor: AppColors.primaryColor,
      //                             //   child: Text(
      //                             //     initials,
      //                             //     style: TextStyles().textStylePoppins(
      //                             //       size: 14,
      //                             //       color: AppColors.white,
      //                             //       fontWeight: FontWeight.w500,
      //                             //     ),
      //                             //   ),
      //                             // ),
      //                             // SizedBox(width: 10),
      //                             Column(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(
      //                                   name,
      //                                   maxLines: 1,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   softWrap: true,
      //                                   style: TextStyles().textStylePoppins(
      //                                     size: 16,
      //                                     color: AppColors.black,
      //                                     fontWeight: FontWeight.bold,
      //                                   ),
      //                                 ),
      //                                 Text(
      //                                   "Contact No: $phone",
      //                                   maxLines: 1,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   softWrap: true,
      //                                   style: TextStyles().textStylePoppins(
      //                                     size: 14,
      //                                     color: AppColors.black,
      //                                     fontWeight: FontWeight.w500,
      //                                   ),
      //                                 ).tr(),
      //                                 Text(
      //                                   "Pending Balance: ₹$balance",
      //                                   style: TextStyles().textStylePoppins(
      //                                     size: 14,
      //                                     fontWeight: FontWeight.bold,
      //                                     color:
      //                                         balance < 0
      //                                             ? Colors.red
      //                                             : Colors.green,
      //                                   ),
      //                                 ).tr(),
      //                               ],
      //                             ),
      //                             Spacer(),
      //                             GestureDetector(
      //                               onTap: () => openWhatsApp(customer),
      //                               child: Image.asset(
      //                                 AssetsPath.whatsapp,
      //                                 height: 25,
      //                                 width: 25,
      //                               ),
      //                             ),
      //                             // GestureDetector(
      //                             //   child: Icon(
      //                             //     Icons.delete,
      //                             //     color: AppColors.primaryColor,
      //                             //   ),
      //                             //   // onTap: () => showDeleteDialog(index),
      //                             // ),
      //                           ],
      //                         ),
      //                         SizedBox(height: 10),
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             SizedBox(
      //                               height: 40,
      //                               width: 100,
      //                               child: CommonElevatedButton(
      //                                 onPressed:
      //                                     () => Get.to(
      //                                       () => UpdateBalancePage(
      //                                         customer: customer,
      //                                         isGiven: true,
      //                                       ),
      //                                     ),
      //                                 text: 'given'.tr(),
      //                                 backgroundColor: AppColors.primaryColor,
      //                                 progressColor: AppColors.white,
      //                                 disabledBackgroundColor: AppColors.grey,
      //                               ),
      //                             ),
      //                             SizedBox(width: 10),
      //                             SizedBox(
      //                               height: 40,
      //                               width: 100,
      //                               child: CommonElevatedButton(
      //                                 onPressed:
      //                                     () => Get.to(
      //                                       () => UpdateBalancePage(
      //                                         customer: customer,
      //                                         isGiven: false,
      //                                       ),
      //                                     ),
      //                                 text: 'taken'.tr(),
      //                                 backgroundColor: AppColors.primaryColor,
      //                                 progressColor: AppColors.white,
      //                                 disabledBackgroundColor: AppColors.grey,
      //                               ),
      //                             ),
      //                             SizedBox(width: 70),
      //                             GestureDetector(
      //                               child: Icon(
      //                                 Icons.delete,
      //                                 color: AppColors.primaryColor,
      //                               ),
      //                               onTap: () => showDeleteDialog(index),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 // ),
      //               );
      //             },
      //           ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => BorrowAddForm(isDiscount: false));
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// onTap: () {
//   borrowController.selectborrowCustomer(index);
//   var selectedCustomer = borrowController.borrow[index];
//   Get.to(
//     () => CustomerDetailPage(customer: selectedCustomer),
//   )?.then((_) {
//     customerController.selectedCustomerIndex.refresh();
//   });
// },
