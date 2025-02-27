import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BorrowAddForm extends StatefulWidget {
  @override
  State<BorrowAddForm> createState() => _BorrowAddFormState();
}

class _BorrowAddFormState extends State<BorrowAddForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCustomerName;
  String _transactionType = "Given";
  String _amountHint = "Enter Given Amount";
  final BorrowController borrowController = Get.find<BorrowController>();
  final CustomerController customerController = Get.find<CustomerController>();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
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

  void _handleTransactionType(String type) {
    setState(() {
      _transactionType = type;
      _amountHint =
          type == "Given" ? "enter_given_amount" : "enter_taken_amount";
    });
  }

  void _submitForm() {
    if (_selectedCustomerName == null ||
        _descriptionController.text.isEmpty ||
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fill_fields").tr(),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("enter_amount").tr(),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    borrowController.addTransaction({
      "date": _dateController.text,
      "customer": _selectedCustomerName,
      "description": _descriptionController.text,
      "transactionType": _transactionType,
      "amount": amount.toStringAsFixed(2),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("transaction_add").tr(),
        backgroundColor: Colors.green,
      ),
    );

    _descriptionController.clear();
    _amountController.clear();
    _transactionType = "Given";
    _amountHint = "enter_given_amount";
    _selectedCustomerName = null;
    _nameController.clear();

    setState(() {});
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: 'borrow_lent'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Field
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
              SizedBox(height: 10),

              CommonEditTextField(
                hintText: "select_name".tr(),
                textEditingController: _nameController,
                isDropdown: true,
                dropdownItems:
                    customerController.customers
                        .map<String>((customer) => customer["name"])
                        .toList(),
                onChange: (value) {
                  setState(() {
                    _selectedCustomerName = value;
                    _nameController.text = value;
                  });
                },
              ),

              SizedBox(height: 10),
              // Description Field
              CommonEditTextField(
                hintText: "enter_description".tr(),
                textEditingController: _descriptionController,
              ),
              SizedBox(height: 10),

              Text(
                "transaction_type",
                style: TextStyles().textStylePoppins(
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ).tr(),
              Row(
                children: [
                  Radio(
                    activeColor: AppColors.primaryColor,
                    value: "Given",
                    groupValue: _transactionType,
                    onChanged:
                        (value) => _handleTransactionType(value as String),
                  ),
                  Text(
                    "given",
                    style: TextStyles().textStylePoppins(
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ).tr(),
                  SizedBox(width: 20),
                  Radio(
                    activeColor: AppColors.primaryColor,

                    value: "Taken",
                    groupValue: _transactionType,
                    onChanged:
                        (value) => _handleTransactionType(value as String),
                  ),
                  Text(
                    "taken",
                    style: TextStyles().textStylePoppins(
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ).tr(),
                ],
              ),
              SizedBox(height: 10),

              CommonEditTextField(
                hintText: _amountHint.tr(),
                textEditingController: _amountController,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 20),

              CommonElevatedButton(
                onPressed: _submitForm,
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
