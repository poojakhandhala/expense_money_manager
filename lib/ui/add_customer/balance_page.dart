import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller2.dart';
import 'package:expense_money_manager/ui/discount/discount_controller.dart';
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
  final BorrowController2 borrowController2 = Get.find<BorrowController2>();
  final DiscountController discountController = Get.find<DiscountController>();

  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDate = now;
    _dateController.text = DateFormat('dd/MM/yyyy').format(now);
    // _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
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
    String customerName = widget.customer["name"];
    bool isGiven = widget.isGiven;
    String description = _descriptionController.text.trim();
    int discountPercentage = discountController.getDiscountPercentage(
      customerName,
      amount,
    );

    // Update Borrow Balance
    borrowController2.updateborrowBalance(
      customerName,
      isGiven,
      amount,
      description,
    );

    // Update Discount Balance
    discountController.updateDiscountBalance(
      customerName,
      isGiven,
      amount,
      description,
      discountPercentage,
    );

    // borrowController2.updateborrowBalance(
    //   widget.customer["name"],
    //   widget.isGiven,
    //   amount,
    //   _descriptionController.text.trim(),
    //
    //   // widget.isGiven,
    //   // amount,
    //   // _descriptionController.text.trim().isNotEmpty
    //   //     ? _descriptionController.text.trim()
    //   //     : "",
    // );
    //
    Get.back();
  }

  void _saveTransaction1() {
    if (_amountController.text.trim().isEmpty) {
      Get.snackbar(
        "error".tr(),
        "enter_amount".tr(),
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

    String customerName = widget.customer["name"];
    bool isGiven = widget.isGiven;
    String description = _descriptionController.text.trim();

    int discountPercentage = discountController.getDiscountPercentage(
      customerName,
      amount,
    );

    // Update Borrow Balance
    borrowController2.updateborrowBalance(
      customerName,
      isGiven,
      amount,
      description,
    );

    discountController.updateDiscountBalance(
      customerName,
      isGiven,
      amount,
      description,
      discountPercentage,
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
                  onTap: () => _selectDate(context),
                  child: Icon(
                    Icons.date_range,
                    color: AppColors.black,
                    size: 24,
                  ),
                ),
                onTap: () => _selectDate(context),
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
                onPressed: _saveTransaction1,
                text: 'submit'.tr(),
                progressColor: AppColors.white,
                backgroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
