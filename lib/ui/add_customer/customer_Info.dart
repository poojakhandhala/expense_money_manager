import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/controller/customer_api_controller.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/add_customer.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customer_controller.dart';

class CustomerInfoPage extends StatefulWidget {
  @override
  _CustomerInfoPageState createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  List<Map<String, dynamic>> customers = [];
  final CustomerController customerController = Get.put(
    CustomerController(),
    permanent: true,
  );
  final CustomerApiController customerApiController = Get.put(
    CustomerApiController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: CommonAppBar(title: "customer_Info"),
      body: Obx(() {
        if (customerApiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return customerApiController.customersApi.isEmpty
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
              itemCount: customerApiController.customersApi.length,
              itemBuilder: (context, index) {
                var customer = customerApiController.customersApi[index];
                // String name = customer["name"] ?? "";
                // String phone = customer["phone"] ?? "No Contact";
                // int givenAmount = customer["givenAmount"] ?? 0;
                // int takenAmount = customer["takenAmount"] ?? 0;
                // int balance = givenAmount - takenAmount;
                // String initials =name.isNotEmpty? name.trim().split(' ').map((word) => word[0]).take(2).join().toUpperCase(): "";
                // return ListTile(
                //   title: Text(customer.name ?? ""),
                //   subtitle: Text("Phone: ${customer.phone}"),
                //   trailing: IconButton(
                //     icon: Icon(Icons.delete, color: Colors.red),
                //     onPressed: () {},
                //   ),
                // );
                return GestureDetector(
                  // onTap: () {
                  //   customerController.selectCustomer(index);
                  //   Get.to(
                  //     () => CustomerDetailPage(customer: customer),
                  //   )?.then((_) {
                  //     customerController.selectedCustomerIndex.refresh();
                  //   });
                  // },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(),
                    // decoration: BoxDecoration(
                    //   color: AppColors.white,
                    //   borderRadius: BorderRadius.circular(15),
                    //   border: Border.all(
                    //     color:
                    //         customerController
                    //                     .selectedCustomerIndex
                    //                     .value ==
                    //                 index
                    //             ? AppColors.primaryColor
                    //             : AppColors.lightGrey1,
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: AppColors.primaryColor,
                          //   child: Text(
                          //     initials,
                          //     style: TextStyles().textStylePoppins(
                          //       size: 14,
                          //       color: AppColors.white,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer.name ?? "No Name",
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
                                "Contact No:${customer.phone}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyles().textStylePoppins(
                                  size: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ).tr(),
                              // Text(
                              //   "Pending Balance: ₹$balance",
                              //   style: TextStyles().textStylePoppins(
                              //     size: 14,
                              //     fontWeight: FontWeight.bold,
                              //     color:
                              //         balance < 0
                              //             ? Colors.red
                              //             : Colors.green,
                              //   ),
                              // ).tr(),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap:
                                  () => openWhatsApp({
                                    'name': customer.name,
                                    'phone': customer.phone,
                                  }),
                              child: Image.asset(
                                AssetsPath.whatsapp,
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () => showDeleteDialog(customer.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ),
                );
              },
            );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          await Get.to(() => AddCustomerForm());
          customerApiController
              .fetchCustomers(); // **Refresh the list after adding**
        },
        // onPressed: () => Get.to(() => AddCustomerForm()),
        child: Icon(Icons.add, size: 24, color: AppColors.white),
      ),
    );
  }

  void showDeleteDialog(int? customerId) {
    if (customerId == null) {
      Get.snackbar("Error", "Invalid customer ID", backgroundColor: Colors.red);
      return;
    }
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
                    // customerController.deleteCustomer(index);
                    // Get.back();
                    customerApiController.deleteCustomer(customerId);
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
