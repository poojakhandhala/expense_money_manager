import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/controller/customer_api_controller.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  List<Map<String, dynamic>> customers = [];
  final CustomerController customerController = Get.put(
    CustomerController(),
    permanent: true,
  );
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final CustomerApiController customerApiController = Get.find();

  void _saveCustomer() {
    if (_nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Name is required");
      return;
    }
    if (_phoneController.text.trim().length != 10) {
      Get.snackbar("Error", "Enter a valid 10-digit phone number");
      return;
    }
    if (_emailController.text.trim().isNotEmpty &&
        !RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        ).hasMatch(_emailController.text.trim())) {
      Get.snackbar("Error", "Enter a valid email address");
      return;
    }
    Map<String, dynamic> customerData = {
      "name": _nameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "email": _emailController.text.trim(), // Added email
      "address": "123 Main Street",
    };

    customerApiController.addCustomer(customerData);
    // customerApiController.addCustomer(
    //   _nameController.text,
    //   _phoneController.text,
    // );

    _nameController.clear();
    _phoneController.clear();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: "add_customer"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "customer_name",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            SizedBox(height: 10),
            CommonEditTextField(
              hintText: "name".tr(),
              textEditingController: _nameController,
            ),
            SizedBox(height: 15),
            Text(
              "contact_no",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),

            SizedBox(height: 10),
            CommonEditTextField(
              textEditingController: _phoneController,
              textInputType: TextInputType.phone,
              hintText: "phone".tr(),
              isPhoneField: true,
              maxLength: 10,
            ),
            SizedBox(height: 20),
            Text(
              "email",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            SizedBox(height: 10),
            CommonEditTextField(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              hintText: "email".tr(),
            ),
            SizedBox(height: 20),
            CommonElevatedButton(
              // onPressed: () {
              //   if (_nameController.text.trim().isEmpty) {
              //     Get.snackbar(
              //       "error".tr(),
              //       "name_required".tr(),
              //       backgroundColor: Colors.red,
              //       colorText: Colors.white,
              //     );
              //     return;
              //   }
              //   if (_phoneController.text.trim().length != 10 ||
              //       !RegExp(
              //         r'^[0-9]+$',
              //       ).hasMatch(_phoneController.text.trim())) {
              //     Get.snackbar(
              //       "error".tr(),
              //       "10_digit_phone".tr(),
              //       backgroundColor: Colors.red,
              //       colorText: Colors.white,
              //     );
              //     return;
              //   }
              //
              //   customerController.addCustomer(
              //     _nameController.text,
              //     _phoneController.text,
              //     givenAmount: 0,
              //     takenAmount: 0,
              //   );
              //
              //   // Clear inputs
              //   _nameController.clear();
              //   _phoneController.clear();
              //
              //   Get.back();
              // },
              onPressed: _saveCustomer,
              // onPressed: () {
              //   if (_nameController.text.trim().isEmpty ||
              //       _phoneController.text.trim().isEmpty) {
              //     Get.snackbar("Error", "Name and phone are required!");
              //     return;
              //   }
              //
              //   customerApiController.addCustomer(
              //     _nameController.text.trim(),
              //     _phoneController.text.trim(),
              //   );
              //
              //   _nameController.clear();
              //   _phoneController.clear();
              // },
              text: 'save'.tr(),
              progressColor: AppColors.white,
              backgroundColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
