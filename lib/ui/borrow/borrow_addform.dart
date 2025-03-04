import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/customer_controller.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller2.dart';
import 'package:expense_money_manager/ui/discount/discount_controller.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BorrowAddForm extends StatefulWidget {
  final bool isDiscount;
  const BorrowAddForm({Key? key, this.isDiscount = false}) : super(key: key);
  @override
  State<BorrowAddForm> createState() => _BorrowAddFormState();
}

class _BorrowAddFormState extends State<BorrowAddForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _vyajDateController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _installmentController = TextEditingController();

  String? _selectedCustomerName;
  String _transactionType = "Given";
  String _amountHint = "Enter Given Amount";
  // final BorrowController borrowController = Get.put(
  //   BorrowController(),
  //   permanent: true,
  // );

  final BorrowController2 borrowController2 = Get.find();
  final DiscountController discountController = Get.find();
  final CustomerController customerController = Get.put(
    CustomerController(),
    permanent: true,
  );
  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _vyajDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
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

  void _submitForm2() async {
    if (_selectedCustomerName == null ||
        _selectedCustomerName!.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all required fields!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    int? amount = int.tryParse(_amountController.text.replaceAll(",", ""));
    int? discountPercentage = int.tryParse(_percentageController.text) ?? 0;

    if (amount == null || amount <= 0) {
      Get.snackbar(
        "Invalid Input",
        "Enter a valid amount",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Calculate Discount
    double discountAmount = (amount * discountPercentage) / 100;
    int finalBalance = amount - discountAmount.toInt();

    // Calculate installment amount directly when isDiscount is true
    int installmentAmount =
        widget.isDiscount
            ? (finalBalance ~/ 12)
            : 0; // Example: Dividing into 12 months

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await Future.delayed(Duration(seconds: 1));

    String transactionType = _transactionType;
    String vyajDate = _vyajDateController.text;

    if (widget.isDiscount) {
      Get.find<DiscountController>().addDiscountCustomer(
        _selectedCustomerName!.trim(),
        givenAmount: transactionType == "Given" ? finalBalance : 0,
        takenAmount: transactionType == "Taken" ? finalBalance : 0,
        vyajDate: vyajDate,
        discountPercentage: discountPercentage,
        installmentAmount: installmentAmount, // Direct calculation
      );
    } else {
      borrowController2.addborrowCustomer(
        _selectedCustomerName!.trim(),
        givenAmount: transactionType == "Given" ? finalBalance : 0,
        takenAmount: transactionType == "Taken" ? finalBalance : 0,
      );
    }

    Get.back();
    Get.snackbar(
      "Success",
      "Transaction added successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    _descriptionController.clear();
    _amountController.clear();
    _percentageController.clear();
    _installmentController.clear();
    _transactionType = "Given";
    _amountHint = "Enter Given Amount";
    _selectedCustomerName = null;
    _nameController.clear();

    borrowController2.update();
    discountController.update();
    setState(() {});
    Get.back();
  }

  void _submitForm() async {
    if (_selectedCustomerName == null ||
        _selectedCustomerName!.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        // _percentageController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all required fields!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    int? amount = int.tryParse(_amountController.text.replaceAll(",", ""));
    if (amount == null || amount <= 0) {
      Get.snackbar(
        "Invalid Amount",
        "Enter a valid amount",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    await Future.delayed(Duration(seconds: 1));

    String transactionType = _transactionType ?? "Given";

    int? discountPercentage = int.tryParse(_percentageController.text) ?? 0;
    String vyajDate = _vyajDateController.text;
    if (widget.isDiscount) {
      Get.find<DiscountController>().addDiscountCustomer(
        _selectedCustomerName!.trim(),
        givenAmount: amount ?? 0,
        vyajDate: vyajDate,
        discountPercentage: discountPercentage,
      );
    } else {
      borrowController2.addborrowCustomer(
        _selectedCustomerName!.trim(),
        givenAmount: transactionType == "Given" ? amount : 0,
        takenAmount: transactionType == "Taken" ? amount : 0,
      );
    }

    Get.back();
    // working
    // borrowController2.addborrowCustomer(
    //   // _dateController.text.trim(),
    //   _selectedCustomerName!.trim(),
    //   // _descriptionController.text.trim(),
    //   givenAmount: transactionType == "Given" ? amount : 0,
    //   takenAmount: transactionType == "Taken" ? amount : 0,
    //   // transactionType,
    //   // amount,
    // );
    //
    // Get.back();

    Get.snackbar(
      "Success",
      "Transaction added successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    _descriptionController.clear();
    _amountController.clear();
    _percentageController.clear();
    _transactionType = "Given";
    _amountHint = "Enter Given Amount";
    _selectedCustomerName = null;
    _nameController.clear();

    borrowController2.update();
    discountController.update();
    setState(() {});
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        title:
            widget.isDiscount
                ? 'given_interest_add'.tr()
                : 'borrow_lent_add'.tr(),
      ),
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
                  onTap: () => _selectDate(context, _dateController),
                  child: Icon(
                    Icons.date_range,
                    color: AppColors.black,
                    size: 24,
                  ),
                ),
                onTap: () => _selectDate(context, _dateController),
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
              SizedBox(height: 10),

              if (widget.isDiscount)
                Column(
                  children: [
                    CommonEditTextField(
                      hintText: "enter_discount_percentage".tr(),
                      textEditingController: _percentageController,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),

                    CommonEditTextField(
                      hintText: "select_expense_date".tr(),
                      textEditingController: _vyajDateController,
                      readOnly: true,
                      suffixIcon: GestureDetector(
                        onTap: () => _selectDate(context, _vyajDateController),
                        child: Icon(
                          Icons.date_range,
                          color: AppColors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              CommonElevatedButton(
                onPressed: _submitForm2,
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
