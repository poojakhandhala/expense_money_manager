import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'customer_controller.dart';

class UpdateBalancePage extends StatefulWidget {
  final Map<String, dynamic> customer;
  final bool isGiven;

  UpdateBalancePage({required this.customer, required this.isGiven});

  @override
  _UpdateBalancePageState createState() => _UpdateBalancePageState();
}

class _UpdateBalancePageState extends State<UpdateBalancePage> {
  final CustomerController customerController = Get.find();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveTransaction() {
    if (_amountController.text.trim().isEmpty) {
      Get.snackbar(
        "error".tr(),
        "enter_amount".tr(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedDate == null) {
      Get.snackbar(
        "error".tr(),
        "selected_date".tr(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    int amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) {
      Get.snackbar(
        "error".tr(),
        "amount_digit".tr(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    customerController.updateBalance(
      widget.customer["phone"],
      widget.isGiven,
      amount,
      _selectedDate!,
      _descriptionController.text.trim(),
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        title: widget.isGiven ? "given_amount" : "taken_amount",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "date",
                style: TextStyles().textStylePoppins(
                  size: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              SizedBox(height: 10),
              CommonEditTextField(
                hintText: "select_date".tr(),
                textEditingController: _dateController,
                readOnly: true,
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(),
                  child: Icon(
                    Icons.date_range,
                    color: AppColors.black,
                    size: 24,
                  ),
                ),
                onTap: () => _selectDate(),
              ),

              SizedBox(height: 15),
              Text(
                "description",
                style: TextStyles().textStylePoppins(
                  size: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              SizedBox(height: 10),
              CommonEditTextField(
                hintText: "enter_description".tr(),
                textEditingController: _descriptionController,
              ),
              SizedBox(height: 15),
              Text(
                widget.isGiven ? "given_amount" : "taken_amount",
                style: TextStyles().textStylePoppins(
                  size: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              SizedBox(height: 10),
              CommonEditTextField(
                hintText:
                    widget.isGiven
                        ? "enter_given_amount".tr()
                        : "enter_taken_amount".tr(),
                textEditingController: _amountController,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 20),

              CommonElevatedButton(
                onPressed: _saveTransaction,
                text: 'submit'.tr(),
                progressColor: AppColors.white,
                backgroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.grey,
              ),
            ],
          ),
        ),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         "Date",
      //         style: TextStyles().textStylePoppins(
      //           size: 14,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: _selectDate,
      //         child: Container(
      //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //           margin: EdgeInsets.symmetric(vertical: 8),
      //           decoration: BoxDecoration(
      //             border: Border.all(color: AppColors.grey),
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: Text(
      //             _selectedDate != null
      //                 ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
      //                 : "Select Date",
      //             style: TextStyles().textStylePoppins(
      //               size: 14,
      //               color: AppColors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //       CommonEditTextField(
      //         hintText: "Description",
      //         textEditingController: _descriptionController,
      //       ),
      //       SizedBox(height: 10),
      //       CommonEditTextField(
      //         hintText: "Amount",
      //         textEditingController: _amountController,
      //         textInputType: TextInputType.number,
      //       ),
      //       SizedBox(height: 20),
      //       CommonElevatedButton(
      //         onPressed: _saveTransaction,
      //         text: "Save",
      //         backgroundColor: AppColors.primaryColor,
      //         progressColor: AppColors.white,
      //         disabledBackgroundColor: AppColors.grey,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
